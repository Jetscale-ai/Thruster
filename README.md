# Thruster

**Thruster** is the kinetic engine of the JetScale infrastructure. It provides the raw operating environment and mechanical toolchain required to generate propulsion.

It serves as the **Base Image** for all upstream vehicles (specifically **[Booster](https://github.com/jetscale/booster)**), providing:

1.  **Thruster Dev (`thruster-dev`)**: A heavy-duty Ubuntu 24.04 environment pre-loaded with the "mechanic's kit" (`curl`, `git`, `jq`, `yq`, `make`).
2.  **Thruster Runtime (`thruster`)**: A streamlined Alpine 3.20 combustion chamber, hardened for production with only the essentials (`tini`, `ca-certificates`).

## Architecture

| Image | Base OS | Purpose | Key Tools |
| :--- | :--- | :--- | :--- |
| `ghcr.io/jetscale-ai/thruster-dev` | Ubuntu 24.04 | CI, DevContainers | `git`, `curl`, `vim`, `jq`, `yq`, `make`, `tini` |
| `ghcr.io/jetscale-ai/thruster` | Alpine 3.20 | Production | `tini`, `ca-certificates`, `tzdata`, `bash`, `curl` |

## Usage

This image is intended to be the `FROM` instruction for downstream projects.

```dockerfile
# Example inheritance
FROM ghcr.io/jetscale-ai/thruster-dev:latest AS dev-base
# ... install languages ...
```

## Development

To build locally:

```bash
docker buildx build --target thruster-dev .
docker buildx build --target thruster .
```

## Release

This repo releases via the shared **Booster** reusable workflow:

- Wrapper workflow: `.github/workflows/release.yml`
- Reusable workflow: `jetscale-ai/booster/.github/workflows/release.yml`

Versioning is driven by `go-semantic-release` (commit history); images are
published to GHCR and optionally Docker Hub (if credentials exist).

## License

MIT
