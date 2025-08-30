FROM alpine:3.16

RUN apk add --no-cache curl tar libc6-compat

# Установка shadowsocks (qdm12)
RUN curl -L -o /usr/local/bin/ss-server \
    https://github.com/qdm12/ss-server/releases/latest/download/ss-server \
    && chmod +x /usr/local/bin/ss-server

# Установка v2ray-plugin (с проверенной ссылкой)
RUN curl -L -o /tmp/v2ray-plugin.tar.gz \
    https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.2/v2ray-plugin-linux-amd64-v1.3.2.tar.gz \
    && tar -xz -C /usr/local/bin -f /tmp/v2ray-plugin.tar.gz \
    && chmod +x /usr/local/bin/v2ray-plugin \
    && rm -rf /tmp/*

EXPOSE 443

CMD ["ss-server", "-c", "/etc/secrets/config.json"]

