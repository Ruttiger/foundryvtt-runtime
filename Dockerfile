FROM node:24-bookworm-slim

ENV FOUNDRY_APP_DIR=/opt/foundry/app
ENV FOUNDRY_DATA_DIR=/data
ENV FOUNDRY_PORT=30000

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        unzip \
        tini \
        gosu \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/foundry/app /data \
    && chown -R node:node /opt/foundry /data

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /opt/foundry/app

EXPOSE 30000

VOLUME ["/opt/foundry/app", "/data"]

ENTRYPOINT ["/usr/bin/tini", "--", "/entrypoint.sh"]