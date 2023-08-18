FROM debian:10-slim
ENV TEXLIVE_INSTALL_NO_CONTEXT_CACHE=1
ARG DEBIAN_FRONTEND=noninteractive
ARG NOPERLDOC=1
ARG YEAR=2018
ARG MIRROR_URL=https://mirrors.tuna.tsinghua.edu.cn/tex-historic-archive/systems/texlive/2018/tlnet-final/

# use bash instead of sh
SHELL ["/bin/bash", "-c"]

# from https://gitlab.com/islandoftex/images/texlive/-/blob/master/Dockerfile.base
RUN apt-get update -qq && \
    # basic utilities for TeX Live installation
    apt-get install -qq -y --no-install-recommends curl git wget unzip \
    # miscellaneous dependencies for TeX Live tools
    make fontconfig perl default-jre libgetopt-long-descriptive-perl \
    libdigest-perl-md5-perl libncurses5 libncurses6 \
    # for latexindent (see #13)
    libunicode-linebreak-perl libfile-homedir-perl libyaml-tiny-perl \
    # for eps conversion (see #14)
    ghostscript \
    # for metafont (see #24)
    libsm6 \
    # for syntax highlighting
    python3 python3-pygments \
    # for gnuplot backend of pgfplots (see !13)
    gnuplot-nox && \
    # bad fix for python handling
    ln -s /usr/bin/python3 /usr/bin/python && \
    # cleanup
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/

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
    rm -f /usr/local/texlive/texdir/install-tl.log
