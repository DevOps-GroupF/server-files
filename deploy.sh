#! /bin/bash
GH_USER="DevOps-GroupF"
GH_PASS=$(cat /deployment/secrets/github)
REGISTRY="ghcr.io"

echo $GH_PASS | docker login $REGISTRY -u $GH_USER --password-stdin 
docker compose pull
docker compose up -d

exit 0