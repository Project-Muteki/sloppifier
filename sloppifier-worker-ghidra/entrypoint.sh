#!/bin/bash

_PIDDIR=$(mktemp -p /tmp -d ghidra.XXXXXXXXXX)

_cleanup() {
    kill -INT "$(cat "${_PIDDIR}/ghidra.pid")"
    rm -rf "${_PIDDIR}"
}

trap _cleanup EXIT

export GHIDRASSISTMCP_EXT="${GHIDRA_HOME}/Ghidra/Extensions/GhidrAssistMCP"

if [[ -z "${PROJECT}" ]]; then
    echo 'PROJECT not specified.'
    exit 1
fi

if [[ -z "${BIN}" ]]; then
    echo 'BIN not specified.'
    exit 1
fi

# This is required if the username of the owner of the project is not "ubuntu", or Ghidra won't open the project.
if [[ ! -z "${OWNER}" ]]; then
    echo "Setting project owner to: ${OWNER}"
    export GHIDRA_HEADLESS_JAVA_OPTIONS="${GHIDRA_HEADLESS_JAVA_OPTIONS} -Duser.name=${OWNER}"
fi

"${GHIDRA_HOME}"/support/analyzeHeadless /work "${PROJECT}" -process "${BIN}" -noanalysis -scriptPath "${GHIDRASSISTMCP_EXT}/ghidra_scripts" -postScript GAMCPStartServerScript.java "host=0.0.0.0" "port=3000" "wait=true" &
echo "$!" > "${_PIDDIR}/ghidra.pid"

while true; do sleep 86400; done
