require 'rails_helper'

describe 'A visitor do the login' do
    context 'as project owner' do
        it 'and got successfully using e-mail' do
            caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
    
            visit root_path
            click_on 'Oferecer Projetos'
    
            fill_in 'E-mail', with: caio.email
            fill_in 'Senha', with: caio.password 
            click_on 'Entrar'
    
            expect(page).to have_content('caio@gmail.com')
            expect(page).to have_link('Logout')
        end
        
        it 'and miss the e-mail' do
            caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
    
            visit root_path
            click_on 'Oferecer Projetos'
    
            fill_in 'E-mail', with: 'caio1@gmail.com'
            fill_in 'Senha', with: caio.password
            click_on 'Entrar'
            
            expect(page).to have_content('E-mail ou senha inválida.')
            expect(page).to have_content('E-mail')
            expect(page).to have_content('Senha')
            expect(page).to have_button("Entrar")
            expect(page).to have_content('Não tem sua conta ainda?')
            expect(page).to have_link('Cadastrar-se')
            expect(page).to have_link('Esqueceu sua senha?')
            expect(page).to_not have_content('caio1@gmail.com')
            expect(page).to_not have_link('Logout')
        end

        it 'and miss the password' do
            caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
    
            visit root_path
            click_on 'Oferecer Projetos'
    
            fill_in 'E-mail', with: 'caio1@gmail.com'
            fill_in 'Senha', with: caio.password
            click_on 'Entrar'
    
            expect(page).to have_content('E-mail ou senha inválida.')
            expect(page).to have_content('E-mail')
            expect(page).to have_content('Senha')
            expect(page).to have_button("Entrar")
            expect(page).to have_content('Não tem sua conta ainda?')
            expect(page).to have_link('Cadastrar-se')
            expect(page).to have_link('Esqueceu sua senha?')
            expect(page).to_not have_content('caio1@gmail.com')
            expect(page).to_not have_link('Logout')
        end
    end

    context 'as freelancer' do
        it 'and got successfully using e-mail' do
            caio = Freelancer.create!({email: 'caio@gmail.com', password: '12345678'})
    
            visit root_path
            click_on 'Entrar em Projetos'
    
            fill_in 'E-mail', with: caio.email
            fill_in 'Senha', with: caio.password 
            click_on 'Entrar'
    
            expect(page).to have_content('caio@gmail.com')
            expect(page).to have_link('Logout')
        end
        
        it 'and miss the e-mail' do
            caio = Freelancer.create!({email: 'caio@gmail.com', password: '12345678'})
    
            visit root_path
            click_on 'Entrar em Projetos'
    
            fill_in 'E-mail', with: 'caio1@gmail.com'
            fill_in 'Senha', with: caio.password
            click_on 'Entrar'
            
            expect(page).to have_content('E-mail ou senha inválida.')
            expect(page).to have_content('E-mail')
            expect(page).to have_content('Senha')
            expect(page).to have_button("Entrar")
            expect(page).to have_content('Não tem sua conta ainda?')
            expect(page).to have_link('Cadastrar-se')
            expect(page).to have_link('Esqueceu sua senha?')
            expect(page).to_not have_content('caio1@gmail.com')
            expect(page).to_not have_link('Logout')
        end

        it 'and miss the password' do
            caio = Freelancer.create!({email: 'caio@gmail.com', password: '12345678'})
    
            visit root_path
            click_on 'Entrar em Projetos'
    
            fill_in 'E-mail', with: 'caio1@gmail.com'
            fill_in 'Senha', with: caio.password
            click_on 'Entrar'
    
            expect(page).to have_content('E-mail ou senha inválida.')
            expect(page).to have_content('E-mail')
            expect(page).to have_content('Senha')
            expect(page).to have_button("Entrar")
            expect(page).to have_content('Não tem sua conta ainda?')
            expect(page).to have_link('Cadastrar-se')
            expect(page).to have_link('Esqueceu sua senha?')
            expect(page).to_not have_content('caio1@gmail.com')
            expect(page).to_not have_link('Logout')
        end
    end
end
