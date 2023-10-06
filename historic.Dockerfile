ARG YEAR=2018
ARG BASE_OS=trixie

FROM zydou/texlive:${YEAR}-tree as tree

FROM zydou/texlive:${BASE_OS}-baseimg

COPY --link --from=tree /usr/local/texlive /usr/local/texlive

RUN echo "Set PATH to $PATH" && \
    /usr/local/texlive/texdir/bin/*/tlmgr path add
