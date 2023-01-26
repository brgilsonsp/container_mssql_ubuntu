Exemplo docker-compose
  mssqlserver:
    image: brgilsonsp/mssqlserver_ubuntu:1.0
    container_name: ms_sqlserver
    volumes:
      - ./scriptDB:/home/db/script
    network_mode: bridge
    ports:
      - "1433:1433"

# Overview

Imagem de um banco de dados MS SQL Server 2019 Express, no sistema operacional Ubuntu Focal 20.04.
A imagem base foi a partir da mssql mantido pela Microsoft que pode ser obtida nesse [link](https://hub.docker.com/_/microsoft-mssql-server)

Essa imagem já fornece as configurações necessárias para consumir um banco de dados, sendo necessário apenas fornecer o scritp para criação de um banco e suas respectivas tabelas.

Infelizmente o MSSql não fornece uma procedure para exectuar o script quando cria a instância [como o MySQL, nesse exemplo](https://www.softwaredeveloper.blog/docker-compose-introduction-dotnet-core-app-composed-with-mysql-database#mysql-db), então para iniciar pela primeira vez é necessário:
1. Iniciar o banco de dados
2. Ne mesmo tempo deve executar o script:
    1. Aguarde por volta de 90 sec para garantir que o banco subiu corretamente
    2. Executa o script via utilitário SqlCmd


Verifique no [DockerHub](https://hub.docker.com/repository/docker/brgilsonsp/mssql2019/general) a documentação para subir um container com essa imagem
