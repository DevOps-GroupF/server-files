#! /bin/bash
echo "--Setting env variables--"
GH_USER=$(cat /deployment/secrets/github_pck_user)
GH_PASS=$(cat /deployment/secrets/github_pck_token)
export DB_CONN_URL=$(cat /deployment/secrets/db_conn_url)
export DB_CONN_USER=$(cat /deployment/secrets/db_conn_user)
export DB_CONN_PASSWORD=$(cat /deployment/secrets/db_conn_password)
export DB_CONN_STRING=$(cat /deployment/secrets/db_conn_string)
export GRAFANA_PASS=$(cat /deployment/secrets/grafana_password)
export GRAFANA_USER_USERNAME=$(cat /deployment/secrets/grafana_user_username)
export GRAFANA_USER_PASSWORD=$(cat /deployment/secrets/grafana_user_password)
export GRAFANA_USER_EMAIL=$(cat /deployment/secrets/grafana_user_email)
REGISTRY="ghcr.io"

echo "--Copying secrets to the correct location--"
cp /deployment/secrets/logging.env .env

echo "--Logging in to github package repo--"
echo $GH_PASS | docker login $REGISTRY -u $GH_USER --password-stdin

echo "--Pulling the images--"
docker compose pull

echo "--Executing the pre-setup for logging--"
docker compose up setup

echo "--Starting the container--"
docker compose up -d

echo "--Logging out of github package repo--"
docker logout $REGISTRY

cd configuration_files
./grafana_user_setup.sh

exit 0
