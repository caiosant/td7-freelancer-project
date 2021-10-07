require 'rails_helper'

describe 'A visitor do the login' do
    it 'and got successfully using e-mail' do
        caio = User.create!({full_name: 'Caio Silva', username: 'caiosant', email: 'caio@gmail.com', password: '12345678'})

        visit root_path
        click_on 'Login'

        fill_in 'Usuário ou E-mail', with: caio.email
        fill_in 'Senha', with: caio.password 
        click_on 'Entrar'

        expect(page).to have_content('caiosant')
        expect(page).to have_link('Logout')
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Cadastrar-se')
    end

    it 'and got successfully using username' do
        caio = User.create!({full_name: 'Caio Silva', username: 'caiosant', email: 'caio@gmail.com', password: '12345678'})

        visit root_path
        click_on 'Login'

        fill_in 'Usuário ou E-mail', with: caio.username
        fill_in 'Senha', with: caio.password
        click_on 'Entrar'

        expect(page).to have_content('caiosant')
        expect(page).to have_link('Logout')
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Cadastrar-se')
    end

    
    it 'and miss the email' do
        caio = User.create!({full_name: 'Caio Silva', username: 'caiosant', email: 'caio@gmail.com', password: '12345678'})

        visit root_path
        click_on 'Login'

        fill_in 'Usuário ou E-mail', with: 'caio1@gmail.com'
        fill_in 'Senha', with: caio.password
        click_on 'Entrar'

        expect(page).to have_content('caiosant')
        expect(page).to have_link('Logout')
        expect(page).to_not have_link('Login')
        expect(page).to_not have_link('Cadastrar-se')
    end
end
