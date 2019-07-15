#!/bin/bash
#
# Truncate the bors database to rows within the given number of days.

# DATABASE_URL is a Heroku config env var.

set -ex

DAYS=${1:-10}
TABLES=(
    attempt_statuses
    attempts
    batches
    patches
    statuses
)

for TABLE in "${TABLES[@]}"; do
    SQL="delete from ${TABLE} WHERE updated_at < current_timestamp - interval '${DAYS} days';"
    psql "${DATABASE_URL}" <<< "$SQL"
done
