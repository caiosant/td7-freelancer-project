require 'rails_helper'

describe 'Property Owner authentication' do
  context 'project' do
    context 'need to be singed in' do
      it 'cannot open new project form unless authenticated' do
        get new_project_path

        expect(response).to redirect_to(new_project_owner_session_path)
      end

      it 'cannot create property without login' do
        post projects_path

        expect(response).to redirect_to(new_project_owner_session_path)
      end

      it 'cannot accept a proposal' do
        caio = ProjectOwner.create!({ email: 'caio@gmail.com',
                                      password: '12345678' })
        javascript = Ability.create!({ name: 'Javascript' })
        projeto_caio = Project.create!({ title: 'Projeto de Sistema',
                                         description: 'Este projeto da Handa promete garantir qualidade de vida para ' \
                                                      'muitos connect on Linked in. A Oestia, grupo que promove a ' \
                                                      'intervenção da Handa no público, promoveu há cerca de ' \
                                                      'três anos.',
                                         max_value: 200,
                                         deadline: 5.days.from_now,
                                         location: 'local',
                                         abilities: [javascript],
                                         project_owner: caio })

        occupation_area = OccupationArea.create!({ name: 'Desenvolvimento web' })
        freelancer = Freelancer.create!({ email: 'teste@tester.com',
                                          password: '1234567' })
        profile_freelancer = freelancer.profile.update!({ full_name: 'Caio Free',
                                                          social_name: 'Caio Free',
                                                          birth_date: '1995-04-03',
                                                          occupation_area: occupation_area,
                                                          description: 'Grande profissional da área de T.I. com mais ' \
                                                                       'de 10 anos de exp atuando em grandes ' \
                                                                       'empresas' })
        proposal = Proposal.create!({ application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar ' \
                                                          'projeto caio',
                                      hour_value: 30,
                                      hours: 30,
                                      deadline_proposal: 10.days.from_now,
                                      freelancer: freelancer,
                                      project: projeto_caio })

        post "/projects/#{projeto_caio.id}/proposals/#{proposal.id}/accept"

        expect(response).to redirect_to(root_path)
      end

      it 'cannot reject a proposal' do
        caio = ProjectOwner.create!({ email: 'caio@gmail.com',
                                      password: '12345678' })
        javascript = Ability.create!({ name: 'Javascript' })
        projeto_caio = Project.create!({ title: 'Projeto de Sistema',
                                         description: 'Este projeto da Handa promete garantir qualidade de vida para ' \
                                                      'muitos connect on Linked in. A Oestia, grupo que promove a ' \
                                                      'intervenção da Handa no público, promoveu há cerca de ' \
                                                      'três anos.',
                                         max_value: 200,
                                         deadline: 5.days.from_now,
                                         location: 'local',
                                         abilities: [javascript],
                                         project_owner: caio })

        occupation_area = OccupationArea.create!({ name: 'Desenvolvimento web' })
        freelancer = Freelancer.create!({ email: 'teste@tester.com',
                                          password: '1234567' })
        profile_freelancer = freelancer.profile.update!({ full_name: 'Caio Free',
                                                          social_name: 'Caio Free',
                                                          birth_date: '1995-04-03',
                                                          occupation_area: occupation_area,
                                                          description: 'Grande profissional da área de T.I. com mais ' \
                                                                       'de 10 anos de exp atuando em grandes' \
                                                                       'empresas' })
        proposal = Proposal.create!({ application_reason: 'Projeto dos meus sonhos, gostaria muito de trabalhar ' \
                                                          'projeto caio',
                                      hour_value: 30,
                                      hours: 30,
                                      deadline_proposal: 10.days.from_now,
                                      freelancer: freelancer,
                                      project: projeto_caio })

        post "/projects/#{projeto_caio.id}/proposals/#{proposal.id}/reject"

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
