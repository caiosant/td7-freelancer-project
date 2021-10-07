require 'rails_helper'

describe 'A visitor try to register' do
    it 'and got successfully' do

        visit root_path
        click_on 'Cadastrar-se'

        fill_in 'Nome Completo', with: 'Caio Silva'
        fill_in 'Nome de Usuário', with: 'caiosant'
        fill_in 'E-mail', with: 'caio@gmail.com'
        fill_in 'Senha', with: '12345678'
        fill_in 'Confirmação de Senha', with: '12345678'
        click_on 'Cadastrar'

        expect(page).to have_content('caiosant')
        expect(page).to have_link('Logout')
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Cadastrar-se')
    end

    it 'and does not fill nothing' do

        visit root_path
        click_on 'Cadastrar-se'

        fill_in 'Nome Completo', with: ''
        fill_in 'Nome de Usuário', with: ''
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: ''
        fill_in 'Confirmação de Senha', with: ''
        click_on 'Cadastrar'

        expect(page).to have_content('Nome Completo não pode ficar em branco')
        expect(page).to have_content('Nome de Usuário não pode ficar em branco')
        expect(page).to have_content('E-mail não pode ficar em branco')
        expect(page).to have_content('Usuário não pode ficar em branco')
        expect(page).to have_content('Senha não pode ficar em branco')
    end

    it 'and has already e-mail and username already registered' do
        caio = User.create!({full_name: 'Caio Silva', username: 'caiosilva', email: 'caio@gmail.com', password: '12345678'})


        visit root_path
        click_on 'Cadastrar-se'

        fill_in 'Nome Completo', with: caio.full_name
        fill_in 'Nome de Usuário', with: caio.username
        fill_in 'E-mail', with: 'caio@gmail.com'
        fill_in 'Senha', with: '12345678'
        fill_in 'Confirmação de Senha', with: '12345678'
        click_on 'Cadastrar'

        expect(page).to have_content('E-mail já está em uso')
        expect(page).to have_content('Usuário já está em uso')
    end

    it 'and fill differents passwords' do

        visit root_path
        click_on 'Cadastrar-se'

        fill_in 'Nome Completo', with: 'Caio Silva'
        fill_in 'Nome de Usuário', with: 'caiosant'
        fill_in 'E-mail', with: 'caio@gmail.com'
        fill_in 'Senha', with: '12345678'
        fill_in 'Confirmação de Senha', with: '123456781'
        click_on 'Cadastrar'

        expect(page).to have_content('Confirmação de Senha não é igual a Senha')
    end
end