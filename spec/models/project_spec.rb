require 'rails_helper'

RSpec.describe Project, type: :model do
    it 'should not have a date before today' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
        javascript = Ability.create!({name: 'Javascript'})

        projeto_caio = Project.new({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
        max_value: 200, deadline: 5.days.ago, location: 'local', abilities: [javascript], project_owner: caio})

        expect(projeto_caio.valid?).to eq false
    end

    it 'should have a ability selected' do
        caio = ProjectOwner.create!({email: 'caio@gmail.com', password: '12345678'})
        javascript = Ability.create!({name: 'Javascript'})

        projeto_caio = Project.new({title: 'Projeto de Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
        max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [], project_owner: caio})

        expect(projeto_caio.valid?).to eq false
    end
end
