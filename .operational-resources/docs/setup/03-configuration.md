# Configuration and environment variables

## TL;DR (VI)

- Chỉ ghi **tên** biến và ý nghĩa; giá trị thật để env / vault / file gitignore.
- **ShelfLog demo:** profile **`dev`** → Postgres `localhost:5433`; profile **`test`** → H2 in-memory (xem bảng JDBC bên dưới).
- Không commit secret; ví dụ dùng `<placeholder>` hoặc `***`.

**Last updated:** 2026-04-14

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
| `dev` | ShelfLog demo — app against Docker Postgres | Pair with `docker-compose.postgres.yml`; demo credentials only |
| `test` | ShelfLog demo — automated tests | H2 in-memory; no Docker required |
| `staging` / `prod` | Team environments | <!-- link wiki or filename --> |

---

## Environment variables (reference table)

| Variable | Required | Description | Notes |
|----------|----------|-------------|--------|
| `SPRING_PROFILES_ACTIVE` | | Spring profile | e.g. `dev`, `test`, `local` |
| `SERVER_PORT` | | HTTP port | Default 8080 if unset |
| `SPRING_DATASOURCE_URL` | | JDBC URL | Override file-based config if needed |
| `SPRING_DATASOURCE_USERNAME` | | DB user | Use env locally — do not commit values |
| `SPRING_DATASOURCE_PASSWORD` | | DB password | Use env / secret store |

### ShelfLog demo — JDBC (illustrative defaults)

| Profile | `spring.datasource.url` (example) |
|---------|-------------------------------------|
| `dev` | `jdbc:postgresql://localhost:5433/shelflog` |
| `test` | `jdbc:h2:mem:shelflogtest;DB_CLOSE_DELAY=-1` |

User `shelves` / password `shelves` match `.operational-resources/simulator/docker-compose.postgres.yml` for **demo only**.

---

## Config files in repo (no secrets)

| File | Role |
|------|------|
| `src/main/resources/application.yml` | Shared defaults, Actuator exposure |
| `src/main/resources/application-dev.yml` | ShelfLog **dev** profile — Postgres (SIM-DEMO-1) |
| `src/main/resources/application-test.yml` | ShelfLog **test** profile — H2 |
| `src/test/resources/application.properties` | Forces `spring.profiles.active=test` for `./mvnw test` |
| `application-local.yml` | Optional local overrides — often **gitignored** |

---

## Where secrets live (dev)

<!-- e.g. Windows user env, 1Password, Doppler, Azure Key Vault — tool names only, no credentials. -->
