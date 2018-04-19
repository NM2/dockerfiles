#!/bin/bash
# Inspired by https://raw.githubusercontent.com/alien4cloud/alien4cloud.github.io/sources/files/1.4.0/getting_started.sh

# PostStart function for init getting started
configurePuccini ()
{
    echo "Waiting for alien4cloud to start"
    until $(curl --output /dev/null --silent --head --fail http://localhost:8088); do
      printf '.'
      sleep 5
    done

    ALIEN_URL="http://localhost:8088"
    ALIEN_LOGIN="admin"
    ALIEN_PWD="admin"
    PUCCINI_DIR=puccini-cli-$PUCCINI_VERSION

    echo "Login"
    curl -c curlcookie.txt "$ALIEN_URL/login?username=$ALIEN_LOGIN&password=$ALIEN_PWD&submit=Login" \
    -XPOST \
    -H 'Content-Type: application/x-www-form-urlencoded'

    echo "Create puccini orchestrator"
    ORCHESTRATORID=`curl "$ALIEN_URL/rest/latest/orchestrators" \
    -b curlcookie.txt \
    -XPOST \
    -H 'Content-Type: application/json; charset=UTF-8' \
    -H 'Accept: application/json, text/plain, */*' \
    --data-binary '{"name":"Puccini simple orchestrator","pluginId":"alien4cloud-plugin-puccini","pluginBean":"puccini-orchestrator"}' | \
        python -c "import sys, json; print json.load(sys.stdin)['data']"`

    echo "Created orchestrator with id $ORCHESTRATORID"

    echo "Update orchestrator configuration"
    curl "$ALIEN_URL/rest/latest/orchestrators/$ORCHESTRATORID/configuration" \
    -XPUT \
    -s -b curlcookie.txt \
    -H 'Content-Type: application/json; charset=UTF-8' \
    -H 'Accept: application/json, text/plain, */*' \
    --data-binary "{\"pucciniHome\":\"$INSTALL_DIR/$PUCCINI_DIR\"}"

    echo "Enable orchestrator (takes a few secs as it checks and configure puccini)"
    curl "$ALIEN_URL/rest/latest/orchestrators/$ORCHESTRATORID/instance" \
    -XPOST \
    -s -b curlcookie.txt \
    -H 'Content-Type: application/json; charset=UTF-8' \
    -H 'Accept: application/json, text/plain, */*' \
    --data-binary '{}'
}

INSTALL_DIR="$1"
PUCCINI_VERSION="$2"

cd $INSTALL_DIR

# Configure Puccini only once
if [ ! -f install.log ]; then
    configurePuccini > install.log 2>&1 &
fi

echo "Starting alien4cloud"
cd alien4cloud && ./alien4cloud.sh

