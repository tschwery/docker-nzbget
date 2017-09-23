#!/bin/sh

NZB_OUTPUT="/downloads"

if [ ! -d "$NZB_OUTPUT" ]; then
    mkdir "$NZB_OUTPUT"
fi

mkdir "$USER_HOME/intermediate" "$USER_HOME/nzb" "$USER_HOME/queue" "$USER_HOME/tmp"

exec "$@"
