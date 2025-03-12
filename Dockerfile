FROM debian:12-slim AS base

ARG TERRARIA_VERSION=1449

COPY ./terraria-start.sh /opt/terraria/start-terraria.sh

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends curl unzip ca-certificates \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home --shell /bin/bash --no-log-init terraria \
    && mkdir -p /opt/terraria && chown terraria:terraria /opt/terraria \
    && chmod +x /opt/terraria/start-terraria.sh && chown terraria:terraria /opt/terraria/start-terraria.sh

USER terraria
WORKDIR /opt/terraria

RUN curl -fsSL "https://terraria.org/api/download/pc-dedicated-server/terraria-server-${TERRARIA_VERSION}.zip" -o /tmp/terraria.zip \
    && unzip /tmp/terraria.zip -d /opt/terraria/ \
    && rm /tmp/terraria.zip \
    && rm -rf "/opt/terraria/${TERRARIA_VERSION}/Windows" "/opt/terraria/${TERRARIA_VERSION}/Mac" \
    && chmod +x "/opt/terraria/${TERRARIA_VERSION}/Linux/TerrariaServer.bin.x86_64"

ENV TERRARIA_SERVER_BIN="/opt/terraria/${TERRARIA_VERSION}/Linux/TerrariaServer.bin.x86_64"

CMD ["/opt/terraria/start-terraria.sh"]
