
FROM alpine:latest

RUN apk add --no-cache shadowsocks-libev v2ray-plugin

EXPOSE 443

CMD ["ss-server", "-c", "/etc/shadowsocks/config.json"]
