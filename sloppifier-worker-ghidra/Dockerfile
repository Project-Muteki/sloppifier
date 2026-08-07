FROM docker.io/library/eclipse-temurin:25

ARG GHIDRA_RELEASE='https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_12.1.2_build/ghidra_12.1.2_PUBLIC_20260605.zip'
ARG GHIDRASSISTMCP_RELEASE='https://github.com/symgraph/GhidrAssistMCP/releases/download/2.11.0/ghidra_12.1_PUBLIC_20260802_GhidrAssistMCP.zip'

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
 && apt-get install -y unzip curl \
 && cd /tmp \
 && curl -o ghidra.zip -L "${GHIDRA_RELEASE}" \
 && curl -o ghidrassistmcp.zip -L "${GHIDRASSISTMCP_RELEASE}" \
 && mkdir -p ghidra \
 && unzip ghidra.zip -d ghidra \
 && cp -r ghidra/ghidra_*_PUBLIC /app \
 && unzip ghidrassistmcp.zip -d /app/Ghidra/Extensions/ \
 && mkdir /work \
 && chown ubuntu:ubuntu /work \
 && apt-get autoremove --purge -y unzip curl \
 && rm -rf /var/lib/apt/lists/*

ENV GHIDRA_HOME='/app' PROJECT='' BIN='' OWNER='' GHIDRA_HEADLESS_JAVA_OPTIONS='' 

COPY --chmod=555 entrypoint.sh /app/entrypoint.sh

VOLUME /work
VOLUME /home/ubuntu

EXPOSE 3000/tcp

USER ubuntu:ubuntu

ENTRYPOINT ["/app/entrypoint.sh"]
