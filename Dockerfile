# ==========================================
# JetScale Thruster
# The Kinetic Engine (Base OS + Tools)
# ==========================================

# ------------------------------------------
# TARGET: thruster-dev
# The Heavy Lifter: Ubuntu 24.04 + Admin Tools
# ------------------------------------------
FROM ubuntu:24.04 AS thruster-dev

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# Install Core Mechanics
# - Upgrade OS to latest patches
# - Install Network/Build tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    curl \
    wget \
    git \
    make \
    jq \
    vim \
    nano \
    openssh-client \
    gnupg \
    ca-certificates \
    iputils-ping \
    dnsutils \
    tini \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Install yq (Portable YAML processor) - Essential for CI
RUN wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq

# ------------------------------------------
# TARGET: thruster
# The Combustion Chamber: Alpine 3.20 + Minima
# ------------------------------------------
FROM alpine:3.20 AS thruster

# Install Runtime Essentials
# - tini: Init process
# - ca-certificates: HTTPS support
# - tzdata: Correct logging timestamps
# - bash: For pragmatic entrypoint compatibility
# - curl: For Healthchecks
RUN apk update && apk upgrade && \
    apk add --no-cache \
    ca-certificates \
    tini \
    tzdata \
    bash \
    curl

ENTRYPOINT ["/sbin/tini", "--"]

