# Backend layers and dependency rules

## TL;DR (VI)

- Quy định **ai được gọi ai**: controller → application → domain → infrastructure.
- Tránh dependency ngược (domain không phụ thuộc HTTP/JPA cụ thể nếu team tách sạch).

**Last updated:** 2026-04-08

## 1. Layers (conceptual)

| Layer | May depend on | Must not depend on |
|-------|----------------|----------------------|
| `api` (controllers) | `application`, DTOs, validation annotations | Direct DB access, infrastructure clients (except via application) |
| `application` | `domain`, `infrastructure` ports/adapters as interfaces | HTTP-specific types in pure domain (if strict DDD) |
| `domain` | Other domain types, standard library | Framework-specific types (optional strictness) |
| `infrastructure` | `domain`, frameworks (JPA, HTTP client) | `api` layer |

**Pragmatic note:** In small Spring projects, JPA entities sometimes live next to repositories. That is acceptable if you document it here and stay consistent.

## 2. DTO vs domain vs persistence

| Type | Role |
|------|------|
| Request/response DTOs (`api` dto package) | HTTP shape; validation at boundary |
| Domain model | Business invariants and behavior |
| JPA entities | Persistence mapping; keep mapping logic out of controllers |

Use MapStruct or manual mapping at the application boundary when DTOs differ from entities.

## 3. Module boundaries (optional)

For larger codebases, split by **bounded context** packages (`order`, `billing`, `identity`) each with internal layering. Document allowed cross-module calls (only via application services or domain events).

## 4. Errors

- Throw **domain or application exceptions** with stable `error.code` values aligned with `docs/api/05-error-handling.md`.
- Map to HTTP in a single global handler (`skills/error-handling/global-exception-handler`).

## 5. Testing strategy (hint)

- **Unit:** domain and application with mocks.
- **Slice:** `@WebMvcTest` for controllers.
- **Integration:** `@SpringBootTest` + Testcontainers for DB-heavy paths.

## Related

- System view: `02-system-overview.md`
- Package layout: `04-folder-structure.md`
