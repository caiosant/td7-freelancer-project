# TD7-Freelancers

##  Sobre o Projeto

Projeto desenvolvido como conclusão da primeira etapa da sétima turma do [treinadev](https://treinadev.com.br/).
O projeto consiste em um sistema para a contratação de freelancers, para isto foi feita a divisão dos usuários entre
os **Freelancers** e os **Project Owners**, onde, cada um apresenta funções e features específicas. Abaixo será possível
acompanhar o lançamento das features bem como é possível acompanhar o fluxo de desenvolvimento [cliquando aqui](https://github.com/caiosant/td7-freelancer-project/projects/1).

Importante salientar que para todo o desenvolvimento do projeto foi realizada a utilização de TDD.

## Pré-requisitos:

 * Ruby 3.0.2
 * Rails 6.1.4.1

### Gems & Explicações:

#### Testes

  * RSpec  https://rubygems.org/gems/rspec/versions/3.10.0
  * Capybara  https://rubygems.org/gems/capybara/versions/3.35.3
 
 Ambas as gems foram utilizadas para a realização de testes, com a combinação de ambos foi possível realizar a cobertura
 dos testes para as funcionalidades da plataforma.
                                          
#### Autenticação

  * Devise  https://github.com/heartcombo/devise#getting-started

A gem Devise foi escolhia para realizar o processo de autenticação, visando trazer agilidade e segurança para o projeto, pelo fato,
de ser uma gem que facilita diversos processos de uma forma segura e esta em constantes atualizações.

## Testes
Os testes podem ser encontramos dentro da pasta ````/spec/`````contida dentro do projeto. Caso deseje realizar alguma alteração no código é recomendando rodar o comando:
````rspec````

Desta forma será possível garantir que não ocorreu nenhuma quebra na execução do projeto.

## Para execução do projeto: 

  * Clonar o projeto para sua máquina
  * Instalar as dependências necessárias:
  ````
  bin/setup
  yarn install --check-files
  bin/webpack
  ````
  * Configuração do banco de dados
Antes de iniciar o projeto é necessário executar o comando ````rails db:mmigrate````, para que as migrations sejam rodadas na sua máqui.

  * Iniciar o servidor e acessar aplicação:<br>
Para iniciar o servidor basta executar o comando ````rails s```` e acessar ````http://localhost:3000````

--- 
## Features:

##### Project Owner
- [x] Criação de conta;
- [x] Cadastrar Projeto;
- [x] Visualizar seus projetos;
- [x] Visualizar propostas nos seus projetos;
- [x] Aceitar/Recusar propostas;
- [x] Marcar Freelancer como destaque;
- [x] Encerrar inscrições para o projeto;
- [x] Visualizar time;
- [x] Encerrar Projeto;
- [ ] Feedback para os profissionais;
##### Freelancer
- [x] Criação de conta;
- [ ] Criação do perfil;
    - [x] Nome Completo;
    - [x] Nome Social;
    - [x] Data de Nascimento;
    - [x] Descrição;
    - [ ] Experiência;
    - [ ] Avatar;
    - [ ] Área de atuação
- [x] Atualizar Perfil (Obrigatório);
- [x] Visualizar projetos disponíveis;
- [x] Buscar projeto;
- [x] Enviar proposta;
- [x] Cancelar proposta;
- [x] Visualizar time do projeto;
- [ ] Feedback do projeto;
