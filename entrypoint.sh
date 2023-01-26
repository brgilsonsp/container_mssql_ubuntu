#!/bin/bash

# If change the value of ARG DIR_CONFIG_DB inDockerfile, so will to change the path /home/configdb
# Start the script to create the DB and user
/home/configdb/configure-db.sh &

# Start SQL Server
/opt/mssql/bin/sqlservr