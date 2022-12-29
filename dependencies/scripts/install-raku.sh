#!/usr/bin/env bash

set -euo pipefail

apk add --no-cache rakudo zef

######################
# Install CheckStyle #
######################
curl --retry 5 --retry-delay 5 --show-error -sSL "https://github.com/checkstyle/checkstyle/releases/download/checkstyle-${CHECKSTYLE_VERSION}/checkstyle-${CHECKSTYLE_VERSION}-all.jar" --output /usr/bin/checkstyle

##############################
# Install google-java-format #
##############################
curl --retry 5 --retry-delay 5 --show-error -sSL "https://github.com/google/google-java-format/releases/download/v${GOOGLE_JAVA_FORMAT_VERSION}/google-java-format-${GOOGLE_JAVA_FORMAT_VERSION}-all-deps.jar" --output /usr/bin/google-java-format

#################################
# Install luacheck and luarocks #
#################################
wget --tries=5 -q https://www.lua.org/ftp/lua-5.3.5.tar.gz -O - -q | tar -xzf -
cd lua-5.3.5
make linux
make install
cd .. && rm -r lua-5.3.5/
wget --tries=5 -q https://github.com/cvega/luarocks/archive/v3.3.1-super-linter.tar.gz -O - -q | tar -xzf -
cd luarocks-3.3.1-super-linter
./configure --with-lua-include=/usr/local/include
make
make -b install
cd ..
rm -r luarocks-3.3.1-super-linter/
luarocks install luacheck
luarocks install argparse
luarocks install luafilesystem
mv /etc/R/* /usr/lib/R/etc/
find /usr/ -type f -name '*.md' -exec rm {} +
