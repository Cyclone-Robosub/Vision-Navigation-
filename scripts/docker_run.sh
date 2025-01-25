#!/bin/bash

if [[ "$1" == "build" ]]; then
    echo "[INFO] Building Docker image..."
    docker build -t vision-navigation .
elif [[ "$1" == "run" ]]; then
    echo "[INFO] Running Docker container..."
    docker run --rm -it \
        --device=/dev/video0:/dev/video0 \
        --privileged \
        vision-navigation
elif [[ "$1" == "shell" ]]; then
    echo "[INFO] Opening a shell in the Docker container..."
    docker run --rm -it \
        --device=/dev/video0:/dev/video0 \
        --privileged \
        vision-navigation bash
else
    echo "[ERROR] Usage: ./scripts/docker_run.sh build|run|shell"
fi
