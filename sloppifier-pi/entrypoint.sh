#!/bin/bash

_PIDDIR=$(mktemp -p /tmp -d pi-web.XXXXXXXXXX)

_cleanup() {
    kill -TERM "$(cat "${_PIDDIR}/sessiond.pid")"
    kill -TERM "$(cat "${_PIDDIR}/server.pid")"
    rm -rf "${_PIDDIR}"
}

trap _cleanup EXIT

[[ ! -e /home/node/.config/mcp/mcp.json ]] && mkdir -p /home/node/.config/mcp/ && cp /usr/local/share/mcp/mcp.json /home/node/.config/mcp/
pi install npm:pi-mcp-adapter

pi-web-sessiond &
echo $! > "${_PIDDIR}/sessiond.pid"

PI_WEB_HOST=0.0.0.0 PI_WEB_PORT=8080 pi-web-server &
echo $! > "${_PIDDIR}/server.pid"

while true; do sleep 86400; done
