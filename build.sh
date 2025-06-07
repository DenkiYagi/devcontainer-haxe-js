#!/usr/bin/env bash

# Load configuration from .env file
if [ -f .env ]; then
  export $(cat .env | grep -v '#' | xargs)
fi

docker build \
  --build-arg HAXE_VERSION=$HAXE_VERSION \
  --build-arg NEKO_VERSION=$NEKO_VERSION \
  --build-arg NODE_VERSION=$NODE_VERSION \
  --build-arg YARN_VERSION=$YARN_VERSION \
  --build-arg PNPM_VERSION=$PNPM_VERSION \
  -t denkiyagi/devcontainer-haxe-js:latest \
  -t denkiyagi/devcontainer-haxe-js:$VERSION \
  .
