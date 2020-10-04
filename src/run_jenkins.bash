#!/bin/bash

source docker_jenkins_scripts_globals.bash

echo -n "Satrting docker jenkins container. Please enter pass : "
# read -es psswrd

psswrd=`gpg --quiet --gen-random --armor 0 24 |& tail -1`

echo $psswrd

keytore_pass=`cat ${JENKINS_KEYSTORE_PASS_FILE}`

# Keep this directory for persistency
volume_base=`dirname $(pwd)`/run/jenkins_home

docker run --name jenkins --rm  -p 443:8443 -v $volume_base:/var/jenkins_home --env JENKINS_ADMIN_ID=$JENKINS_INITIAL_ADMIN_NAME --env JENKINS_ADMIN_PASSWORD="$psswrd" jenkins:jcasc --httpPort=-1 --httpsPort=8443 --httpsKeyStore=/usr/share/jenkins/ref/jenkins_keystore.jks --httpsKeyStorePassword="$keytore_pass"

