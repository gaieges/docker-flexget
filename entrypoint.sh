#!/bin/sh

FLEXGET_PASSWORD="${FLEXGET_PASSWORD:-default password}"

confd -onetime -backend env

# on startup make sure that we get rid of the lock file as it prevents startup
LOCKFILE=/config/.config-lock
test -f $LOCKFILE && rm $LOCKFILE

flexget web passwd "$FLEXGET_PASSWORD"

exec "$@"
