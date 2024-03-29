require 'rails_helper'

describe 'project see you own projects' do
  it 'and got successfully' do
    caio = ProjectOwner.create!({ email: 'caio@gmail.com',
                                  password: '12345678' })

    edu = ProjectOwner.create!({ email: 'edu@gmail.com',
                                 password: '12345678' })

    javascript = Ability.create!({ name: 'Javascript' })

    projeto_caio = Project.create!({ title: 'Projeto de Sistema',
                                     description: 'Este projeto da Handa promete garantir qualidade de vida para ' \
                                                  'muitos connect on Linked in. A Oestia, grupo que promove a ' \
                                                  'intervenção da Handa no público, promoveu há cerca de três anos.',
                                     max_value: 200,
                                     deadline: 5.days.from_now,
                                     location: 'local',
                                     abilities: [javascript],
                                     project_owner: caio })

    projeto_edu = Project.create!({ title: 'Projeto de Sistema do Edu',
                                    description: 'Este projeto da Handa promete garantir qualidade de vida para ' \
                                                 'muitos connect on Linked in. A Oestia, grupo que promove a ' \
                                                 'intervenção da Handa no público, promoveu há cerca de três anos.',
                                    max_value: 200,
                                    deadline: 6.days.from_now,
                                    location: 'local',
                                    abilities: [javascript],
                                    project_owner: edu })

    login_as caio, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'

    expect(page).to have_link('Projeto de Sistema')
    expect(page).to have_content(I18n.l(5.days.from_now.to_date))
    expect(page).to_not have_link('Projeto de Sistema do Anderson')
    expect(page).to_not have_content(I18n.l(6.days.from_now.to_date))
    expect(page).to_not have_content('Você não tem projetos cadastrados.')
    expect(page).to_not have_link('Clique aqui para criar o seu primeiro projeto!')
  end

  it 'and does not have a project' do
    caio = ProjectOwner.create!({ email: 'caio@gmail.com', password: '12345678' })

    login_as caio, scope: :project_owner
    visit root_path
    click_on 'Meus Projetos'

    expect(page).to have_content('Você não tem projetos cadastrados.')
    expect(page).to have_link('Clique aqui')
    expect(page).to have_content('para criar o seu primeiro projeto!')
  end
end
