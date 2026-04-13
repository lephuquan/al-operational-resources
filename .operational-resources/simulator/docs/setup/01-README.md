# `docs/setup/` — Local run and configuration (personal)

## TL;DR (VI)

- Đây là **điểm vào** cho cài đặt, chạy local, biến môi trường (chỉ **tên**), và tổng quan triển khai.
- Nội dung chính **English**; file đánh số `01`…`05` để thứ tự đọc ổn định cho AI.
- **Tuyệt đối không** ghi secret thật — chỉ placeholder và tên biến.

This folder gives **operational context** for you and AI. It does not replace the team root `README`. Document variable **names**, profiles, and public URLs only.

**Security:** never store passwords, tokens, full connection strings, or private keys here.

---

## Reading order (numbered files)

1. `01-README.md` (this file)
2. `02-local-development.md` — prerequisites, clone, install, run, ports
3. `03-configuration.md` — env vars, profiles, config files
4. `04-deployment-overview.md` — environments, build/deploy summary
5. `05-troubleshooting-local.md` — recurring local issues

You may add optional files (`docker.md`, `database-local.md`, …); list them in the table below.

---

## Folder contents

| File | Purpose |
|------|---------|
| `01-README.md` | Entry point, rollout steps, relations to other docs |
| `02-local-development.md` | Toolchain, clone, dependencies, run commands, health checks |
| `03-configuration.md` | Env var names, Spring/`NODE_ENV`, secret storage hints |
| `04-deployment-overview.md` | Dev/stage/prod, CI/CD artifact, team doc links |
| `05-troubleshooting-local.md` | Machine-specific fixes (dev only) |

---

## How to roll out `setup/` in most projects

Use when starting a new project or syncing personal docs.

### Step 1 — Baseline (one-time)

1. Copy this folder or keep the numbered files; placeholders and HTML comments are fine at first.
2. Keep at least **`02-local-development.md`**, **`03-configuration.md`**, **`05-troubleshooting-local.md`**.

### Step 2 — Fill by stack

| Project type | Fill first |
|--------------|------------|
| Backend (Spring, Node, …) | `02-local-development.md`, `03-configuration.md` |
| Frontend (React, Vue, …) | Dev server URL; `VITE_*` / `NEXT_PUBLIC_*` names only |
| Monorepo | Run order in `02` or a dedicated `workspaces.md` |
| Docker / Compose | Section in `02` or `docker.md` |
| DB / migrations | Commands and schema names in `02`; **never** secret connection strings |

### Step 3 — Link from higher-level docs

- Add one line in **`docs/project-overview.md`** or **`docs/README.md`** pointing to `docs/setup/01-README.md` for first-time setup.
- Update **`MAP.md`** if you add or rename files.

### Step 4 — Maintain

- When ports, profiles, or default commands change, update `setup/` in the same MR or immediately after.
- Append recurring issues to `05-troubleshooting-local.md`.

---

## Relation to other folders

| Folder | Difference from `setup/` |
|--------|---------------------------|
| `docs/architecture/` | System shape and layers; not shell commands |
| `docs/knowledge-base/troubleshooting-manual.md` | Broader prod/business issues; `05` is **dev machine** only |
| `notes/quick-reference/` | Short notes; link to `docs/setup/` instead of duplicating |
| Team root `README` | Official for the team; `setup/` is **personal + AI-friendly** |

---

**Last updated:** 2026-04-08
