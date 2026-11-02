ARG PHARO_IMAGE_VERSION=140
FROM mumez/pharo-vnc-supervisor:pharo${PHARO_IMAGE_VERSION}
LABEL maintainer="Masashi Umezawa <ume@softumeya.com>"

ARG SMALLTALK_INTEROP_DIR=/root/smalltalk-interop
ARG REPOS_URL=github://mumez/PharoSmalltalkInteropServer:main/src

RUN PHARO_MODE=headless setup.sh && \
    PHARO_MODE=headless save-pharo.sh metacello install ${REPOS_URL} BaselineOfPharoSmalltalkInteropServer && \
    cp -r /root/data ${SMALLTALK_INTEROP_DIR} && \
    mkdir -p /root/screenshots \
    mkdir -p /root/repos

ENV PHARO_HOME=${SMALLTALK_INTEROP_DIR}
ENV PHARO_SIS_PORT=8086
ENV PHARO_SIS_SCREENSHOT_DIR=/root/screenshots

ADD ./config/startup.st ${SMALLTALK_INTEROP_DIR}/config/
ENV PHARO_START_SCRIPT=${SMALLTALK_INTEROP_DIR}/config/startup.st

VOLUME ["${SMALLTALK_INTEROP_DIR}", "${PHARO_SIS_SCREENSHOT_DIR}", "/root/repos"]
