#!/bin/bash

#This script copy data from GCS to HDFS using gcs hadoop connector
export GCS_CONNECT_JAR-LOCATION="./gcs-connector-1.2.8-hadoop1.jar"
export SERVICE_ACCOUNT=""
export P12_KEYFILE=""
export CLIENT_ID="" #fs.gs.auth.client.id
export CLIENT_SECRET="" #fs.gs.auth.client.secret
export PROJECT_ID="" #fs.gs.project.id

#fs.gs.auth.service.account.email=<VALUE1>
#fs.gs.auth.service.account.private.key.id=<VALUE2>
#fs.gs.auth.service.account.private.key=<VALUE3>

#export DISTCP_PROXY_OPTS="-Dhttps.proxyHost=web-proxy.example.com -Dhttps.proxyPort=80"

SFTP_RETURN_CODE=${?}

# If the return code is non-zero then the upload was not successful
export HADOOP_CLIENT_OPTS="-Xms256m -Xmx4096m"
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:${GCS_CONNECT_JAR}

hadoop distcp -Ddfs.checksum.combine.mode=COMPOSITE_CRC -Dfs.gs.auth.service.account.email="" \
-Dfs.gs.auth.service.account.private.key.id="" \
-Dfs.gs.auth.service.account.private.key="" \
gs://[BUCKET]/user/bob/* hdfs:///user/bob/

if [[ 0 != ${SFTP_RETURN_CODE} ]]
   then
   echo "sftp upload failed for file ${lcd}/${file}"
   exit ${SFTP_RETURN_CODE}
else
   echo "sftp upload successful for file ${lcd}/${file}"
fi

exit 0