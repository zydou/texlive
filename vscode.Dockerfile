FROM alpine:latest
ARG VERSION
ARG SCHEME
ENV PATH="/opt/texlive/texdir/bin/x86_64-linuxmusl:${PATH}"

COPY setup.vscode.sh vscode-only.sh texlive.profile /

RUN /setup.vscode.sh

CMD ["/bin/bash"]
