FROM alpine:latest

RUN sed -i -e 's@http:@https:@g' /etc/apk/repositories \
    && apk update \
    && apk add --no-cache shadowsocks-libev v2ray-plugin

EXPOSE 443

CMD ["ss-server", "-c", "/etc/secrets/config.json"]

