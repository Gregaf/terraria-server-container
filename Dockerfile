ARG TERRARIA_VERSION

FROM debian:stable-slim AS base

RUN apt-get update -y \
    && apt-get install -y curl unzip \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://terraria.org/api/download/pc-dedicated-server/terraria-server-${TERRARIA_VERSION}.zip \
    --silent \
    --output /tmp/terraria.zip
    # && unzip /tmp/terraria.zip -d /opt

CMD ["bash"]
