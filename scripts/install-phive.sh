#!/usr/bin/env bash

set -euo pipefail

wget --tries=5 -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk
apk add --no-cache \
  bash \
  ca-certificates \
  glibc-${GLIBC_VERSION}.apk \
  tar zstd \
  gnupg \
  php7 php7-curl php7-ctype php7-dom php7-iconv php7-json php7-mbstring \
  php7-openssl php7-phar php7-simplexml php7-tokenizer php-xmlwriter
rm glibc-${GLIBC_VERSION}.apk
wget -q --tries=5 -O /tmp/libz.tar.zst https://www.archlinux.org/packages/core/x86_64/zlib/download
mkdir /tmp/libz
tar -xf /tmp/libz.tar.zst -C /tmp/libz --zstd
mv /tmp/libz/usr/lib/libz.so* /usr/glibc-compat/lib
rm -rf /tmp/libz /tmp/libz.tar.zst
wget -q --tries=5 -O phive.phar https://phar.io/releases/phive.phar
wget -q --tries=5 -O phive.phar.asc https://phar.io/releases/phive.phar.asc
gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys "0x9D8A98B29B2D5D79"
gpg --verify phive.phar.asc phive.phar
chmod +x phive.phar
mv phive.phar /usr/local/bin/phive
rm phive.phar.asc
phive --no-progress install --trust-gpg-keys 31C7E470E2138192,CF1A108D0E7AE720,8A03EA3B385DBAA1,12CE0F1D262429A5 --target /usr/bin phpstan@^1.3.3 psalm@^4.18.1 phpcs@^3.6.2
