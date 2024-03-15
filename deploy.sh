#! /bin/bash
echo "Setting env variables"
GH_USER=$(cat /deployment/secrets/github_pck_user)
GH_PASS=$(cat /deployment/secrets/github_pck_token)
export DB_CONN_STRING_LOC="/deployment/secrets/db_conn_string"
export GRAFANA_PW_STRING_LOC="/deployment/secrets/grafana_password"
REGISTRY="ghcr.io"

echo "Logging in to github package repo"
echo $GH_PASS | docker login $REGISTRY -u $GH_USER --password-stdin

echo "Pulling the image"
docker compose pull

echo "Starting the container"
docker compose up -d

echo "Logging out of github package repo"
docker logout $REGISTRY

echo "Deploy script done"
exit 0
