FROM zydou/texlive:latest
RUN tlmgr update --self --all && \
    rm -f /usr/local/texlive/texdir/texmf-var/web2c/tlmgr-commands.log \
          /usr/local/texlive/texdir/texmf-var/web2c/tlmgr.log
