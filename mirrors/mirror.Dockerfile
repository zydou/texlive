FROM alpine
RUN set -ex ; \
    apk add --no-cache --virtual .build-deps rsync ;\
    mkdir -p /root/texlive ;\
    rsync -av --delete "rsync://texlive.info/CTAN/systems/texlive/tlnet/" /root/texlive ;\
    apk del .build-deps