# armv8
FROM arm64v8/ubuntu:19.10

# Override sources.list
COPY sources.list /etc/apt/sources.list
COPY trusted.gpg /etc/apt/trusted.gpg
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y --no-install-recommends  \
    wget \
    curl \
    build-essential \
    ca-certificates \
    binutils-aarch64-linux-gnu  \
    binutils-common  \
    binutils  \
    libsdl-image1.2  \
    libsdl-image1.2-dev \
    libsdl1.2debian  \
    libsdl2-2.0-0  \
    libsdl2-image-dev \
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

RUN apt-get update

# Download and build SDL2
RUN wget https://github.com/trimui/toolchain_sdk_smartpro/releases/download/20231018/SDL2-2.26.1.GE8300.tgz && \
    tar -xzf SDL2-2.26.1.GE8300.tgz -C /tmp && \
    cd /tmp/SDL2-2.26.1 && \
    ./configure --host=aarch64-linux-gnu \
                --prefix=/usr \
                --disable-video-wayland \
                --disable-pulseaudio \
                --with-sysroot=${SYSROOT} && \
    make && \
    make install && \
    rm -rf /tmp/SDL2-2.26.1 SDL2-2.26.1.GE8300.tgz


# Install Go 1.24.2
RUN wget https://go.dev/dl/go1.24.2.linux-arm64.tar.gz && \
    tar -C /usr/local -xzf go1.24.2.linux-arm64.tar.gz && \
    rm go1.24.2.linux-arm64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"


# Get Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Check cargo is visible
RUN cargo --help

WORKDIR /usr/local/
ADD sample sample
RUN cd sample && cargo fetch

ENTRYPOINT ["/bin/bash"]
