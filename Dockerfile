FROM debian:stable-slim AS base

ARG TERRARIA_VERSION=1449
ARG WORLD_MAX=3

RUN apt-get update -y \
    && apt-get install -y curl unzip tmux \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --shell /bin/bash terraria
USER terraria
WORKDIR /home/terraria

RUN curl -sS "https://terraria.org/api/download/pc-dedicated-server/terraria-server-${TERRARIA_VERSION}.zip" -o /tmp/terraria.zip \
    && unzip /tmp/terraria.zip -d /home/terraria/ \
    && rm /tmp/terraria.zip \
    && rm -rf "/home/terraria/${TERRARIA_VERSION}/Windows" "/home/terraria/${TERRARIA_VERSION}/Mac" \
    && chmod +x "/home/terraria/${TERRARIA_VERSION}/Linux/TerrariaServer.bin.x86_64"

COPY ./terraria-start.sh /home/terraria/start-terraria.sh

USER root
RUN chmod +x /home/terraria/start-terraria.sh

USER terraria

ENV TERRARIA_SERVER_BIN="/home/terraria/${TERRARIA_VERSION}/Linux/TerrariaServer.bin.x86_64"
ENV WORLD_MAX=${WORLD_MAX}

CMD ["/home/terraria/start-terraria.sh"]
