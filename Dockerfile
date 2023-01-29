FROM mcr.microsoft.com/mssql/server:2019-CU15-ubuntu-20.04

LABEL version="1.0"
LABEL author="Gilson Souza"
LABEL vendor="Winix"
LABEL service="Banco de Dados MS SqlServer 2019"
LABEL vendor_image_base="https://hub.docker.com/_/microsoft-mssql-server"
LABEL operation_system="Ubuntu Focal 20.04"

# If change the value, it will to change in entrypoint.sh and configure-db.sh
ARG DIR_CONFIG_DB="/home/configdb"

ENV ACCEPT_EULA="Y"
ENV MSSQL_PID="Express"
ENV FILE_NAME_SCRIPT_CREATE="scriptbd.sql"
ENV MSSQL_SA_PASSWORD="yourStrong(!)Password"
ENV DIR_SCRITP_DB="/home/scriptdb"

EXPOSE 1433/tcp

# User root to execute configuration and installation
USER root

RUN mkdir -p $DIR_CONFIG_DB

WORKDIR $DIR_CONFIG_DB

COPY . .
RUN chmod +x ./entrypoint.sh
RUN chmod +x ./configure-db.sh


#User mssql to execute BD
USER mssql

CMD ./entrypoint.sh