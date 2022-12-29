#!/usr/bin/env bash

set -euox pipefail

wget --tries=5 -q -O kubeval-linux-amd64.tar.gz https://github.com/instrumenta/kubeval/releases/download/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz
tar xf kubeval-linux-amd64.tar.gz
mv kubeval /usr/local/bin
rm kubeval-linux-amd64.tar.gz

##################
# Install ktlint #
##################
curl --retry 5 --retry-delay 5 -sSLO "https://github.com/pinterest/ktlint/releases/download/${KTLINT_VERSION}/ktlint"
chmod a+x ktlint
mv "ktlint" /usr/bin/
terrascan init
cd ~ && touch .chktexrc

####################
# Install dart-sdk #
####################
wget --tries=5 -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk
apk add --no-cache glibc-${GLIBC_VERSION}.apk
rm glibc-${GLIBC_VERSION}.apk
wget --tries=5 -q https://storage.googleapis.com/dart-archive/channels/stable/release/${DART_VERSION}/sdk/dartsdk-linux-x64-release.zip
unzip -q dartsdk-linux-x64-release.zip
chmod +x dart-sdk/bin/dart* && mv dart-sdk/bin/* /usr/bin/ && mv dart-sdk/lib/* /usr/lib/ && mv dart-sdk/include/* /usr/include/
rm -r dart-sdk/ dartsdk-linux-x64-release.zip

################################
# Create and install Bash-Exec #
################################
printf '#!/bin/bashn\nif [[ -x "$1" ]]; then exit 0; else echo "Error: File:[$1] is not executable"; exit 1; fi' >/usr/bin/bash-exec
chmod +x /usr/bin/bash-exec
