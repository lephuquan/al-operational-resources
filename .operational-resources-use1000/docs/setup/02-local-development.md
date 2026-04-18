# Local development

## TL;DR (VI)

- Mô tả **từ clone đến chạy được** trên máy dev: công cụ, lệnh, port/URL kiểm tra.
- **ShelfLog demo:** cần Docker + Postgres (compose) để chạy app profile **dev**; test có thể chỉ cần Maven + H2 — xem § ShelfLog bên dưới.
- Thêm mục app (API / web / worker) nếu monorepo.

**Last updated:** 2026-04-14

## Purpose

Document how to go from **clone** to **running app(s)** on a developer machine: toolchain, install commands, run commands, and quick verification URLs/ports.

---

## Prerequisites

| Tool | Suggested version | Notes |
|------|---------------------|--------|
| JDK | 17+ | Or Node 20 LTS, Python 3.11, … |
| Maven / Gradle | | Omit column if unused |
| Docker + Compose | | **Required for ShelfLog app dev** (Postgres); optional if you only run `./mvnw test` with H2 |
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
| API / server | `./mvnw spring-boot:run -Dspring-boot.run.profiles=dev` (ShelfLog — after dependencies & config exist) | `http://localhost:8080` |
| Frontend (if any) | | |
| Worker / consumer (if any) | | |

**Profile / mode:** `dev` for ShelfLog against Postgres; see `03-configuration.md`.

### ShelfLog demo — Postgres via Compose

From the **repository root**:

```text
docker compose -f .operational-resources/simulator/docker-compose.postgres.yml up -d
```

Then run the Spring Boot app with profile **`dev`** so JDBC uses `localhost:5433`, database `shelflog`, user `shelves` (demo credentials — see compose file; not for production).

### ShelfLog demo — tests

```text
./mvnw test
```

Use Spring profile **`test`** and **H2** so tests do not require Docker (once `application-test.yml` or equivalent is added during implementation).

---

## Quick checks after startup

- [ ] Health (ShelfLog demo): `GET http://localhost:8080/actuator/health`
- [ ] List endpoint (after implementation): `GET http://localhost:8080/api/v1/shelf-items?page=0&size=20`
- [ ] Swagger / OpenAPI (if enabled): `<!-- URL -->`

---

## Docker / Compose (if used)

ShelfLog: PostgreSQL must be up before the **dev** profile app — see **ShelfLog demo** above. Stop with:

```text
docker compose -f .operational-resources/simulator/docker-compose.postgres.yml down
```

Other projects: `docker compose up -d` as appropriate; list which services must be up before the app (DB, Redis, …).

---

## Machine-specific notes (optional)

<!-- e.g. VPN required to reach a shared dev DB — describe behavior only, no credentials. -->
