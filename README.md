# README

Teste de recrutamento blu.

* Ruby -v 

    ruby-2.5.8

* Dependências 

  docker/docker-compose - https://docs.docker.com/compose/install/

* Configuração da aplicação
  
  Com o docker-compose devidamente instalado basta fazer o download (pull) do projeto, alterar o nome do arquivo <.env.example> para apenas <.env> e executar o comando <docker-compose up --build> na raiz o projeto para buildar a aplicação
  
* Configuração do banco de dados

    Na raiz do projeto execute o comando <docker-compose exec web bash> após o build da aplicação para acessar o bash do container, no bash do container execute os comandos <rails db:create> para a criação do banco e <rails db:migrate> para migrar as tabelas para o banco 

* Utilidade

  Caso tenha problemas com permissões devido ao docker basta rodar o comando <sudo chown -R $USER:$USER .> na raiz do projeto.

  Para semear o banco com dados basta rodar o comando <rails db:seed> no bash do container.

* ...
