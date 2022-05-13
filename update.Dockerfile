ARG TAG=latest
FROM ghcr.io/zydou/texlive:${TAG}
RUN tlmgr update --all && \
    rm -f /usr/local/texlive/texdir/texmf-var/web2c/tlmgr-commands.log \
          /usr/local/texlive/texdir/texmf-var/web2c/tlmgr.log