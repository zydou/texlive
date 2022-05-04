#!/bin/sh

set -e
set -o pipefail

retry() {
  retries=$1
  shift

  count=0
  until "$@"; do
    exit=$?
    wait="$(echo "2^$count" | bc)"
    count="$(echo "$count + 1" | bc)"
    if [ "$count" -lt "$retries" ]; then
      echo "Retry $count/$retries exited $exit, retrying in $wait seconds..."
      sleep "$wait"
    else
      echo "Retry $count/$retries exited $exit, no more retries left."
      return "$exit"
    fi
  done
}

echo "==> Install system packages"
apk --no-cache add \
  bash \
  fontconfig \
  ghostscript \
  gnupg \
  graphviz \
  openjdk11-jre-headless \
  perl \
  py-pygments \
  python2 \
  python3 \
  tar \
  ttf-freefont \
  wget \
  xz

# Dependencies needed by latexindent
apk --no-cache add \
  perl-log-dispatch \
  perl-log-log4perl \
  perl-namespace-autoclean \
  perl-params-validationcompiler \
  perl-specio \
  perl-unicode-linebreak \
  perl-yaml-tiny
apk --no-cache \
  --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing \
  add \
  perl-file-homedir

echo "==> Install TeXLive"
mkdir -p /tmp/install-tl
cd /tmp/install-tl
wget -nv "https://ftp.tu-chemnitz.de/pub/tug/historic/systems/texlive/${VERSION}/tlnet-final/install-tl-unx.tar.gz"
wget -nv "https://ftp.tu-chemnitz.de/pub/tug/historic/systems/texlive/${VERSION}/tlnet-final/install-tl-unx.tar.gz.sha512"
wget -nv "https://ftp.tu-chemnitz.de/pub/tug/historic/systems/texlive/${VERSION}/tlnet-final/install-tl-unx.tar.gz.sha512.asc"
wget -nv "https://www.tug.org/texlive/files/texlive.asc"
mkdir -m 700 ~/.gnupg && touch ~/.gnupg/trustedkeys.kbx  # https://superuser.com/a/1641496
gpg --no-default-keyring --keyring trustedkeys.kbx --import texlive.asc
gpgv ./install-tl-unx.tar.gz.sha512.asc ./install-tl-unx.tar.gz.sha512
sha512sum -c ./install-tl-unx.tar.gz.sha512
mkdir -p /tmp/install-tl/installer
tar --strip-components 1 -zxf /tmp/install-tl/install-tl-unx.tar.gz -C /tmp/install-tl/installer
retry 3 /tmp/install-tl/installer/install-tl -scheme ${SCHEME} -repository "https://ftp.tu-chemnitz.de/pub/tug/historic/systems/texlive/${VERSION}/tlnet-final" -profile=/texlive.profile

# System font configuration for XeTeX and LuaTeX
# Ref: https://www.tug.org/texlive/doc/texlive-en/texlive-en.html#x1-330003.4.4
ln -s /usr/local/texlive/texdir/texmf-var/fonts/conf/texlive-fontconfig.conf /etc/fonts/conf.d/09-texlive.conf
fc-cache -fv

echo "==> Clean up"
rm -rf \
  /usr/local/texlive/texdir/install-tl \
  /usr/local/texlive/texdir/install-tl.log \
  /usr/local/texlive/texdir/texmf-var/web2c/tlmgr.log \
  /root/.gnupg \
  /setup.sh \
  /texlive.profile \
  /tmp/install-tl
