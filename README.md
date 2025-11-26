# Thruster

**Thruster** is the kinetic engine of the JetScale infrastructure. It provides the raw operating environment and mechanical toolchain required to generate propulsion.

It serves as the **Base Image** for all upstream vehicles, providing:

1.  **Thruster Dev (`thruster-dev`)**: A heavy-duty Ubuntu 24.04 environment pre-loaded with the "mechanic's kit" (`curl`, `git`, `jq`, `yq`, `make`).
2.  **Thruster Runtime (`thruster`)**: A streamlined Alpine 3.20 combustion chamber, hardened for production with only the essentials (`tini`, `ca-certificates`).

## Architecture

| Image | Base OS | Purpose | Key Tools |
| :--- | :--- | :--- | :--- |
| `ghcr.io/jetscale/thruster-dev` | Ubuntu 24.04 | CI, DevContainers | `git`, `curl`, `vim`, `jq`, `yq`, `make` |
| `ghcr.io/jetscale/thruster` | Alpine 3.20 | Production | `tini`, `ca-certificates`, `tzdata`, `bash` |

## Usage

This image is intended to be the `FROM` instruction for **[Booster](https://github.com/jetscale/booster)**.
