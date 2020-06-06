#!/bin/bash

source opsani.env
echo $OPSANI_AUTH_TOKEN > optune_auth_token.secret
docker-compose up -d --build
