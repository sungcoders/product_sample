#!/bin/bash

# =============================
# Config default
# =============================
DEFAULT_IMAGE="cpp-env"
DEFAULT_CONTAINER="cpp-env-container"
WORKSPACE_HOST="$(pwd)/.."
WORKSPACE_CONT="/workspace"
FLAG_USED=false

VERSION="1.0.0"

# =============================
# functions helper
# =============================
show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

OPTIONS:
  -v        Version script
  -h        Help
  -r        Run container (image: $DEFAULT_IMAGE, container: $DEFAULT_CONTAINER)
  -b        Build image from Dockerfile (image: $DEFAULT_IMAGE)
  -c        Delete dangling images
  -i        Show information Docker (images, containers)

Examples:
  $0 -r     # run container: cpp-env-container, image: cpp-env
  $0 -b     # build image name: cpp-env
  $0 -c     # delete dangling images
EOF
}

#run container
run_container() {
    CONTAINER_NAME=$DEFAULT_CONTAINER
    IMAGE_NAME=$DEFAULT_IMAGE
    echo "👉 Đang chạy container: $CONTAINER_NAME (image: $IMAGE_NAME)"
    docker run -it --rm \
        --name "$CONTAINER_NAME" \
        -v "$WORKSPACE_HOST":"$WORKSPACE_CONT" \
        -w "$WORKSPACE_CONT" \
        "$IMAGE_NAME" \
        /bin/bash
}

#build image
build_image() {
    IMAGE_NAME=$DEFAULT_IMAGE
    echo "👉 Build image với tên: $IMAGE_NAME"
    # Ensure Dockerfile path is resolved relative to this script's directory so the command
    # works whether the script is executed from repo root or from inside devenv/
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    DOCKERFILE_PATH="$SCRIPT_DIR/Dockerfile"
    BUILD_CONTEXT="$SCRIPT_DIR/.."
    # If there is a .dockerignore in the devenv directory and you want to keep it there,
    # we can temporarily copy it to the repo root so Docker uses those ignore rules while
    # building with the repo root as context.
    TMP_IGNORED=false
    ROOT_DOCKERIGNORE="$BUILD_CONTEXT/.dockerignore"
    LOCAL_DOCKERIGNORE="$SCRIPT_DIR/.dockerignore"
    BACKUP_PATH=""
    if [ -f "$LOCAL_DOCKERIGNORE" ]; then
        TMP_IGNORED=true
        if [ -f "$ROOT_DOCKERIGNORE" ]; then
            BACKUP_PATH="$ROOT_DOCKERIGNORE.bak.$(date +%s)"
            mv "$ROOT_DOCKERIGNORE" "$BACKUP_PATH"
        fi
        # Copy the devenv .dockerignore to root so it's used for this build
        cp "$LOCAL_DOCKERIGNORE" "$ROOT_DOCKERIGNORE"
    fi

    # Run the build with the repo root as context
    docker build -t "$IMAGE_NAME" -f "$DOCKERFILE_PATH" "$BUILD_CONTEXT"

    # Restore original root .dockerignore (if any) and remove the temp copy
    if [ "$TMP_IGNORED" = true ]; then
        rm -f "$ROOT_DOCKERIGNORE"
        if [ -n "$BACKUP_PATH" ] && [ -f "$BACKUP_PATH" ]; then
            mv "$BACKUP_PATH" "$ROOT_DOCKERIGNORE"
        fi
    fi
}

#clean dangling images
clean_dangling() {
    echo "👉 Xóa dangling images..."
    docker image prune -f
}

#show docker info
show_info() {
    echo "👉 Docker Images:"
    docker images
    echo
    echo "👉 Docker Containers:"
    docker ps -a
}

# =============================
# Parse options
# =============================
while getopts "vhrbci" opt; do
    FLAG_USED=true
    case $opt in
        v)
            echo "run_docker.sh version $VERSION"
            exit 0
            ;;
        h)
            show_help
            exit 0
            ;;
        r)
            run_container
            exit 0
            ;;
        b)
            build_image
            exit 0
            ;;
        c)
            clean_dangling
            exit 0
            ;;
        i)
            show_info
            exit 0
            ;;
        *)
            show_help
            exit 0
            ;;
    esac
done

# default action: build and run if no flags are provided
if [ "$FLAG_USED" = false ]; then
    build_image
    run_container
fi
