# System architecture overview

## TL;DR (VI)

- Bức tranh lớn: client → (gateway) → **Spring Boot** → DB/cache/queue.
- Phong cách: **layered** + có thể DDD/event-driven từng module; stateless app để scale ngang.

**Last updated:** 2026-04-14

## 1. High-level diagram (template)

```text
Clients (browser / mobile / internal tools)
        |
        v   HTTPS
[ API Gateway / LB ]  (optional)
        |
        v
Spring Boot application(s)
  - REST adapters
  - Application services
  - Domain + persistence
        |
        +-- SQL database (e.g. PostgreSQL)
        +-- Cache (e.g. Redis) — optional
        +-- Message broker (e.g. RabbitMQ / Kafka) — optional
        +-- External HTTP APIs (payment, notification, …)
```

Replace components with what your deployment actually uses.

## 2. Architectural style

| Aspect | Default stance (adjust per ADR) |
|--------|-----------------------------------|
| Primary style | **Layered** (presentation → application → domain → infrastructure) |
| Domain complexity | Introduce **DDD building blocks** (aggregates, domain services) only where payoff is clear |
| Async | **Event-driven** or outbox pattern for cross-module side effects (payment, notification) when needed |
| API surface | REST JSON; see `docs/api/` for contract rules |

## 3. Logical layers (conceptual)

Detailed dependency rules: `06-backend-layers-and-dependencies.md`.

| Layer | Responsibility |
|-------|----------------|
| Presentation | HTTP mapping, DTOs, input validation trigger |
| Application | Use cases, orchestration, transaction boundaries |
| Domain | Business rules, entities/value objects, domain events (if used) |
| Infrastructure | JPA, messaging adapters, HTTP clients, file storage |

## 4. Request flow (typical)

`Client → Controller → Application service → (Domain) → Repository/Adapter → DB or external system`

Avoid business rules in controllers; avoid leaking web types into domain when you maintain a strict boundary.

## 5. Non-functional requirements (template — set real targets)

| Area | Example target |
|------|----------------|
| Scalability | Stateless app instances behind LB |
| Performance | p95 latency budget for critical APIs (define with team) |
| Reliability | Retries + timeouts + circuit breaker for external HTTP (e.g. Resilience4j) |
| Observability | Structured logs, metrics, tracing IDs propagated (`docs/api/02-api-overview.md` headers) |
| Security | Defense in depth: transport TLS, authn/authz, input validation, least privilege DB users |

## 6. Integration points (summary)

Expand each row in `07-integrations.md`.

| Kind | Example |
|------|---------|
| Payments | PSP HTTP webhooks + REST API |
| Notifications | Email/SMS/push via provider or internal service |
| Identity | OIDC / internal user directory |

## 7. ShelfLog demo (simulator reference)

Narrow **reference application** documented in `specs/feature-shelflog-items.md`: a single Spring Boot service exposes **`/api/v1/shelf-items`** and persists to **PostgreSQL** in dev (Docker, host port **5433**) or **H2** in tests. No gateway, cache, or broker in v1.

```text
HTTP client
    |
    v
Spring Boot (ShelfLog module: controller -> service -> JPA)
    |
    +-- PostgreSQL (dev, Docker)
    +-- H2 (test profile)
```

See also: `../../simulator/DEMO-PROJECT-BRIEF.md`, `../decisions/006-shelflog-demo-postgres-docker.md`.

**Last updated (this section):** 2026-04-14

## Related

- Tech choices: `03-tech-stack.md`
- Package layout: `04-folder-structure.md`
