# ==========================================
# JetScale Thruster
# The Kinetic Engine (Base OS + Tools)
# ==========================================

# ------------------------------------------
# TARGET: thruster-dev
# ------------------------------------------
FROM ubuntu:24.04 AS thruster-dev

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# Install Core Mechanics
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
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install yq (Pinned Version)
ARG YQ_VERSION=v4.44.3
ARG YQ_BINARY=yq_linux_amd64
RUN curl -fsSL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}" -o /usr/bin/yq && \
    chmod +x /usr/bin/yq

# ------------------------------------------
# TARGET: thruster
# ------------------------------------------
FROM alpine:3.21 AS thruster

RUN apk update && apk upgrade && \
    apk add --no-cache \
    ca-certificates \
    tini \
    tzdata \
    bash \
    curl

ENTRYPOINT ["/sbin/tini", "--"]
