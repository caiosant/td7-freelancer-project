require 'rails_helper'

describe 'project owner close the application,' do
    it 'got successfuly and freelancer can see the project' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
      
        javascript = Ability.create!({name: 'Javascript'})

        projeto_caio = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: caio})
        projeto_caio2 = Project.create!({title: 'Projeto Sistema 2.0', description: 'Projeto do caio 2.0 adsadadadasdadadasdadadsaddadasdadadsada', max_value: 120, deadline: 2.days.from_now, location: 'remotely', abilities: [javascript], project_owner: caio})
        
        occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste primeiro tester', social_name:'teste primeiro tester', birth_date: '1995-04-03', occupation_area: occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})
        
        proposal = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_caio})

        proposal.accepted!
        projeto_caio.closed!
        login_as freelancer, scope: :freelancer
        visit root_path
        click_on 'Meus Projetos'
        click_on 'Projeto de Sistema'

        expect(page).to have_content("Projeto: #{projeto_caio.title}")
        expect(page).to have_content("Descrição: #{projeto_caio.description}")
        expect(page).to have_content("Valor Máximo por Hora: R$ #{projeto_caio.max_value}")
        expect(page).to have_content("Data Limite para Propostas: #{I18n.l(projeto_caio.deadline)}")
        expect(page).to have_content("Habilidade(s): Javascript")
        expect(page).to have_content("Forma de trabalho: #{Project.human_enum_name(:locations, projeto_caio.location)}")
        expect(page).to_not have_content("Projeto: #{projeto_caio2.title}")
        expect(page).to_not have_content("Descrição: #{projeto_caio2.description}")
        expect(page).to_not have_content("Valor Máximo por Hora: R$ #{projeto_caio2.max_value}")
        expect(page).to_not have_content("Data Limite para Propostas: #{I18n.l(projeto_caio2.deadline)}")
        expect(page).to_not have_content("Forma de trabalho: #{Project.human_enum_name(:locations, projeto_caio2.location)}")
    end

    it 'got successfuly and freelancer cant see the project' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
      
        javascript = Ability.create!({name: 'Javascript'})

        projeto_caio = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: caio})
        projeto_caio2 = Project.create!({title: 'Projeto Sistema 2.0', description: 'Projeto do caio 2.0 adsadadadasdadadasdadadsaddadasdadadsada', max_value: 120, deadline: 2.days.from_now, location: 'remotely', abilities: [javascript], project_owner: caio})
        
        occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste primeiro tester', social_name:'teste primeiro tester', birth_date: '1995-04-03', occupation_area: occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})
        
        proposal = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_caio})
        proposal1 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_caio2})

        proposal.rejected!
        proposal1.accepted!
        projeto_caio.closed!
        login_as freelancer, scope: :freelancer
        visit root_path
        click_on 'Meus Projetos'

        expect(page).to have_content("Projeto: #{projeto_caio2.title}")
        expect(page).to have_content("Data Limite para Propostas: #{I18n.l(projeto_caio2.deadline)}")
        expect(page).to_not have_content("Projeto: #{projeto_caio.title}")
        expect(page).to_not have_content("Data Limite para Propostas: #{I18n.l(projeto_caio.deadline)}")
    end
end