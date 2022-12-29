#!/usr/bin/env bash

set -euo pipefail

mkdir -p ${PWSH_DIRECTORY}
curl --retry 5 --retry-delay 5 --show-error -s https://api.github.com/repos/powershell/powershell/releases/${PWSH_VERSION} |
  grep browser_download_url |
  grep linux-alpine-x64 |
  cut -d '"' -f 4 |
  xargs -n 1 wget -q -O - |
  tar -xzC ${PWSH_DIRECTORY}
chmod +x ${PWSH_DIRECTORY}/pwsh
ln -sf ${PWSH_DIRECTORY}/pwsh /usr/bin/pwsh
pwsh -c 'Install-Module -Name PSScriptAnalyzer -RequiredVersion ${PSSA_VERSION} -Scope AllUsers -Force'
