#! /bin/bash
GH_USER=$(cat /deployment/secrets/github_pck_user)
GH_PASS=$(cat /deployment/secrets/github_pck_token)
export DB_CONN_STRING_LOC="/deployment/secrets/db_conn_string"
REGISTRY="ghcr.io"

echo $GH_PASS | docker login $REGISTRY -u $GH_USER --password-stdin
docker compose pull
docker compose up -d
docker logout $REGISTRY

exit 0
