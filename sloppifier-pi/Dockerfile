FROM docker.io/library/node:26-slim

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && apt-get install -y --no-install-recommends bash ca-certificates git ripgrep \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /workspace \
 && chown node:node /workspace

RUN npm install -g --ignore-scripts @earendil-works/pi-coding-agent

# node-pty has a native extension that needs to be built, therefore we also need to install Python for node-gyp, and the C toolchain.
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && apt-get install -y --no-install-recommends make python3 python-is-python3 build-essential \
 && npm install -g --allow-scripts=node-pty @jmfederico/pi-web \
 && apt-get autoremove --purge -y make python3 python-is-python3 build-essential \
 && rm -rf /var/lib/apt/lists/*

# Setup entrypoint and pre-baked MCP configuration file
COPY --chmod=555 entrypoint.sh /usr/local/bin/priv-pi-web-entrypoint.sh
COPY mcp.json /usr/local/share/mcp/mcp.json

VOLUME /workspace
VOLUME /home/node

WORKDIR /workspace

EXPOSE 8080/tcp

USER node

ENTRYPOINT ["/usr/local/bin/priv-pi-web-entrypoint.sh"]
