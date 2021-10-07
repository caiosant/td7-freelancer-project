require 'rails_helper'

describe 'visitor visit homepage' do
    it 'successfully' do

        visit root_path

        expect(page).to have_content("TD7-Freelancers")
        expect(page).to have_link("Login")
        expect(page).to have_link("Cadastrar-se")
    end

    it 'and goes to the register page' do

        visit root_path
        click_link_or_button 'Cadastrar-se'

        expect(page).to have_content('TD7-Freelancers')
        expect(page).to have_link('Login')
        expect(page).to have_link('Cadastrar-se')
        expect(page).to have_content('Nome Completo')
        expect(page).to have_content('Nome de Usuário')
        expect(page).to have_content('E-mail')
        expect(page).to have_content('Senha')
        expect(page).to have_content('Confirmação de Senha')
    end

    it 'and goes to the login page' do

        visit root_path
        click_link_or_button 'Login'
    end
end