# Deployment overview (environments and pipeline)

## TL;DR (VI)

- Tóm tắt **môi trường** và **build/deploy**; không thay runbook chính thức của tổ chức.
- Liên kết wiki/CI nếu có; không ghi secret.

**Last updated:** 2026-04-08

## Purpose

Summarize **environments**, how **artifacts** are built and deployed, and **links to team docs** — enough context for on-call or MR review. **Not** a replacement for official runbooks.

---

## Environments

| Environment | Purpose | URL / note (if allowed) | Notes |
|-------------|---------|-------------------------|--------|
| Development | | | Often shared or forked from staging |
| Staging | UAT / demo | | |
| Production | Live users | | |

---

## Build and artifact

| Step | Tool / location | Output |
|------|-----------------|--------|
| CI build | `<!-- GitHub Actions / Jenkins / Azure DevOps -->` | `<!-- JAR, Docker image, … -->` |
| Versioning | `<!-- semver tag, build number -->` | |

---

## Deployment (short)

```text
<!-- e.g. merge to main → pipeline → deploy to k8s namespace X -->
```

Approval and rollback details: link team wiki or internal doc (one URL line if possible).

---

## Relation to local dev

- **`02-local-development.md`** — developer machine.
- **This file** — path of code after merge; useful for feature flags, env-specific config, or staging-before-prod migrations.
