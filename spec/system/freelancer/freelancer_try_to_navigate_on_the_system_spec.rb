require 'rails_helper'

describe 'Freelancer try to navigate on the application' do
    context 'but hasnt a filled profile' do
        it 'so goes to the edit profile page' do
            freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})

            login_as freelancer, scope: :freelancer
            visit root_path

            expect(page).to have_content('Meu Perfil - Editar')
            expect(page).to have_content('Nome Completo')
            expect(page).to have_content('Nome Social')
            expect(page).to have_content('Descrição')
            expect(page).to have_content('Data de Nascimento')
            expect(page).to have_button('Atualizar Perfil')
        end

        it 'and try to save with all fields blank' do
            freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})

            login_as freelancer, scope: :freelancer
            visit root_path
            click_on 'Atualizar Perfil'

            expect(page).to have_content('Meu Perfil - Editar')
            expect(page).to have_content('Nome Completo não pode ficar em branco')
            expect(page).to have_content('Descrição não pode ficar em branco')
            expect(page).to have_content('Data de Nascimento não pode ficar em branco')
        end
        
        it 'so goes to the edit profile page and fill the fields' do
            freelancer = Freelancer.create!({email: 'teste@tester.com', password: '1234567'})

            login_as freelancer, scope: :freelancer
            visit root_path
            fill_in 'Nome Completo', with: 'Teste nome completo'
            fill_in 'Nome Social', with: 'Teste social'
            fill_in 'Descrição', with: 'Testando a descrição do perfil'
            fill_in 'Data de Nascimento', with: '03/04/1995'
            click_on 'Atualizar Perfil'

            expect(page).to have_content('Meu Perfil')
            expect(page).to have_content('Nome Completo: Teste nome completo')
            expect(page).to have_content('Nome Social: Teste social')
            expect(page).to have_content('Descrição: Testando a descrição do perfil')
            expect(page).to have_content('Data de Nascimento: 03/04/1995')
        end
    end
end
    