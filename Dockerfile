FROM alpine

RUN apk update && \
    apk add py-pip ca-certificates curl && \
    pip install -U pip && \
    pip install flexget transmissionrpc && \
    rm -rf /var/lib/apt/lists/*

ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd


ADD config.yml.tmpl /etc/confd/templates/config.yml.tmpl
ADD flexget.toml /etc/confd/conf.d/flexget.toml
ADD entrypoint.sh /entrypoint.sh

EXPOSE 5050

ENTRYPOINT ["/entrypoint.sh"]
CMD ["flexget", "daemon", "start", "--autoreload-config"]

HEALTHCHECK --interval=20s --timeout=10s CMD curl http://localhost:5050 -o /dev/null -s
