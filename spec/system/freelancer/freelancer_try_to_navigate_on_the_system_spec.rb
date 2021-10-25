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
    end
end
    