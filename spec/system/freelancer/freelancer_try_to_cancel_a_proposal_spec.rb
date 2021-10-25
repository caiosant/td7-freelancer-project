require 'rails_helper'

describe 'Freelancer try to cancel a proposal' do
    it 'and cancel his proposal when the proposal status is pending' do
        project_owner = ProjectOwner.create!({email: 'testepo@teste.com', password: '1234567'})
        javascript = Ability.create!({name: 'Javascript'})
        projeto_po = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                   max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: project_owner})
        
        occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})
        freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste tester', social_name:'', birth_date: '1995-04-03', occupation_area:occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        proposal = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar nele', hour_value: 30, hours:30, freelancer: freelancer, project: projeto_po})
        
        login_as freelancer, scope: :freelancer

        visit root_path
        click_on 'Minhas Propostas'
        within "li#cancel_proposal_#{proposal.id}" do
            click_on 'Cancelar Proposta'
        end

        expect(page).to have_content('Minhas Propostas')
        expect(page).to have_link('Projeto de Sistema')
        expect(page).to have_content('Habilidade(s): Javascript')
        expect(page).to have_content('Status: Cancelada')
        expect(page).to_not have_link('Cancelar Proposta')
    end

    it 'and cancel his proposal when the proposal status is accept more them 3 days' do
        travel_to 10.days.ago do
            project_owner = ProjectOwner.create!({email: 'testepo@teste.com', password: '1234567'})
            javascript = Ability.create!({name: 'Javascript'})
            
            projeto_po = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                    max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: project_owner})
            
            occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})
            freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
            freelancer.profile.update!({full_name: 'teste tester', social_name:'', birth_date: '1995-04-03', occupation_area:occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

            Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar nele', hour_value: 30, hours:30, freelancer: freelancer, project: projeto_po})
        end

        
        travel_to 10.days.ago do
            proposal = Proposal.find(1)
            proposal.accepted!
        end
        proposal = Proposal.find(1)
        freelancer = Freelancer.find(1)
        login_as freelancer, scope: :freelancer
        visit root_path
        click_on 'Minhas Propostas'

        expect(page).to have_content('Minhas Propostas')
        expect(page).to have_link('Projeto de Sistema')
        expect(page).to have_content('Habilidade(s): Javascript')
        expect(page).to have_content('Status: Aceita')
        expect(page).to_not have_link('Cancelar Proposta')
    end

    it 'and cancel his proposal when the proposal status is accept less them 3 days' do
        travel_to 2.days.ago do
            project_owner = ProjectOwner.create!({email: 'testepo@teste.com', password: '1234567'})
            javascript = Ability.create!({name: 'Javascript'})
            
            projeto_po = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                    max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: project_owner})
            
            occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})
            freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
            freelancer.profile.update!({full_name: 'teste tester', social_name:'', birth_date: '1995-04-03', occupation_area: occupation_area ,description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

            Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar nele', hour_value: 30, hours:30, freelancer: freelancer, project: projeto_po})
        end

        
        travel_to 2.days.ago do
            proposal = Proposal.find(1)
            proposal.accepted!
        end
        proposal = Proposal.find(1)
        freelancer = Freelancer.find(1)
        login_as freelancer, scope: :freelancer
        visit root_path
        click_on 'Minhas Propostas'
        within "li#cancel_proposal_#{proposal.id}" do
            click_on 'Cancelar Proposta'
        end

        expect(page).to have_content('Cancelar Proposta')
        expect(page).to have_content('Propostas aceitas necessitam de uma justificativa para o cancelamento.')
        expect(page).to have_content('Justificativa')
        expect(page).to have_button('Enviar Cancelamento de Proposta')
    end

    it 'and try leave the reason fild blank' do
        travel_to 2.days.ago do
            project_owner = ProjectOwner.create!({email: 'testepo@teste.com', password: '1234567'})
            javascript = Ability.create!({name: 'Javascript'})
            
            projeto_po = Project.create!({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                    max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: project_owner})
            
            occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})            
            freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})
            freelancer.profile.update!({full_name: 'teste tester', social_name:'', birth_date: '1995-04-03', occupation_area: occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

            Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar nele', hour_value: 30, hours:30, freelancer: freelancer, project: projeto_po})
        end

        
        travel_to 2.days.ago do
            proposal = Proposal.find(1)
            proposal.accepted!
        end
        proposal = Proposal.find(1)
        freelancer = Freelancer.find(1)
        login_as freelancer, scope: :freelancer
        visit root_path
        click_on 'Minhas Propostas'
        within "li#cancel_proposal_#{proposal.id}" do
            click_on 'Cancelar Proposta'
        end
        click_on 'Enviar Cancelamento de Proposta'

        expect(page).to have_content('Justificativa não pode ficar em branco')
        expect(page).to have_content('Justificativa é muito curto (mínimo: 30 caracteres)')
    end
end
    