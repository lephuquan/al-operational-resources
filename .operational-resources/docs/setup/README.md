# `docs/setup/` - Local run and configuration (personal docs)

## TL;DR (VI)

- Day la noi tap trung cach cai dat/chay local/cau hinh/deploy overview.
- Noi dung chinh viet English de AI doc on dinh.
- Tuyet doi khong ghi secret that, chi ghi ten bien va placeholder.

This folder is the entry point for installation, local run steps, configuration, and deployment context. It supports you and AI with operational context, and does not replace the team-level root `README` (if present).

**Security rule:** document variable names, profiles, and public URLs only. Never store passwords, tokens, full connection strings, or private keys.

---

## Folder contents

| File | Purpose |
|------|----------|
| **`README.md`** | This file - purpose and rollout approach for `setup/` docs. |
| **`local-development.md`** | Prerequisites, clone, dependency install, run commands, local URL/port, local profile. |
| **`configuration.md`** | Environment variable names, config files, Spring profile/`NODE_ENV`, secret storage guidance. |
| **`deployment-overview.md`** | Environments (dev/stage/prod), pipeline/artifact summary, links to team docs. |
| **`troubleshooting-local.md`** | Common local machine issues and fixes, updated over time. |

You can add project-specific files (for example `docker.md`, `database-local.md`) when needed; keep them listed in the table above.

---

## How to roll out `setup/` in most projects

Use this when starting a new project or syncing personal docs.

### Step 1 - Create baseline files (one-time)

1. Copy the templates from current `*.md` files (placeholders `<!-- ... -->` are fine initially).
2. Keep at least: **`local-development.md`**, **`configuration.md`**, and **`troubleshooting-local.md`**.

### Step 2 - Fill by stack (select relevant rows)

| Project type | Fill first |
|------------|---------------------|
| Backend (Spring, Node, ...) | `local-development.md` (build/run/test commands), `configuration.md` (profiles/env). |
| Frontend (React, Vue, ...) | Dev server URL, `VITE_*` / `NEXT_PUBLIC_*` vars (names and meaning only). |
| Monorepo | Add run order section or a dedicated `workspaces.md` if complex. |
| Docker / Compose | Section in `local-development.md` or separate `docker.md`. |
| DB / migration | Local migration commands, DB/schema names; **never** paste secret connection strings. |

### Step 3 - Link from higher-level docs

- Add one line in **`docs/project-overview.md`** or `docs/README.md` pointing to `docs/setup/` for first-time run context.
- Keep **`MAP.md`** in sync when file names change.

### Step 4 - Maintain continuously

- When port/profile/standard run commands change, update `setup/` in the same MR (or immediately after).
- Capture recurring local issues in `troubleshooting-local.md` instead of chat-only notes.

---

## Relation to other folders

| Folder | Difference from `setup/` |
|---------|---------------------------|
| **`docs/architecture/`** | Backend architecture (`01-README.md` …); not focused on machine run commands. |
| **`docs/knowledge-base/troubleshooting-manual.md`** | Broader business/production issues; `setup/troubleshooting-local.md` focuses on **developer machines**. |
| **`notes/quick-reference/`** | Short personal notes; prefer linking to `docs/setup/` over duplicating long content. |
| **Team root `README`** | Official source for the whole team; `setup/` is a **personal + AI-friendly** layer. |

---

**Last updated:** 2026-04-08
