#!/bin/bash

# Wait 60 seconds for SQL Server to start up by ensuring that 
# calling SQLCMD does not return an error code, which will ensure that sqlcmd is accessible
# and that system and user databases return "0" which means all databases are in an "online" state
# https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql?view=sql-server-2017 


echo "Executing script $FILE_NAME_SCRIPT_CREATE in database"
for i in {1..60};
do
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $MSSQL_SA_PASSWORD -d master -i $DIR_SCRITP_DB/$FILE_NAME_SCRIPT_CREATE
    if [ $? -eq 0 ]
    then
        echo "$FILE_NAME_SCRIPT_CREATE completed ************************************************************************"
        break
    else
		if [ $i -eq 60 ]
		then
			echo "Not execute scritp $FILE_NAME_SCRIPT_CREATE ************************************************************************"
			exit 1
		else
        	echo "not ready yet..."
        	sleep 1
		fi
    fi
done