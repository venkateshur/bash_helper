#!/bin/bash

# This script assumes that a public / private key pair has been setup already between the
# client account that is running the script on the local machine

export user=""
export host_server=""
export lcd=""
export dcd=""
export file=$1
sftp -v fx_zzzzz@filex-m1.oclc.org <<EOF
lcd ${lcd}
cd ${dcd}
put ${file}
quit
EOF

# Best practice is to assign the sftp return code to a variable for further use, because
# ${?} is fleeting and only shows the condition code of the immediately preceding command

SFTP_RETURN_CODE=${?}

# If the return code is non-zero then the upload was not successful

if [[ 0 != ${SFTP_RETURN_CODE} ]]
   then
   echo "sftp upload failed for file ${lcd}/${file}"
   exit ${SFTP_RETURN_CODE}
else
   echo "sftp upload successful for file ${lcd}/${file}"
fi

exit 0