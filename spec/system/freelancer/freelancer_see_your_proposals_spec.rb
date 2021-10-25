require 'rails_helper'

describe 'Freelancer goes to see his proposals' do
    it 'but does not have done a proposal yet' do
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})

        login_as freelancer, scope: :freelancer
        visit root_path
        fill_in 'Nome Completo', with: 'Teste nome completo'
        fill_in 'Nome Social', with: 'Teste social'
        fill_in 'Descrição', with: 'Testando a descrição do perfil'
        fill_in 'Data de Nascimento', with: '03/04/1995'
        attach_file 'Avatar', './app/assets/images/avatar_test.jpg'
        click_on 'Atualizar Perfil'
        click_on 'Minhas Propostas'

        expect(page).to have_content('Minhas Propostas')
        expect(page).to have_content('Você ainda não realizou propostas') 
    end

    it 'and do your first proposal' do
        project_owner = ProjectOwner.create!({email: 'testepo@teste.com', password: '1234567'})
        javascript = Ability.create!({name: 'Javascript'})
        projeto_po = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: project_owner})
        projeto_po2 = Project.create!({title: 'Projeto de Sistema 2.0', description: 'Este projeto da Handa 2.0 promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 300, deadline: 3.days.from_now, location: 'remotely', abilities: [javascript], project_owner: project_owner})
        
        
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste tester', social_name:'', birth_date: '1995-04-03', description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        freelancer2 = Freelancer.create!({email: 'teste2@tester.com', password: '1234567'})
        profile_freelancer2 = freelancer2.profile.update!({full_name: 'teste tester2', social_name:'', birth_date: '1995-04-03', description:'22Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas22'})
        proposal = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar nele', hour_value: 30, hours:30, freelancer: freelancer2, project: projeto_po2})
        
        login_as freelancer, scope: :freelancer
    
        visit root_path
        click_on 'Projetos Disponíveis'
        click_on 'Projeto de Sistema'
        fill_in 'Motivo da Aplicação', with: 'TESTANDO MOTIVO 12312131'
        fill_in 'Valor por Hora', with: 20.0
        fill_in 'Total de Horas', with: 20
        fill_in 'Previsão de entrega', with: 10.days.from_now
        click_on 'Enviar Proposta'
        click_on 'Minhas Propostas'

        expect(page).to have_content('Minhas Propostas')
        expect(page).to have_link('Projeto de Sistema')
        expect(page).to_not have_link('Projeto de Sistema 2.0')
        expect(page).to have_content('Habilidade(s): Javascript')
        expect(page).to have_content('Status: Pendente')
    end
end