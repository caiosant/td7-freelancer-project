require 'rails_helper'

describe 'project owner create a new project' do
    it 'and got successfully' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})

        login_as caio, scope: :project_owner
        visit root_path
        click_on 'Cadastrar Projeto'

        fill_in 'Nome do Projeto', with: 'Projeto de Sistema'
        fill_in 'Descrição', with: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.'
        fill_in 'Valor Máximo por Hora', with: 200
        fill_in 'Data Limite para Propostas', with: 5.days.from_now
        select 'Presencial', from: 'Forma de Trabalho'
        within 'form' do
            click_on 'Cadastar Projeto'
        end

        expect(page).to have_content('Projeto de Sistema')
        expect(page).to have_content('Descrição: Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.')
        expect(page).to have_content('Valor Máximo por Hora: 200')
        expect(page).to have_content(5.days.from_now.to_date())
        expect(page).to have_content('Forma de trabalho: Presencial')
    end

    it 'and does not fill nothing' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})

        login_as caio, scope: :project_owner
        visit root_path
        click_on 'Cadastrar Projeto'

        fill_in 'Nome do Projeto', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Valor Máximo por Hora', with: ''
        fill_in 'Data Limite para Propostas', with: ''
        within 'form' do
            click_on 'Cadastar Projeto'
        end

        expect(page).to have_content('Nome do Projeto não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Descrição é muito curto (mínimo: 30 caracteres)')
        expect(page).to have_content('Valor Máximo por Hora não pode ficar em branco')
        expect(page).to have_content('Valor Máximo por Hora não é um número')
        expect(page).to have_content('Data Limite para Propostas não pode ficar em branco')
        expect(page).to have_content('Forma de Trabalho não pode ficar em branco')
    end

    it 'and fill max value with 0' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})

        login_as caio, scope: :project_owner
        visit root_path
        click_on 'Cadastrar Projeto'

        fill_in 'Nome do Projeto', with: 'Projeto de Sistema'
        fill_in 'Descrição', with: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.'
        fill_in 'Valor Máximo por Hora', with: 0
        fill_in 'Data Limite para Propostas', with: 5.days.from_now
        select 'Presencial', from: 'Forma de Trabalho'
        within 'form' do
            click_on 'Cadastar Projeto'
        end

        expect(page).to have_content('Valor Máximo por Hora deve ser maior que 0')
    end

    it 'and select a date before today' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})

        login_as caio, scope: :project_owner
        visit root_path
        click_on 'Cadastrar Projeto'

        fill_in 'Nome do Projeto', with: 'Projeto de Sistema'
        fill_in 'Descrição', with: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.'
        fill_in 'Valor Máximo por Hora', with: 0
        fill_in 'Data Limite para Propostas', with: -1.days.from_now
        select 'Presencial', from: 'Forma de Trabalho'
        within 'form' do
            click_on 'Cadastar Projeto'
        end

        expect(page).to have_content('Data Limite para Propostas precisa maior ou igual a hoje')
    end
end
