FROM alpine:3.16

RUN apk add --no-cache curl tar jq libc6-compat

# ss-server qdm12
RUN curl -L -o /usr/local/bin/ss-server https://github.com/qdm12/ss-server/releases/latest/download/ss-server \
    && chmod +x /usr/local/bin/ss-server

# v2ray-plugin
RUN curl -s https://api.github.com/repos/shadowsocks/v2ray-plugin/releases/latest \
    | jq -r '.assets[] | select(.name | test("linux-amd64.*\\.tar\\.gz$")).browser_download_url' \
    | xargs -n 1 curl -L -o /tmp/v2ray-plugin.tar.gz \
    && tar -xzf /tmp/v2ray-plugin.tar.gz -C /usr/local/bin \
    && chmod +x /usr/local/bin/v2ray-plugin \
    && rm -rf /tmp/*
    
EXPOSE 443

CMD ["ss-server", "-c", "/etc/secrets/config.json"]
