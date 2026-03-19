FROM mumez/pharo-vnc-supervisor
LABEL maintainer="Masashi Umezawa <ume@softumeya.com>"

ARG SMALLTALK_INTEROP_DIR=/root/smalltalk-interop
ARG REPOS_URL=github://mumez/PharoSmalltalkInteropServer:main/src

RUN setup.sh && \
    save-pharo.sh metacello install ${REPOS_URL} BaselineOfPharoSmalltalkInteropServer && \
    cp -r /root/data ${SMALLTALK_INTEROP_DIR} && \
    mkdir -p ${SMALLTALK_INTEROP_DIR}/screenshots

ENV PHARO_HOME=${SMALLTALK_INTEROP_DIR}
ENV PHARO_SIS_PORT=8086
ENV PHARO_SIS_SCREENSHOT_DIR=${SMALLTALK_INTEROP_DIR}/screenshots

VOLUME ["${SMALLTALK_INTEROP_DIR}/screenshots"]

ADD ./config/startup.st ${SMALLTALK_INTEROP_DIR}/config/
ENV PHARO_START_SCRIPT=${SMALLTALK_INTEROP_DIR}/config/startup.st
