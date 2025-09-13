FROM ubuntu:22.04

# Update package and install tool build
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gdb \
    git \
    && rm -rf /var/lib/apt/lists/*

# Tạo user 'sunglv' với home directory
RUN useradd -ms /bin/bash sunglv \
    && echo "sunglv ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER sunglv

# workspace inside container
WORKDIR /workspace

# Copy source code to container docker
COPY . .
