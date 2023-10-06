ARG BASE_OS=trixie
FROM zydou/texlive:${BASE_OS}-baseimg AS installer
ENV TEXLIVE_INSTALL_NO_CONTEXT_CACHE=1
ARG DEBIAN_FRONTEND=noninteractive
ARG NOPERLDOC=1
ARG YEAR=2018
ARG MIRROR_URL=https://mirrors.tuna.tsinghua.edu.cn/tex-historic-archive/systems/texlive/2018/tlnet-final/

# install texlive
COPY texlive.profile /tmp/texlive.profile
RUN mkdir -p /tmp/texlive && \
    curl -sSLf -o "/tmp/texlive_part00" "https://github.com/zydou/texlive/releases/download/texlive-${YEAR}/texlive_${YEAR}_part00" && \
    curl -sSLf -o "/tmp/texlive_part01" "https://github.com/zydou/texlive/releases/download/texlive-${YEAR}/texlive_${YEAR}_part01" && \
    curl -sSLf -o "/tmp/texlive_part02" "https://github.com/zydou/texlive/releases/download/texlive-${YEAR}/texlive_${YEAR}_part02" && \
    curl -sSLf -o "/tmp/texlive_part03" "https://github.com/zydou/texlive/releases/download/texlive-${YEAR}/texlive_${YEAR}_part03" && \
    cat /tmp/texlive_part* > /tmp/archive.tar && \
    rm -f /tmp/texlive_part* && \
    tar -xf /tmp/archive.tar -C /tmp/texlive --strip-components=1 && \
    rm -f /tmp/archive.tar && \
    /tmp/texlive/install-tl --profile /tmp/texlive.profile --repository /tmp/texlive && \
    # fix repository url
    /usr/local/bin/tlmgr option repository "${MIRROR_URL}" && \
    # cleanup
    rm -rf /tmp/* && \
    rm -f /usr/local/texlive/texdir/install-tl.log && \
    find /usr/local/texlive/texdir/texmf-var/web2c -type f -name "*.log" -exec rm {} \;

# create data image containing only the TeX Live installation
FROM scratch AS data
COPY --link --from=installer /usr/local/texlive /usr/local/texlive
