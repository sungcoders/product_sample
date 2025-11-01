FROM ubuntu:22.04

# Update package and install tool build
RUN apt-get update && apt-get install -y \
    make \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# add user 'sunglv' with home directory
RUN useradd -ms /bin/bash sunglv \
    && echo "sunglv ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER sunglv

# workspace inside container
WORKDIR /workspace

