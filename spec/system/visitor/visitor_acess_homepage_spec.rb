require 'rails_helper'

describe 'visitor visit homepage' do
  it 'successfully' do
    visit root_path

    expect(page).to have_link('TD7-Freelancers')
    expect(page).to have_content('O que deseja fazer?')
    expect(page).to have_link('Oferecer Projetos')
    expect(page).to have_link('Entrar em Projetos')
    expect(page).to have_link("Caio Sant'Ana da Silva")
    expect(page).to have_link('TreinaDev')
  end

  context 'as project owner' do
    it 'and goes to the login page' do
      visit root_path
      click_link_or_button 'Oferecer Projetos'

      expect(page).to have_link('TD7-Freelancers')
      expect(page).to have_content('E-mail')
      expect(page).to have_content('Senha')
      expect(page).to have_button('Entrar')
      expect(page).to have_content('Não tem sua conta ainda?')
      expect(page).to have_link('Cadastrar-se')
      expect(page).to have_link('Esqueceu sua senha?')
    end

    it 'and goes to the register page' do
      visit root_path
      click_link_or_button 'Oferecer Projetos'
      click_link_or_button 'Cadastrar-se'

      expect(page).to have_content('E-mail')
      expect(page).to have_content('Senha')
      expect(page).to have_content('Confirmação de Senha')
      expect(page).to have_button('Realizar Cadastro')
    end
  end

  context 'as freelancer' do
    it 'and goes to the login page' do
      visit root_path
      click_link_or_button 'Entrar em Projetos'

      expect(page).to have_link('TD7-Freelancers')
      expect(page).to have_content('E-mail')
      expect(page).to have_content('Senha')
      expect(page).to have_button('Entrar')
      expect(page).to have_content('Não tem sua conta ainda?')
      expect(page).to have_link('Cadastrar-se')
      expect(page).to have_link('Esqueceu sua senha?')
    end

    it 'and goes to the register page' do
      visit root_path
      click_link_or_button 'Entrar em Projetos'
      click_link_or_button 'Cadastrar-se'

      expect(page).to have_content('E-mail')
      expect(page).to have_content('Senha')
      expect(page).to have_content('Confirmação de Senha')
      expect(page).to have_button('Realizar Cadastro')
    end
  end
end
