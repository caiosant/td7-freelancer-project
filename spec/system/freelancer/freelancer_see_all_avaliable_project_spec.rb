require 'rails_helper'

describe 'Freelancer see all avaliable project' do
    it 'but doesnt have any' do
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste tester', social_name:'', birth_date: '1995-04-03', description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        login_as freelancer, scope: :freelancer
        visit root_path
        click_on 'Projetos Disponíveis'

        expect(page).to have_content('Não existem projetos disponíveis no momento')
    end

    it 'and view all' do
        project_owner = ProjectOwner.create!({email: 'testepo@teste.com', password: '1234567'})
        javascript = Ability.create!({name: 'Javascript'})
        projeto_po = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'Presencial', abilities: [javascript], project_owner: project_owner})
        projeto_po2 = Project.create!({title: 'Projeto de Sistema 2.0', description: 'Este projeto da Handa 2.0 promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 300, deadline: 3.days.from_now, location: 'Remoto', abilities: [javascript], project_owner: project_owner})

        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste tester', social_name:'', birth_date: '1995-04-03', description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        login_as freelancer, scope: :freelancer
        visit root_path
        click_on 'Projetos Disponíveis'

        expect(page).to have_link('Projeto de Sistema')
        expect(page).to have_content('Data Limite para Propostas:')
        expect(page).to have_content('Habilidade(s): Javascript')
    end

    it 'and search for a project' do
        project_owner = ProjectOwner.create!({email: 'testepo@teste.com', password: '1234567'})
        javascript = Ability.create!({name: 'Javascript'})
        projeto_po = Project.create!({title: 'Projeto Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'Presencial', abilities: [javascript], project_owner: project_owner})
        projeto_po2 = Project.create!({title: 'Projeto de Sistema 2.0', description: 'Este projeto da Handa 2.0 promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 300, deadline: 3.days.from_now, location: 'Remoto', abilities: [javascript], project_owner: project_owner})

        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste tester', social_name:'', birth_date: '1995-04-03', description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        login_as freelancer, scope: :freelancer
        visit root_path
        click_on 'Projetos Disponíveis'
        fill_in 'Busca:', with: '2.0'
        click_on 'Pesquisar'

        expect(current_path).to eq search_path
        expect(page).to_not have_link('Projeto Sistema')
        expect(page).to have_link('Projeto de Sistema 2.0')
        expect(page).to have_content('Data Limite para Propostas:')
        expect(page).to have_content('Habilidade(s): Javascript')
    end
end