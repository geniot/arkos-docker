# armv8
FROM arm64v8/ubuntu:19.10

# Override sources.list
COPY sources.list /etc/apt/sources.list
COPY trusted.gpg /etc/apt/trusted.gpg
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y --no-install-recommends  \
    wget \
    build-essential \
    ca-certificates \
    binutils-aarch64-linux-gnu  \
    binutils-common  \
    binutils  \
    libsdl-image1.2  \
    libsdl1.2debian  \
    libsdl2-2.0-0  \
    libsdl2-dev  \
    libsdl2-mixer-2.0-0  \
    libsdl2-mixer-dev  \
    libsdl2-net-2.0-0  \
    libsdl2-ttf-2.0-0  \
    libsdl2-ttf-dev  \
    make  \
    pkg-config  \
    sudo  \
    tar  \
    zip

# Install Go 1.24.2
RUN wget https://go.dev/dl/go1.24.2.linux-arm64.tar.gz && \
    tar -C /usr/local -xzf go1.24.2.linux-arm64.tar.gz && \
    rm go1.24.2.linux-arm64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

ENTRYPOINT ["/bin/bash"]
