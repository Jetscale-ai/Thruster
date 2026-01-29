# The Eudaimonia Framework: Thruster Protocol

This is the **Constitution** for contributors working on the `thruster` image.

## 1. Ethos (Character & Being)

1. **Identity (The Thruster Metaphor):** We build Thrusters—base propulsion
   stages (images) that power upstream vehicles. We are foundation, not
   application payload.
2. **Purpose (Frictionless Foundation):** Thruster’s purpose is to provide a
   hardened, pre-warmed OS + toolchain layer so downstream builds are fast and
   consistent.
3. **Aisthesis (Logs as UI):** CI logs are our interface. Keep build output
   clean, deterministic, and debuggable.

## 2. Logos (Reason & Internal Order)

4. **Release Contract (Reusable Workflow):**
   - We release via the shared reusable workflow:
     `jetscale-ai/booster/.github/workflows/release.yml`.
   - This repo must provide Dockerfile targets named **exactly**:
     - `thruster-dev` (heavy/dev)
     - `thruster` (runtime)
   - Tagging is strict: `:sha-<short>`, `:<version>`, and `:latest`.
5. **Security (Least Privilege & Secrets):**
   - GitHub Actions permissions must be explicit (`contents: write`,
     `packages: write`).
   - Docker Hub publishing is optional; missing creds must not break releases.
6. **Vigor (Performance):**
   - Keep the runtime stage minimal.
   - Prefer pinned versions for critical tools (e.g. `yq`) to keep builds
     deterministic.

## 3. Praxis (Action & Interaction)

7. **Change Discipline:**
   - Add tools only if they are foundational for many downstream repos.
   - Avoid adding “nice-to-have” utilities to runtime.
8. **Pre-commit Hygiene:**
   - Maintain a `.pre-commit-config.yaml` for markdown and repo hygiene.
   - Prefer small, mechanical commits that keep the release history clear.

