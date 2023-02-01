FROM debian:testing-slim
ENV TEXLIVE_INSTALL_NO_CONTEXT_CACHE=1
ARG DEBIAN_FRONTEND=noninteractive
ARG NOPERLDOC=1
ARG MIRROR_URL=rsync://texlive.info/CTAN/systems/texlive/tlnet/
COPY texlive.profile /tmp/texlive.profile

# https://gitlab.com/islandoftex/images/texlive/-/blob/master/Dockerfile.base
RUN sed -i "s/main/main contrib non-free/" /etc/apt/sources.list && \
    apt-get update -qq && \
    # basic utilities for TeX Live installation
    apt-get install -qq -y --no-install-recommends curl git wget rsync unzip \
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
    # install texlive
    mkdir -p /tmp/texlive && \
    echo "Using mirror: $MIRROR_URL" && \
    rsync -axz --zc=zstd --delete $MIRROR_URL /tmp/texlive && \
    /tmp/texlive/install-tl --profile /tmp/texlive.profile --repository /tmp/texlive && \
    # cleanup
    apt-get autoremove -y rsync && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/ && \
    rm -f /usr/local/texlive/texdir/install-tl.log
