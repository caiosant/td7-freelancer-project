require 'rails_helper'

RSpec.describe Proposal, type: :model do
    it 'proposal cant be duplicated' do
        project_owner = ProjectOwner.create!({email: 'testepo2@teste.com', password: '1234567'})
        javascript = Ability.create!({name: 'Javascript'})
        projeto_po = Project.create!({title: 'Projeto Sistema', description: 'Este projeto da Handa promete garantir qualidade de vida para muitos connect on Linked in. A Oestia, grupo que promove a intervenção da Handa no público, promoveu há cerca de três anos.',
                                    max_value: 200, deadline: 5.days.from_now, location: 'local', abilities: [javascript], project_owner: project_owner})

        occupation_area = OccupationArea.create!({name: 'Desenvolvimento web'})
        freelancer = Freelancer.create!({email: 'teste2@tester.com', password: '1234567'})
        profile_freelancer = freelancer.profile.update!({full_name: 'teste tester', social_name:'teste tester', birth_date: '1995-04-03', occupation_area: occupation_area, description:'Grande profissional da área de T.I. com mais de 10 anos de exp atuando em grandes empresas'})

        proposal = Proposal.create!({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar nele', hour_value: 30, hours:30, freelancer: freelancer, project: projeto_po})

        proposal2 = Proposal.new({application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar nele', hour_value: 30, hours:30, freelancer: freelancer, project: projeto_po})

        expect(proposal2.valid?).to eq false
    end
end
