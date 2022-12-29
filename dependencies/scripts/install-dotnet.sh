#!/usr/bin/env bash

set -euo pipefail

wget --tries=5 -q -O dotnet-install.sh https://dot.net/v1/dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --install-dir /usr/share/dotnet -channel Current -version latest
/usr/share/dotnet/dotnet tool install --tool-path /usr/bin dotnet-format --version 5.0.211103
