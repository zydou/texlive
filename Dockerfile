ARG YEAR=2023
ARG BASE_OS=trixie

FROM ghcr.io/zydou/texlive:${YEAR}-${BASE_OS} AS normal
RUN tlmgr update --self --all && \
    rm -f /usr/local/texlive/texdir/tlpkg/texlive.tlpdb.* && \
    find /usr/local/texlive/texdir/texmf-var/web2c -type f -name "*.log" -exec rm {} \;


# In certain legacy systems, the GLIBC version is too old to complete the post-script tasks following a tlmgr update.
# So we update the texlive on Debian trixie first and then copy them to the final image
FROM ghcr.io/zydou/texlive:${YEAR}-trixie AS base
RUN tlmgr update --self --all && \
    rm -f /usr/local/texlive/texdir/tlpkg/texlive.tlpdb.* && \
    find /usr/local/texlive/texdir/texmf-var/web2c -type f -name "*.log" -exec rm {} \;


FROM ghcr.io/zydou/texlive:${BASE_OS}-baseimg AS old-glibc
COPY --link --from=base /usr/local/texlive /usr/local/texlive
RUN echo "Set PATH to $PATH" && \
    /usr/local/texlive/texdir/bin/*/tlmgr path add
