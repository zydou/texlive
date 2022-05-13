ARG TAG=latest
FROM ghcr.io/zydou/texlive:${TAG}
COPY vscode.sh /
RUN sh /vscode.sh
CMD ["/bin/bash"]