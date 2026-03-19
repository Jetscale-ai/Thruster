# JetScale Thruster Constitution

<!-- markdownlint-disable MD013 -->

**Status:** Ratified
**Version:** 3.0.0
**Blueprint:** `library` (`.agents/codex/blueprints/library.md`)
**Stack:** `go-mod` (`.agents/codex/stacks/go-mod.md`)
**Authority:** [Supreme Constitution](https://github.com/Jetscale-ai/Governance/blob/main/AGENTS.md)

This document is the delegated constitution for `Jetscale-ai/Thruster`. It
governs a foundational image repository that publishes the base execution
environment for downstream build systems.

---

## 0. Situational Awareness (Required Context)

### 0.1 Universal Red Lines (Excerpt)

- Agents must never execute commits, pushes, or tags.
- Agents must never output, log, or persist secrets.
- Agents must never impersonate humans.

### 0.2 Default Failure Mode

If instructions conflict, evidence is ambiguous, or blast radius is unknown:

1. STOP.
2. AUDIT assumptions and repository state.
3. ASK the human before proceeding.

### 0.3 Eudaimonia is 12 Invariants

The Eudaimonia Framework is the full set of 12 universal invariants. Commit and
PR `audit_log:` blocks must cite only the invariants relevant to the change.

### 0.4 Tooling Preflight (Mandatory)

Before bootstrapping canonical law, verify:

```bash
require_cmd() { command -v "$1" >/dev/null 2>&1 || { echo "Missing required tool: $1" >&2; exit 1; }; }

require_cmd gh
gh auth status -h github.com >/dev/null 2>&1 || { echo "gh not authenticated for github.com" >&2; exit 1; }
require_cmd base64
require_cmd sed

# Repo toolchain
require_cmd docker
```

### 0.5 Load Canonical Law (How)

On each new session, load the ratified Governance artifacts from
`Jetscale-ai/Governance@main` before giving substantive guidance:

```bash
gh api repos/Jetscale-ai/Governance/contents/AGENTS.md --jq .content | base64 -d
gh api repos/Jetscale-ai/Governance/contents/.agents/codex/protocols/bootstrap.md --jq .content | base64 -d
gh api repos/Jetscale-ai/Governance/contents/.agents/codex/protocols/ratification.md --jq .content | base64 -d
gh api repos/Jetscale-ai/Governance/contents/.agents/codex/protocols/audit-trail.md --jq .content | base64 -d
gh api repos/Jetscale-ai/Governance/contents/.agents/codex/protocols/ci-monitoring.md --jq .content | base64 -d
gh api repos/Jetscale-ai/Governance/contents/.agents/codex/blueprints/library.md --jq .content | base64 -d
gh api repos/Jetscale-ai/Governance/contents/.agents/codex/stacks/go-mod.md --jq .content | base64 -d
```

### 0.6 Hard Stop on Missing Law

If canonical law cannot be retrieved, agents must not invent governance. Enter
Advisory Mode and request human intervention.

### 0.7 Load Local Operations (How)

Load repository-local operations before providing commands or verification
steps:

```bash
sed -n '1,200p' .agents/AGENTS.md
```

Or via GitHub API:

```bash
gh api repos/Jetscale-ai/Thruster/contents/.agents/AGENTS.md --jq .content | base64 -d
```

## 0.8 Codex Ratification

This constitution ratifies the following Governance artifacts on
`Jetscale-ai/Governance@main`:

| Artifact | Path |
| :--- | :--- |
| Supreme Constitution | `AGENTS.md` |
| Bootstrap Protocol | `.agents/codex/protocols/bootstrap.md` |
| Ratification Protocol | `.agents/codex/protocols/ratification.md` |
| Audit Trail Protocol | `.agents/codex/protocols/audit-trail.md` |
| CI Monitoring Protocol | `.agents/codex/protocols/ci-monitoring.md` |
| Library Blueprint | `.agents/codex/blueprints/library.md` |
| Go Modules Stack | `.agents/codex/stacks/go-mod.md` |

### On-Demand Codex Loading

| Trigger | Required Artifact |
| :--- | :--- |
| Commit and traceability questions | `.agents/codex/protocols/audit-trail.md` |
| CI failures after direct pushes | `.agents/codex/protocols/ci-monitoring.md` |
| Branch protection questions | `.agents/codex/protocols/branch-protection.md` |
| Commit format | `.agents/codex/skills/core/conventional-commit/SKILL.md` |

## 0.9 Repository Declaration

- **Owner:** Paul (Founding Engineer)
- **Risk Level:** Medium
- **Primary Artifact:** Base OS images for downstream build systems
- **Downstream Surface:** `thruster -> booster`
- **Namespace Profile:** `namespace-profile-jetscale-build`

---

## 1. Repository Purpose

Thruster provides the raw operating environment for downstream image builders.
It must remain deterministic, minimal, and stable.

Core mandates:

- Publish `thruster-dev` and `thruster` from a single Dockerfile.
- Keep the runtime image minimal and free of convenience tooling.
- Use Booster's shared release workflow rather than duplicating release logic.

## 2. Release Contract

- Wrapper workflow: `.github/workflows/release.yml`
- Reusable workflow: `Jetscale-ai/Booster/.github/workflows/release.yml@main`
- After a successful `main` release, dispatch Booster's top-level release
  workflow so downstream images rebuild against the newest Thruster base.

## 3. Architectural Invariants

- Critical tool versions in the image should be pinned when feasible.
- New runtime packages require justification tied to multiple downstream
  consumers.
- CI warnings should be treated as part of product quality for the platform.

## 4. Documentation Currency

README, roadmap, and workflow docs must reflect:

- Alpine 3.21 as the runtime base
- the canonical `Jetscale-ai/*` repository naming
- the live downstream release handoff to Booster
