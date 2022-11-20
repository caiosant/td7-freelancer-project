require 'rails_helper'

describe 'Freelancer update his profile' do
  it 'so goes to the edit profile page and fill the fields' do
    freelancer = Freelancer.create!({ email: 'teste@tester.com', password: '1234567' })
    occupation_area = OccupationArea.create!({ name: 'Desenvolvimento web' })

    login_as freelancer, scope: :freelancer
    visit root_path
    fill_in 'Nome Completo', with: 'Teste nome completo'
    fill_in 'Nome Social', with: 'Teste social'
    fill_in 'Descrição', with: 'Testando a descrição do perfil'
    fill_in 'Data de Nascimento', with: '03/04/1995'
    select 'Desenvolvimento web', from: 'Área de Atuação'
    attach_file 'Avatar', './app/assets/images/avatar_test.jpg'
    click_on 'Atualizar Perfil'

    expect(page).to have_css('img[alt=avatar-profile]')
    expect(page).to have_content('Meu Perfil')
    expect(page).to have_content('Nome Completo: Teste nome completo')
    expect(page).to have_content('Nome Social: Teste social')
    expect(page).to have_content('Área de Atuação: Desenvolvimento web')
    expect(page).to have_content('Descrição: Testando a descrição do perfil')
    expect(page).to have_content('Data de Nascimento: 03/04/1995')
  end

  it 'and try to save with all fields blank' do
    freelancer = Freelancer.create!({ email: 'teste@tester.com', password: '1234567' })
    occupation_area = OccupationArea.create!({ name: 'Desenvolvimento web' })

    login_as freelancer, scope: :freelancer
    visit root_path
    click_on 'Atualizar Perfil'

    expect(page).to have_content('Meu Perfil - Editar')
    expect(page).to have_content('Nome Completo não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Área de Atuação não pode ficar em branco')
    expect(page).to have_content('Data de Nascimento não pode ficar em branco')
  end

  it 'and just update one field' do
    freelancer = Freelancer.create!({ email: 'teste@tester.com', password: '1234567' })
    occupation_area = OccupationArea.create!({ name: 'Desenvolvimento web' })

    login_as freelancer, scope: :freelancer
    visit root_path
    fill_in 'Nome Completo', with: 'Teste nome completo'
    fill_in 'Nome Social', with: 'Teste social'
    fill_in 'Descrição', with: 'Testando a descrição do perfil'
    fill_in 'Data de Nascimento', with: '03/04/1995'
    select 'Desenvolvimento web', from: 'Área de Atuação'
    attach_file 'Avatar', './app/assets/images/avatar_test.jpg'
    click_on 'Atualizar Perfil'
    click_on 'Editar'
    fill_in 'Nome Completo', with: 'Teste nome completo2.0'
    click_on 'Atualizar Perfil'

    expect(page).to have_css('img[alt=avatar-profile]')
    expect(page).to have_content('Meu Perfil')
    expect(page).to have_content('Nome Completo: Teste nome completo2.0')
    expect(page).to have_content('Nome Social: Teste social')
    expect(page).to have_content('Área de Atuação: Desenvolvimento web')
    expect(page).to have_content('Descrição: Testando a descrição do perfil')
    expect(page).to have_content('Data de Nascimento: 03/04/1995')
  end
end
