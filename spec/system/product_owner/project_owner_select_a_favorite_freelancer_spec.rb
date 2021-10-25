require 'rails_helper'

describe 'Project Owner select a freelancer as a favorite' do
    it 'and got successfully' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})

        occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'Caio Free', social_name:'Caio Free', birth_date: '1995-04-03', occupation_area: occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        javascript = Ability.create!({name: 'Javascript'})
        projeto_caio = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
        max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: caio})

        proposal = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar projeto caio', hour_value: 30, hours:30, deadline_proposal: 10.days.from_now, freelancer: freelancer, project: projeto_caio})

        login_as caio, scope: :project_owner
        visit root_path
        click_on 'Meus Projetos'
        click_on 'Projeto de Sistema'
        click_on 'Caio Free'
        click_on 'Favoritar'

        expect(page).to have_content("Perfil de Caio Free")
        expect(page).to have_content("Freelancer Favorito")
        expect(page).to have_content("Nome Completo: #{freelancer.profile.full_name}")
        expect(page).to have_content("Nome Social: #{freelancer.profile.social_name}")
        expect(page).to have_content("Data de Nascimento: #{I18n.l(freelancer.profile.birth_date)}")
        expect(page).to have_content("Descrição: #{freelancer.profile.description}")
        expect(page).to have_link("Retirar dos Favoritos")
    end
end