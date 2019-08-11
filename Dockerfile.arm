FROM balenalib/raspberrypi3-alpine:3.8
WORKDIR /config
VOLUME /config
EXPOSE 5050

RUN [ "cross-build-start" ]
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk update && \
    apk add py-pip ca-certificates curl && \
    pip install -U pip && \
    pip install flexget transmissionrpc && \
    rm -rf /var/lib/apt/lists/*
RUN [ "cross-build-end" ]

COPY defaultconfig.yml /config
COPY startup.sh /startup.sh
CMD ["/startup.sh"]

HEALTHCHECK \
   --start-period=5s \
   --interval=20s \
   --timeout=10s \
        CMD curl http://localhost:5050
