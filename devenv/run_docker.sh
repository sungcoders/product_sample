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
    docker build -t "$IMAGE_NAME" .
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
