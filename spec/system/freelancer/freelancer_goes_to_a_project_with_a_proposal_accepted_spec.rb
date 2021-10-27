require 'rails_helper'

describe 'Freelancer goes to a project with a proposal accepted proposal' do
    it 'and must be signed in' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
        javascript = Ability.create!({name: 'Javascript'})

        projeto_caio = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: caio})

        occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste primeiro tester', social_name:'teste primeiro tester_social', birth_date: '1995-04-03', occupation_area: occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        proposal1 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_caio})
        
        proposal1.accepted!
        visit project_path(projeto_caio)
        
        expect(page).to_not have_content('Time do Projeto:')
        expect(page).to_not have_link('teste primeiro tester_social')
    end

    it 'and see the team' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
        anderson = ProjectOwner.create!({email: 'anderson@gmail.com', password: '12345678'})
        javascript = Ability.create!({name: 'Javascript'})
              

        projeto_caio = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: caio})
        projeto_anderson = Project.create!({title: 'Projeto de Sistema do Anderson', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                        max_value: 200, deadline: 6.days.from_now, location: 'local', abilities: [javascript], project_owner: anderson})

        occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste primeiro tester', social_name:'teste primeiro tester_social', birth_date: '1995-04-03', occupation_area: occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        freelancer1 = Freelancer.create!({email: 'teste@tester1.com', password: '1234567'})
        profile_freelancer1 = freelancer1.profile.update!({full_name: 'teste tester1', social_name:'teste tester1_social', birth_date: '1995-04-04', occupation_area: occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas1'})

        proposal1 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_caio})
        proposal2 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto anderson', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_anderson})
        proposal3 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio - by 1', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer1, project: projeto_caio})
        proposal4 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto anderson - by 1', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer1, project: projeto_anderson})
        
        proposal1.accepted!
        proposal2.accepted!
        proposal4.accepted!
        login_as freelancer, scope: :freelancer
        visit root_path
        click_on 'Meus Projetos'
        click_on 'Projeto de Sistema'
        
        expect(page).to have_content('Time do Projeto:')
        expect(page).to have_link('teste primeiro tester_social')
        expect(page).to_not have_link('teste tester1_social')
    end
end