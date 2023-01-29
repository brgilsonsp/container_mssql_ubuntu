Imagem de um banco de dados MS SQL Server 2019 Express, no sistema operacional Ubuntu Focal 20.04.
A imagem base foi a partir da mssql mantido pela Microsoft que pode ser obtida nesse [link](https://hub.docker.com/_/microsoft-mssql-server)

Essa imagem já fornece as configurações necessárias para consumir um banco de dados, sendo necessário apenas fornecer o scritp para criação de um banco e suas respectivas tabelas.

O Dockerfile está disponível no [Github](https://github.com/brgilsonsp/container_mssql_ubuntu)

# Configurações

### Variáveis de ambiente
As seguintes configurações estão disponível para alteração durante a criação do container
* Variáveis de ambientes
  * FILE_NAME_SCRIPT_CREATE
    * Nome do arquivo, que será compartilha com o container, que possui o scritp sql para configuração inicial do banco de dados (banco de dados, tabela, etc). Valor padrão: ***scriptbd.sql***
  * MSSQL_SA_PASSWORD
    * Senha do usuário ****sa**** do banco de dados. Valor padrão: ***yourStrong(!)Password***

As seguintes variáveis **não** devem ser alteradas, mantendo os valores da imagem
* Variáveis de ambientes
  * ACCEPT_EULA
    * valor configurado: ***Y***
  * MSSQL_PID
    * valor configurado: ***Express***
  * DIR_SCRITP_DB
    * diretório que o container irá obter o script para configuração do banco de dados. Valor default ***/home/scriptdb***

### Portas
Deve expor a porta para comunicação com o banco de dados Ms SQL Server
* 1433/tcp


### Volume
Deve configurar o apontamento do volume para o diretório do host que fornecerá o scritp sql para configuração do banco de dados. Cuidado, o nome do arquivo que estará nesse diretório deve ser o mesmo informado na variável de ambiente `FILE_NAME_SCRIPT_CREATE`
* Diretório no container: /home/scriptdb
Nesse caso você deve configurar:

`` ... --volume <caminho_absoluto__diretorio_com_scritp>:/home/scriptdb ... ``

Você pode mapear também o banco de dados do caminho `/var/opt/mssql`

# Como utilizar essa imagem

Utilizando a ultima versão:

`` docker run --env 'FILE_NAME_SCRIPT_CREATE=scritp.sql' --env 'MSSQL_SA_PASSWORD=your_0th3r#P4&&w!' --volume /home/dir_with_script:'/home/scriptdb' --publish 1433:1433 --name my_mssql_dev brgilsonsp/mssql2019:latest``

**Obs**: Não esqueça de observar os valores que devem ser alterados: **scritp.sql** e **/home/dir_with_script**

### Exemplo Dockerfile

```
services:
  mssqlserver:
    image: brgilsonsp/mssql2019:v1.0
    container_name: ms_sqlserver
    volumes:
      - ./scriptDB:/home/scriptdb
      - bd_winix_wms:/var/opt/mssql
    network_mode: bridge
    ports:
      - "1433:1433"
    environment:
      - FILE_NAME_SCRIPT_CREATE=scriptbd.sql
      - MSSQL_SA_PASSWORD=W1n1xStrong(!)Password
      
volumes:
  bd_winix_wms:
```
