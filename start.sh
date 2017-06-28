#!/bin/sh

USER_CONF=/home/nzbget/nzbget.conf

cat /app/nzbget.conf > "$USER_CONF"

if [ -z "$NZB_OUTPUT" ]; then
    NZB_OUTPUT="$HOME/downloads"
fi

if [ ! -d "$NZB_OUTPUT" ]; then
    mkdir "$NZB_OUTPUT"
fi

printf "DestDir = $NZB_OUTPUT" | crudini --merge "$USER_CONF" \
    ""

mkdir "$HOME/intermediate" "$HOME/nzb" "$HOME/queue" "$HOME/tmp"

crudini --merge "$USER_CONF" "" <<EOF
InterDir=${HOME}/intermediate
NzbDir=${HOME}/nzb
QueueDir=${HOME}/queue
TempDir=${HOME}/tmp
LockFile=${HOME}/nzbget.lock
LogFile=${HOME}/nzbget.log
EOF

if [ -n "$NZB_SETTINGS" ]; then
    printf "$NZB_SETTINGS" | crudini --merge "$USER_CONF" \
        ""
fi

exec "$@"
