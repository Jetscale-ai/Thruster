# Thruster Repository Operations

<!-- markdownlint-disable MD013 -->

**Status:** Operational Details
**Scope:** `Jetscale-ai/Thruster` only
**Authority:** [Repository Constitution](../AGENTS.md)

---

## 1. Verification Oracles

### Docker Validation

```bash
docker build --target thruster-dev -t thruster-test:thruster-dev .
docker build --target thruster -t thruster-test:thruster .
```

### Workflow Validation

```bash
gh run list --repo Jetscale-ai/Thruster --limit 10
gh run view <run-id> --repo Jetscale-ai/Thruster
gh run view <run-id> --repo Jetscale-ai/Thruster --log-failed
```

---

## 2. Release Flow

- Entry workflow: `.github/workflows/release.yml`
- Release execution: `Jetscale-ai/Booster/.github/workflows/release.yml@main`
- Downstream handoff: dispatch `Jetscale-ai/Booster` workflow
  `booster-release.yml` after a successful `main` release

---

## 3. Namespace CI Expectations

- Preferred runner profile: `namespace-profile-jetscale-build`
- Opt JavaScript actions into Node 24:
  `FORCE_JAVASCRIPT_ACTIONS_TO_NODE24=true`
- Favor CLI-based workflow dispatch (`gh api`) over Node-based helper actions when
  that reduces deprecation or runtime noise

If CI annotations mention deprecated Node runtimes:

1. prefer newer major versions of first-party actions
2. prefer Namespace-native actions for checkout/buildx
3. replace third-party Node actions with direct CLI invocations when behavior is
   simple and auditable

---

## 4. Safety Boundaries

- Do not add tooling to `thruster` runtime unless it is foundational for
  multiple downstream repos.
- Keep `thruster-dev` and `thruster` target names stable; Booster depends on
  them.
- Treat downstream dispatch failures as release regressions and monitor them
  after every push to `main`.
