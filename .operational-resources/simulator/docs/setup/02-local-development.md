# Local development

## TL;DR (VI)

- Mô tả **từ clone đến chạy được** trên máy dev: công cụ, lệnh, port/URL kiểm tra.
- Thêm mục app (API / web / worker) nếu monorepo.

**Last updated:** 2026-04-08

## Purpose

Document how to go from **clone** to **running app(s)** on a developer machine: toolchain, install commands, run commands, and quick verification URLs/ports.

---

## Prerequisites

| Tool | Suggested version | Notes |
|------|---------------------|--------|
| JDK | 17+ | Or Node 20 LTS, Python 3.11, … |
| Maven / Gradle | | Omit column if unused |
| Docker (optional) | | |
| IDE | IntelliJ / VS Code / … | |

---

## Clone and branch

```text
git clone <repo-url>
cd <project-folder>
git checkout <feature-or-develop-branch>
```

---

## Install dependencies

```text
<!-- Example: Java -->
./mvnw -q -DskipTests package
```

```text
<!-- Example: Node -->
npm ci
```

---

## Run (development)

| Component | Command | URL or port |
|-----------|---------|-------------|
| API / server | `<!-- e.g. ./mvnw spring-boot:run -Dspring-boot.run.profiles=local -->` | `http://localhost:8080` |
| Frontend (if any) | | |
| Worker / consumer (if any) | | |

**Profile / mode:** `<!-- e.g. spring.profiles.active=local -->`

---

## Quick checks after startup

- [ ] Health: `<!-- e.g. GET /actuator/health -->`
- [ ] Swagger / OpenAPI (if enabled): `<!-- URL -->`

---

## Docker / Compose (if used)

```text
<!-- e.g. docker compose up -d -->
```

List which services must be up before the app (DB, Redis, …).

---

## Machine-specific notes (optional)

<!-- e.g. VPN required to reach a shared dev DB — describe behavior only, no credentials. -->
