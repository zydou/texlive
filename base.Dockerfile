ARG BASE_IMG=debian
ARG OS_VARIANT=trixie-slim
FROM ${BASE_IMG}:${OS_VARIANT}
ARG DEBIAN_FRONTEND=noninteractive

# ARG declared before a FROM is outside of a build stage.
# To use the default value of an ARG declared before FROM, declare an empty ARG
ARG OS_VARIANT

# use bash instead of sh
SHELL ["/bin/bash", "-c"]

# modified from https://gitlab.com/islandoftex/images/texlive/-/blob/master/Dockerfile.base
RUN apt-get update -qq && \
    # handling special cases
    # libncurses5 is missing on Debian trixie
    if [[ "${OS_VARIANT}" != "trixie-slim" ]]; then apt-get install -qq -y --no-install-recommends --no-upgrade libncurses5; fi && \
    # libncurses6 is missing on Ubuntu xenial and bionic
    if [[ "${OS_VARIANT}" != "xenial" && "${OS_VARIANT}" != "bionic" ]]; then apt-get install -qq -y --no-install-recommends --no-upgrade libncurses6; fi && \
    # basic utilities for TeX Live installation
    apt-get install -qq -y --no-install-recommends --no-upgrade curl git wget unzip \
    # miscellaneous dependencies for TeX Live tools
    make fontconfig perl default-jre libgetopt-long-descriptive-perl \
    libdigest-perl-md5-perl \
    # for latexindent (see #13)
    libunicode-linebreak-perl libfile-homedir-perl libyaml-tiny-perl \
    # for eps conversion (see #14)
    ghostscript \
    # for metafont (see #24)
    libsm6 \
    # for syntax highlighting
    python3 python3-pkg-resources python3-pygments \
    # for gnuplot backend of pgfplots (see !13)
    gnuplot-nox && \
    # bad fix for python handling
    ln -s /usr/bin/python3 /usr/bin/python && \
    # cleanup
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/
