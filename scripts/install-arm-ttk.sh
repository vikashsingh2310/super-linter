#!/usr/bin/env bash

set -euo pipefail

curl --retry 5 --retry-delay 5 --show-error -sLO "https://github.com/Azure/arm-ttk/archive/master.zip"
unzip "master.zip" -d "/usr/lib/microsoft"
rm "master.zip"
ln -sTf "/usr/lib/microsoft/arm-ttk-master/arm-ttk/arm-ttk.psd1" /usr/bin/arm-ttk
