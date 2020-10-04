#!/bin/bash

source ../docker_jenkins_scripts_globals.bash

psswrd=`cat ../${JENKINS_KEYSTORE_PASS_FILE}`

# Create > certificate + key
openssl req -x509 -days 365 -passout pass:"$psswrd" -newkey rsa:4096 -subj "/CN=Jenkins Self Signed" -keyout jenkins_selfsigned.key -out jenkins_selfsigned.crt

# Convert tp pkcs12 which can be imported as keystore file
openssl pkcs12 -export -in jenkins_selfsigned.crt -inkey jenkins_selfsigned.key -passin pass:"$psswrd" -out jenkins_selfsigned.p12 -passout pass:"$psswrd"

rm -f $JENKINS_KEYSTORE_FILE

# Import to jenkins keystore
keytool -importkeystore -srckeystore jenkins_selfsigned.p12 -srcstoretype PKCS12 -srcstorepass "$psswrd" -deststoretype PKCS12 -destkeystore $JENKINS_KEYSTORE_FILE -deststorepass "$psswrd"
