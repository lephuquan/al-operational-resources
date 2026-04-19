# Technology stack

## TL;DR (VI)

- Bảng **mẫu** cho stack Java/Spring; khi có dự án thật chỉ cần sửa phiên bản và cột “ghi chú”.
- Giữ **một nguồn** cho version chính (trùng `pom.xml` / Gradle).

**Last updated:** 2026-04-14

## Backend (default template — Spring Boot monolith or modular monolith)

| Area | Technology | Version (example) | Notes |
|------|------------|-------------------|--------|
| Language | Java | 17+ | Align with LTS policy |
| Framework | Spring Boot | 3.x | |
| Build | Maven or Gradle | (see build file) | Single build at repo root unless monorepo |
| Web | Spring MVC (`spring-boot-starter-web`) | | REST JSON |
| Validation | Jakarta Bean Validation | | `@Valid` on DTOs |
| Persistence | Spring Data JPA | | |
| DB | PostgreSQL (prod), H2 (optional local) | | |
| Migrations | Flyway or Liquibase | | Choose one |
| Security | Spring Security + JWT or OAuth2 Resource Server | | Match `docs/api/04-authentication.md` |
| Testing | JUnit 5, Mockito, AssertJ, Spring Boot Test | | |
| Mapping | MapStruct (optional) | | DTO ↔ entity |
| OpenAPI | springdoc-openapi (optional) | | Link spec in `docs/api/12-openapi-source-of-truth.md` |

## Optional infrastructure (tick what you use)

| Area | Technology | Notes |
|------|------------|--------|
| Cache | Redis | Sessions, rate limit, entity cache — be explicit |
| Messaging | RabbitMQ / Kafka / … | Document exchanges/topics in `07-integrations.md` |
| Search | Elasticsearch / OpenSearch | If applicable |
| Object storage | S3-compatible | For uploads |

## Frontend (if any — often outside this repo)

| Area | Technology | Notes |
|------|------------|--------|
| SPA / SSR | React / Next.js / … | Link repo or path if monorepo |

## Developer experience

| Tool | Purpose |
|------|---------|
| EditorConfig / formatter | Consistent style (Spotless, Google Java Format, …) |
| Static analysis | Checkstyle, Error Prone, SpotBugs — as adopted |
| CI | GitHub Actions / GitLab CI / … | Build + test + optional quality gate |

## ShelfLog demo (reference)

Concrete choices for the **ShelfLog** simulator (see `specs/feature-shelflog-items.md`):

| Area | Technology | Notes |
|------|------------|--------|
| Web | `spring-boot-starter-web` | REST JSON |
| Validation | `spring-boot-starter-validation` | DTO constraints |
| Persistence | Spring Data JPA | Hibernate |
| Dev DB | PostgreSQL 16 (Docker) | `../../simulator/docker-compose.postgres.yml`, host **5433** |
| Test DB | H2 | Profile `test` |
| Ops | Spring Boot Actuator | `GET /actuator/health` for demo |

Security (Spring Security + JWT) is **out of scope** for ShelfLog v1 — document as local/demo only.

## When to update this file

- Major version bumps (Java, Spring Boot).
- Adding a new cross-cutting library (caching, messaging).
- Changing DB engine or migration tool.
