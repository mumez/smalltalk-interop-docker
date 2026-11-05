ARG PHARO_IMAGE_VERSION=140
FROM mumez/pharo-vnc-supervisor:pharo${PHARO_IMAGE_VERSION}
LABEL maintainer="Masashi Umezawa <ume@softumeya.com>"

ARG PHARO_IMAGE_VERSION
ARG SMALLTALK_INTEROP_DIR=/root/smalltalk-interop
ARG REPOS_URL=github://mumez/PharoSmalltalkInteropServer:main/src

# Pharo 14 takes the project name without the BaselineOf prefix; Pharo 13 and earlier expect the full name.
# save-pharo.sh exits 0 even if the install fails, so check for SisServer to fail the build explicitly.
RUN if [ "${PHARO_IMAGE_VERSION}" -ge 140 ]; then \
        PROJECT_NAME=PharoSmalltalkInteropServer; \
    else \
        PROJECT_NAME=BaselineOfPharoSmalltalkInteropServer; \
    fi && \
    PHARO_MODE=headless setup.sh && \
    PHARO_MODE=headless save-pharo.sh metacello install ${REPOS_URL} ${PROJECT_NAME} && \
    pharo -vm-display-null /root/data/Pharo.image eval "(Smalltalk globals includesKey: #SisServer) ifFalse: [ Smalltalk exit: 1 ]" && \
    cp -r /root/data ${SMALLTALK_INTEROP_DIR} && \
    mkdir -p /root/screenshots && \
    mkdir -p /root/repos

ENV PHARO_HOME=${SMALLTALK_INTEROP_DIR}
ENV PHARO_SIS_PORT=8086
ENV PHARO_SIS_SCREENSHOT_DIR=/root/screenshots

ADD ./config/startup.st ${SMALLTALK_INTEROP_DIR}/config/
ENV PHARO_START_SCRIPT=${SMALLTALK_INTEROP_DIR}/config/startup.st

VOLUME ["${SMALLTALK_INTEROP_DIR}", "${PHARO_SIS_SCREENSHOT_DIR}", "/root/repos"]
