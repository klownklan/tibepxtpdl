FROM alpine:3.16

RUN apk add --no-cache curl libc6-compat

# ss-server от qdm12
RUN curl -L -o /usr/local/bin/ss-server https://github.com/qdm12/ss-server/releases/latest/download/ss-server \
    && chmod +x /usr/local/bin/ss-server

# v2ray-plugin
COPY bin/v2ray-plugin /usr/local/bin/v2ray-plugin
RUN chmod +x /usr/local/bin/v2ray-plugin

EXPOSE 443

CMD ["ss-server", "-c", "/etc/secrets/config.json"]
