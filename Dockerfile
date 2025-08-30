FROM alpine:3.16

RUN apk add --no-cache \
    shadowsocks-libev \
    curl \
    unzip \
    && curl -L -o /tmp/v2ray-plugin.zip https://github.com/shadowsocks/v2ray-plugin/releases/latest/download/v2ray-plugin-linux-amd64.zip \
    && unzip /tmp/v2ray-plugin.zip -d /usr/local/bin \
    && chmod +x /usr/local/bin/v2ray-plugin \
    && rm -rf /tmp/*

EXPOSE 443

CMD ["ss-server", "-c", "/etc/shadowsocks/config.json"]
