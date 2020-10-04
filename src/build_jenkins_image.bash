#!/bin/bash

source docker_jenkins_scripts_globals.bash

echo -n "Satrting special docker jenkins buil. Please enter pass for jenkins key store : "
# read -es psswrd

psswrd=`gpg --quiet --gen-random --armor 0 24 |& tail -1`

echo $psswrd | tee $JENKINS_KEYSTORE_PASS_FILE

cd secrets
./create_secrets.bash $psswrd
cd ..

docker build -t jenkins:jcasc .
