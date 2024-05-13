#!/bin/sh

# Chemins vers les Dockerfiles
DOCKERFILE_ALPINE_PATH="alpine/Dockerfile"
DOCKERFILE_FRR_PATH="frr/Dockerfile"

# Construire les images Docker
docker build -t mon-alpine -f "$DOCKERFILE_ALPINE_PATH" alpine/
docker build -t mon-frr -f "$DOCKERFILE_FRR_PATH" frr/

# Lancer les conteneurs Docker
docker run -d --name mon-conteneur-alpine mon-alpine
docker run -d --name mon-conteneur-frr mon-frr