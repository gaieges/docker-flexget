#!/bin/sh

FLEXGET_PASSWORD="${FLEXGET_PASSWORD:-default password}"

confd -onetime -backend env

flexget web passwd "$FLEXGET_PASSWORD"

exec "$@"
