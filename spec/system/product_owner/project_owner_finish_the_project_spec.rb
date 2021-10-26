require 'rails_helper'

describe 'project owner finish the project' do
    it 'and got successfully' do
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
        
        expect(page).to have_content('Projeto de Sistema')
        expect(page).to have_content('Descrição: Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.')
        expect(page).to have_content('Valor Máximo por Hora: R$ 200,00')
        expect(page).to have_content("Data Limite para Propostas: #{I18n.l(projeto_caio.deadline)}")
        expect(page).to have_content('Javascript')
        expect(page).to have_content('Forma de trabalho: Presencial')
        expect(page).to have_content('Finalizado')
        expect(page).to have_content('Time do Projeto:')
        expect(page).to have_link('teste primeiro tester_social')
        expect(page).to have_link('Fornecer feedback para: teste primeiro tester_social')
    end
end
