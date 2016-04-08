#!/bin/bash
set -euo pipefail

SLAVE_ID="$1"
SLAVE_SECRET="$2"

rm -f slave.jar
curl -sLO https://build.syncthing.net/jnlpJars/slave.jar

exec java -jar slave.jar -jnlpUrl "https://build.syncthing.net/computer/${SLAVE_ID}/slave-agent.jnlp" -secret "${SLAVE_SECRET}"

