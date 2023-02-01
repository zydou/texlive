FROM debian:testing-slim AS installer
ARG DEBIAN_FRONTEND=noninteractive
COPY debian.profile /tmp/texlive.profile
RUN apt-get update ;\
    apt-get install -y rsync perl wget ;\
    mkdir -p /tmp/texlive ;\
    rsync -axzv --zc=zstd --delete rsync://texlive.info/CTAN/systems/texlive/tlnet/ /tmp/texlive;\
    /tmp/texlive/install-tl --profile /tmp/texlive.profile --repository /tmp/texlive ;\
    rm -rf /tmp/* ;\
    rm -rf /var/lib/apt/lists/* ;\
    rm -f /usr/local/texlive/texdir/install-tl.log
