# ==========================================
# Jetscale Thruster
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
    ripgrep \
    && rm -rf /var/lib/apt/lists/*

# eMudhra intermediate compromise (2026-10-20): fail the build if the system
# bundle still trusts the root that chains to the compromised intermediates.
# Fixed in Ubuntu ca-certificates 20260816ubuntu0.24.04.1 / Alpine 20261020-r0.
# https://emudhra.we-have-a-problem.com/
# (grep matches the first base64 line of emSign ECC Root CA - G3,
#  SHA-256 86:A1:EC:BA:...:6B:BE:6B; the bundle carries no labels)
RUN ! grep -qF "MIICTjCCAdOgAwIBAgIKPPYHqWhwDtqLhDAKBggqhkjOPQQDAzBrMQswCQYDVQQG" /etc/ssl/certs/ca-certificates.crt

# Install yq (Pinned Version)
ARG YQ_VERSION=v4.44.3
ARG YQ_BINARY=yq_linux_amd64
RUN curl -fsSL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${YQ_BINARY}" -o /usr/bin/yq && \
    chmod +x /usr/bin/yq

# -----------------------------------------
# TARGET: thruster
# -----------------------------------------
FROM alpine:3.22 AS thruster

RUN apk upgrade --no-cache && \
    apk add --no-cache --upgrade \
    ca-certificates \
    tini \
    tzdata \
    bash \
    curl

# eMudhra intermediate compromise (2026-10-20): fail the build if the system
# bundle still trusts the root that chains to the compromised intermediates.
# Fixed in Ubuntu ca-certificates 20260816ubuntu0.24.04.1 / Alpine 20261020-r0.
# https://emudhra.we-have-a-problem.com/
# (grep matches the first base64 line of emSign ECC Root CA - G3,
#  SHA-256 86:A1:EC:BA:...:6B:BE:6B; the bundle carries no labels)
RUN ! grep -qF "MIICTjCCAdOgAwIBAgIKPPYHqWhwDtqLhDAKBggqhkjOPQQDAzBrMQswCQYDVQQG" /etc/ssl/certs/ca-certificates.crt

ENTRYPOINT ["/sbin/tini", "--"]
