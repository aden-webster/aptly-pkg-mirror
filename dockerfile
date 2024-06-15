FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install dependencies
RUN apt update && \
    apt install -y \
    gnupg \
    wget \
    lsb-release \
    apt-transport-https \
    ca-certificates && \
    wget -qO - https://www.aptly.info/pubkey.txt | apt-key add - && \
    DIST=$(lsb_release -cs) && \
    echo "deb http://repo.aptly.info/ squeeze main" > /etc/apt/sources.list.d/aptly.list && \
    apt update && \
    apt install -y aptly && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]