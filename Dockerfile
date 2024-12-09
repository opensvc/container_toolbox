FROM debian:latest

RUN sed -i 's/Components: main/Components: main contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources \
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    arping \
    atop \
    bash \
    bridge-utils \
    ca-certificates \
    curl \
    dnsutils \
    ethtool \
    file \
    git \
    host \
    htop \
    iftop \
    iperf \
    iproute2 \
    iputils-ping \
    jid \
    jq \
    less \
    lsof \
    ltrace \
    mtr-tiny \
    netcat-traditional \
    netcat-openbsd \
    net-tools \
    nicstat \
    ngrep \
    nmap \
    openssl \
    openssh-client \
    procps \
    rclone \
    restic \
    rsync \
    socat \
    strace \
    telnet \
    tcpdump \
    tini \
    traceroute \
    unzip \
    vim-tiny \
    wget \
    && apt -y --purge remove \
    git-man \
    python3 \
    sgml-base \
    && apt -y autoremove \
    && apt-get clean all && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/tini"]
