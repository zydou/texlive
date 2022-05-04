FROM alpine:latest
ARG VERSION
ARG SCHEME
ENV PATH="/opt/texlive/texdir/bin/x86_64-linuxmusl:${PATH}"

COPY setup.sh texlive.profile /

RUN /setup.sh

CMD ["/bin/bash"]
