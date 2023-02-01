FROM alpine
ARG YEAR
RUN set -ex ; \
    apk add --no-cache --virtual .build-deps rsync;\
    mkdir -p /root/texlive;\
    rsync -av --delete "rsync://texlive.info/historic/systems/texlive/$YEAR/tlnet-final/" /root/texlive;\
    apk del .build-deps