FROM alpine:3.16

RUN apk add --no-cache curl jq tar libc6-compat

# Устанавливаем ss-server от qdm12
RUN curl -L -o /usr/local/bin/ss-server https://github.com/qdm12/ss-server/releases/latest/download/ss-server \
  && chmod +x /usr/local/bin/ss-server

# Устанавливаем v2ray-plugin через GitHub API
RUN export URL="$(curl -s https://api.github.com/repos/shadowsocks/v2ray-plugin/releases/latest | \
    jq -r '.assets[] | select(.name | test("linux-amd64.*\\.tar\\.gz$")).browser_download_url')" && \
    echo "Downloading plugin from $URL" && \
    curl -L -o /tmp/v2ray-plugin.tar.gz "$URL" && \
    tar -xz -C /usr/local/bin -f /tmp/v2ray-plugin.tar.gz && \
    chmod +x /usr/local/bin/v2ray-plugin && \
    rm -rf /tmp/*

EXPOSE 443

CMD ["ss-server", "-c", "/etc/secrets/config.json"]

