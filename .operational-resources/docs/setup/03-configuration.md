# Configuration and environment variables

## TL;DR (VI)

- Chỉ ghi **tên** biến và ý nghĩa; giá trị thật để env / vault / file gitignore.
- Không commit secret; ví dụ dùng `<placeholder>` hoặc `***`.

**Last updated:** 2026-04-08

## Purpose

List **names** of variables, config files, and profiles so local setup and AI prompts stay aligned. **Do not** put real secrets in this file.

---

## Safety rules

- Document **names** and meaning; store real values in OS env, a secret manager, or a **gitignored** file (e.g. `.env.local`).
- Never commit: passwords, API tokens, private keys, full connection strings.
- Use placeholders for examples: `<your-api-key>` or `***`.

---

## Profiles / runtime modes

| Profile / name | When used | Notes |
|----------------|-----------|--------|
| `local` | Personal dev | e.g. `application-local.yml` |
| `dev` / `staging` / `prod` | Team environments | <!-- link wiki or filename --> |

---

## Environment variables (reference table)

| Variable | Required | Description | Notes |
|----------|----------|-------------|--------|
| `SPRING_PROFILES_ACTIVE` | | Spring profile | e.g. `local` |
| `SERVER_PORT` | | HTTP port | Default 8080 if unset |
| <!-- add rows --> | | | |

---

## Config files in repo (no secrets)

| File | Role |
|------|------|
| `src/main/resources/application.yml` | Defaults |
| `application-local.yml` | Local overrides — often **gitignored** or provided as `*.example` |

---

## Where secrets live (dev)

<!-- e.g. Windows user env, 1Password, Doppler, Azure Key Vault — tool names only, no credentials. -->
