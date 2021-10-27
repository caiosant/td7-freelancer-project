# Criando habilidades para os projetos:
habilidade1 = Ability.create!({name: 'Ruby'})
habilidade2 = Ability.create!({name: 'Ruby on Rails'})
habilidade3 = Ability.create!({name: 'Javascript'})
habilidade4 = Ability.create!({name: 'NodeJS'})
habilidade5 = Ability.create!({name: 'HTML5'})
habilidade6 = Ability.create!({name: 'CSS3'})
habilidade7 = Ability.create!({name: 'React'})
habilidade8 = Ability.create!({name: 'Flutter'})

# Criando áreas de atuação:
area_atuacao1 = OccupationArea.create!({name: 'Desenvolvimento Web'})
area_atuacao2 = OccupationArea.create!({name: 'Desenvolvimento Backend'})
area_atuacao3 = OccupationArea.create!({name: 'Desenvolvimento Frontend'})
area_atuacao4 = OccupationArea.create!({name: 'Desenvolvimento Frontend'})

# Criando os Project Owners:
project_owner1 = ProjectOwner.create!({email: 'projectowner1@gmail.com', password: '123456'})
project_owner2 = ProjectOwner.create!({email: 'projectowner2@gmail.com', password: '123456'})

# Criando os Projetos:
project1 = Project.create!({title: 'Projeto de desenvolvimento web', description:'Projeto focado no desenvolvimento de uma plataforma web para um colégio',
                            max_value: 200, deadline: 3.days.from_now, abilities: [habilidade2, habilidade3, habilidade7], project_owner: project_owner1, location: 'remotely'})
project2 = Project.create!({title: 'Atualização de Plafatorma antiga', description:'Projeto focado em atualizar a plataforma da minha empresa',
                            max_value: 100, deadline: 5.days.from_now, abilities: [habilidade2, habilidade3, habilidade7, habilidade8], project_owner: project_owner2, location: 'remotely'})

# Criando os Freelancers:
freelancer1 = Freelancer.create!({email: 'freelancer@gmail.com', password: '123456'})
freelancer2 = Freelancer.create!({email: 'freelancer2@gmail.com', password: '123456'})

# Atualizando o perfil dos Freelancers:
profile1 = Profile.find(freelancer1.id)
profile2 = Profile.find(freelancer1.id)

profile1.update!({full_name: 'Freelancer Número Um', social_name: 'Freelancer 1', birth_date: '1990-04-03',
                  description: 'Apaixonado por desenvolvimento web e por finanças, procura trabalhar em projetos que envolva os dois',
                  freelancer: freelancer1, occupation_area: area_atuacao1})
                  
profile2.update!({full_name: 'Freelancer Número Dois', social_name: 'Freelancer Número Dois', birth_date: '1980-01-07',
                  description: 'Ex bancário mudando sua área de atuação, buscando projetos para pode iniciar na área',
                  freelancer: freelancer2, occupation_area: area_atuacao2})

# Criando uma proposta
Proposal.create!({application_reason: 'Tenho muita vontade de iniciar na área, por este motivo gostaria de me aplicar para a vaga. Irei me esforçar 100%',
                  hour_value: 120, hours: 40, deadline_proposal: '2021-12-19', project: project1, freelancer: freelancer2})