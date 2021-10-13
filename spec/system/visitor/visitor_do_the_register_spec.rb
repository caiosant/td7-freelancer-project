require 'rails_helper'

describe 'A visitor try to register' do
    context 'as a product owner' do
        it 'and got successfully' do

            visit root_path
            click_on 'Oferecer Projetos'
            click_on 'Cadastrar-se'

            fill_in 'E-mail', with: 'caio@gmail.com'
            fill_in 'Senha', with: '12345678'
            fill_in 'Confirmação de Senha', with: '12345678'
            click_on 'Realizar Cadastro'

            expect(page).to have_content('caio@gmail.com')
            expect(page).to have_link('Logout')
        end

        it 'and does not fill nothing' do

            visit root_path
            click_on 'Oferecer Projetos'
            click_on 'Cadastrar-se'

            fill_in 'E-mail', with: ''
            fill_in 'Senha', with: ''
            fill_in 'Confirmação de Senha', with: ''
            click_on 'Realizar Cadastro'

            expect(page).to have_content('E-mail não pode ficar em branco')
            expect(page).to have_content('Senha não pode ficar em branco')
        end

        it 'and has already e-mail already registered' do
            caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})

            visit root_path
            click_on 'Oferecer Projetos'
            click_on 'Cadastrar-se'

            fill_in 'E-mail', with: 'caio@gmail.com'
            fill_in 'Senha', with: '12345678'
            fill_in 'Confirmação de Senha', with: '12345678'
            click_on 'Realizar Cadastro'

            expect(page).to have_content('E-mail já está em uso')
        end

        it 'and fill differents passwords' do

            visit root_path
            click_on 'Oferecer Projetos'
            click_on 'Cadastrar-se'

            fill_in 'E-mail', with: 'caio@gmail.com'
            fill_in 'Senha', with: '12345678'
            fill_in 'Confirmação de Senha', with: '123456781'
            click_on 'Realizar Cadastro'

            expect(page).to have_content('Confirmação de Senha não é igual a Senha')
        end
    end

    context 'as a freelancer' do
        it 'and got successfully' do

            visit root_path
            click_on 'Entrar em Projetos'
            click_on 'Cadastrar-se'

            fill_in 'E-mail', with: 'caio@gmail.com'
            fill_in 'Senha', with: '12345678'
            fill_in 'Confirmação de Senha', with: '12345678'
            click_on 'Realizar Cadastro'

            expect(page).to have_content('caio@gmail.com')
            expect(page).to have_link('Logout')
        end

        it 'and does not fill nothing' do

            visit root_path
            click_on 'Entrar em Projetos'
            click_on 'Cadastrar-se'

            fill_in 'E-mail', with: ''
            fill_in 'Senha', with: ''
            fill_in 'Confirmação de Senha', with: ''
            click_on 'Realizar Cadastro'

            expect(page).to have_content('E-mail não pode ficar em branco')
            expect(page).to have_content('Senha não pode ficar em branco')
        end

        it 'and has already e-mail already registered' do
            caio = Freelancer.create!({email: 'caio@gmail.com', password: '12345678'})

            visit root_path
            click_on 'Entrar em Projetos'
            click_on 'Cadastrar-se'

            fill_in 'E-mail', with: caio.email
            fill_in 'Senha', with: caio.password
            fill_in 'Confirmação de Senha', with: caio.password
            click_on 'Realizar Cadastro'

            expect(page).to have_content('E-mail já está em uso')
        end

        it 'and fill differents passwords' do

            visit root_path
            click_on 'Entrar em Projetos'
            click_on 'Cadastrar-se'

            fill_in 'E-mail', with: 'caio@gmail.com'
            fill_in 'Senha', with: '12345678'
            fill_in 'Confirmação de Senha', with: '123456781'
            click_on 'Realizar Cadastro'

            expect(page).to have_content('Confirmação de Senha não é igual a Senha')
        end
    end
end