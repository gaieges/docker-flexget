#!/bin/sh

FLEXGET_PASSWORD="${FLEXGET_PASSWORD:-default password}"

# on startup make sure that we get rid of the lock file as it prevents startup
LOCKFILE=/config/.config-lock
test -f $LOCKFILE && rm $LOCKFILE

# copy over default config if one doesn't already exist
test -f /config/config.yml || cp defaultconfig.yml config.yml

flexget web passwd "$FLEXGET_PASSWORD"
flexget daemon start --autoreload-config
