FROM alpine
VOLUME /config
WORKDIR /config
EXPOSE 5050

RUN apk update && \
    apk add py-pip ca-certificates curl && \
    pip install -U pip && \
    pip install flexget transmissionrpc && \
    rm -rf /var/lib/apt/lists/*

COPY defaultconfig.yml /config
COPY startup.sh /startup.sh
CMD ["/startup.sh"]

HEALTHCHECK \
   --start-period=5s \
   --interval=20s \
   --timeout=10s \
        CMD curl http://localhost:5050
