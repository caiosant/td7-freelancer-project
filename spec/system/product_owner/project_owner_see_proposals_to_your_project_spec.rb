require 'rails_helper'

describe 'p.o see proposals' do
    it 'and got successfully' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
        anderson = ProjectOwner.create!({email: 'anderson@gmail.com', password: '12345678'})
        javascript = Ability.create!({name: 'Javascript'})
              

        projeto_caio = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'Presencial', abilities: [javascript], project_owner: caio})
        projeto_anderson = Project.create!({title: 'Projeto de Sistema do Anderson', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 6.days.from_now, location: 'Presencial', abilities: [javascript], project_owner: anderson})
        
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste tester', social_name:'', birth_date: '1995-04-03', description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        freelancer1 = Freelancer.create!({email: 'teste@tester1.com', password: '1234567'})
        profile_freelancer1 = freelancer1.profile.update!({full_name: 'teste tester1', social_name:'', birth_date: '1995-04-04', description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas1'})
        
        proposal1 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_caio})
        proposal2 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto anderson', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_anderson})
        proposal3 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio - by 1', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer1, project: projeto_caio})
        proposal4 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto anderson - by 1', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer1, project: projeto_anderson})

        login_as caio, scope: :project_owner
        visit root_path
        click_on 'Meus Projetos'
        click_on 'Projeto de Sistema'

        expect(page).to have_content('Projeto: Projeto de Sistema')
        expect(page).to have_content('Descrição: Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.')
        expect(page).to have_content('Valor Máximo por Hora: R$ 200,00')
        expect(page).to have_content(I18n.l(5.days.from_now.to_date()))
        expect(page).to have_content('Habilidade(s): Javascript')
        expect(page).to have_content('Forma de trabalho: Presencial')
        expect(page).to have_content('Propostas:')
        expect(page).to have_link('Visualizar Proposta Completa')
        expect(page).to have_content('Valor por hora: R$ 30,00')
        expect(page).to have_content('Previsão de entrega: ')
        expect(page).to have_content(I18n.l(10.days.from_now.to_date()))
        expect(page).to have_link('Aceitar Proposta')
        expect(page).to have_link('Rejeitar Proposta') 
    end

    it 'and go to the full proposal view' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
        anderson = ProjectOwner.create!({email: 'anderson@gmail.com', password: '12345678'})
        javascript = Ability.create!({name: 'Javascript'})
              

        projeto_caio = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'Presencial', abilities: [javascript], project_owner: caio})
        projeto_anderson = Project.create!({title: 'Projeto de Sistema do Anderson', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 6.days.from_now, location: 'Presencial', abilities: [javascript], project_owner: anderson})
        
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste tester', social_name:'teste tester', birth_date: '1995-04-03', description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        freelancer1 = Freelancer.create!({email: 'teste@tester1.com', password: '1234567'})
        profile_freelancer1 = freelancer1.profile.update!({full_name: 'teste tester1', social_name:'teste tester', birth_date: '1995-04-04', description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas1'})
        
        proposal1 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_caio})
        proposal2 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto anderson', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_anderson})
        proposal3 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio - by 1', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer1, project: projeto_caio})
        proposal4 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto anderson - by 1', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer1, project: projeto_anderson})

        login_as caio, scope: :project_owner
        visit root_path
        click_on 'Meus Projetos'
        click_on 'Projeto de Sistema'
        within "li##{proposal1.id}" do
            click_on 'Visualizar Proposta Completa'
        end

        expect(page).to have_content('Freelancer: ')
        expect(page).to have_link('teste tester')
        expect(page).to have_content('Valor por Hora: R$ 30,00')
        expect(page).to have_content('Quantidade de horas: 30')
        expect(page).to have_content('Motivação: Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio')
        expect(page).to have_content(I18n.t(proposal1.status))
        expect(page).to have_link('teste tester')
        expect(page).to have_link('Aceitar Proposta')
        expect(page).to have_link('Rejeitar Proposta')
    end
end
