ARG YEAR=2018
ARG BASE_OS=trixie

FROM ghcr.io/zydou/texlive:${YEAR}-sources as tree

FROM ghcr.io/zydou/texlive:${BASE_OS}-baseimg

COPY --link --from=tree /usr/local/texlive /usr/local/texlive

RUN echo "Set PATH to $PATH" && \
    /usr/local/texlive/texdir/bin/*/tlmgr path add
