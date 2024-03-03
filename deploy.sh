#! /bin/bash
GH_USER=$(cat /deployment/secrets/github_pck_user)
GH_PASS=$(cat /deployment/secrets/github_pck_token)
REGISTRY="ghcr.io"

echo $GH_PASS | docker login $REGISTRY -u $GH_USER --password-stdin 
docker compose pull
docker compose up -d
docker logout

exit 0
