require 'rails_helper'

describe 'project owner do the feedback' do
    it 'and go to the feedback page' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
        javascript = Ability.create!({name: 'Javascript'})
              
        projeto_caio = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: caio})

        occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste primeiro tester', social_name:'teste primeiro tester_social', birth_date: '1995-04-03', occupation_area: occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        proposal1 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_caio})

        login_as caio, scope: :project_owner
        visit root_path
        proposal1.accepted!
        click_on 'Meus Projetos'
        click_on 'Projeto de Sistema'
        click_on 'Finalizar Projeto'
        click_on 'Realizar Feedback'
        
        expect(page).to have_content('Nota')
        expect(page).to have_content('Comentário')
        expect(page).to have_button('Enviar Feedback')
    end

    it 'and go to the feedback page' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
        javascript = Ability.create!({name: 'Javascript'})
              
        projeto_caio = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: caio})

        occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste primeiro tester', social_name:'teste primeiro tester_social', birth_date: '1995-04-03', occupation_area: occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        proposal1 = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_caio})

        login_as caio, scope: :project_owner
        visit root_path
        proposal1.accepted!
        click_on 'Meus Projetos'
        click_on 'Projeto de Sistema'
        click_on 'Finalizar Projeto'
        click_on 'Realizar Feedback'
        fill_in 'Nota', with: '4'
        fill_in 'Nome do Projeto', with: 'Projeto de Sistema'
        
        expect(page).to have_content('Nota')
        expect(page).to have_content('Comentário')
        expect(page).to have_button('Enviar Feedback')
    end
end
