# Repository and folder structure

## TL;DR (VI)

- Mô tả **cây thư mục** để AI đặt class đúng chỗ: `api` → `application` → `domain` → `infrastructure`.
- Có mục **monorepo** tùy chọn; điền tên package thật khi có code.

**Last updated:** 2026-04-14

## 1. Single backend repo (typical Maven layout)

```text
project-root/
├── src/main/java/<base.package>/
├── src/main/resources/          # application.yml, static, Flyway/Liquibase scripts
├── src/test/java/
├── pom.xml or build.gradle.kts
└── .operational-resources/      # personal AI context (may be git-excluded locally)
```

## 2. Java package layout (recommended baseline)

Use a single **base package** (example: `com.company.product`). Below it:

```text
<base.package>/
├── Application.java              # Spring Boot entry
├── config/                       # @Configuration, SecurityFilterChain, beans
├── common/                       # Shared exceptions, util, base types (keep small)
├── api/                          # @RestController, request/response DTOs for HTTP
├── application/                  # @Service application layer; use-case orchestration
├── domain/                       # Entities, value objects, domain services, domain events
└── infrastructure/             # JPA repositories, adapters (email, payment, queue clients)
```

**Rules of thumb**

- **Controllers** stay thin: map HTTP ↔ DTO, call application services.
- **Application** owns transaction boundaries for use cases (`@Transactional` here unless policy says otherwise — see `08-transactions-and-consistency.md`).
- **Domain** avoids Spring web types and JPA annotations if you use pure domain models + separate JPA models (optional advanced split). For simpler projects, JPA entities may live under `domain` or `infrastructure.persistence` — pick one convention and document it here.

## 3. Tests mirror production packages

```text
src/test/java/<base.package>/
├── api/           # @WebMvcTest, slice tests
├── application/   # unit tests with mocks
├── integration/   # @SpringBootTest + Testcontainers (optional)
└── domain/        # pure unit tests
```

## 4. Resources and migrations

| Path | Content |
|------|---------|
| `src/main/resources/application.yml` | Profiles, non-secret defaults |
| `src/main/resources/db/migration` (Flyway) | Versioned SQL |
| `src/main/resources/static` | Optional static assets |

## 5. Monorepo (optional)

```text
apps/
├── api/                 # Spring Boot service
└── web/                 # Frontend (if present)
packages/
└── shared-contracts/    # OpenAPI, shared DTOs (if used)
```

Document which app owns the database and API gateway routing.

## 6. ShelfLog demo — suggested package layout

Base package follows the existing app entry: **`com.programming_with_al.al_operational_resources`**. Suggested module slice for **ShelfItem** (adjust names to match your layer naming):

```text
com.programming_with_al.al_operational_resources/
├── AlOperationalResourcesApplication.java
├── shelflog/
│   ├── api/                 # REST controller + request/response DTOs
│   ├── application/         # Service / use cases (pagination, filters)
│   └── persistence/         # JPA entity + Spring Data repository
```

Tests mirror under `src/test/java/.../shelflog/` (unit + `@SpringBootTest` IT).

## Related

- Layer dependency rules: `06-backend-layers-and-dependencies.md`
- Database tables: `05-database-design.md`
