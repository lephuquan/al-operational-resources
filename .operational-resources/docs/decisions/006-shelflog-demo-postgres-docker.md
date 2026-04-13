# ADR-006: ShelfLog demo — PostgreSQL via Docker for dev, H2 for tests

**Date:** 2026-04-14  
**Status:** Accepted

## Context

The **ShelfLog** simulator needs a realistic persistence story for AI-assisted demos: developers run the app against a real SQL engine, while CI and local `./mvnw test` stay fast and Docker-free.

## Decision

- **Dev / manual runs:** Use **PostgreSQL 16** started with **Docker Compose** (`.operational-resources/simulator/docker-compose.postgres.yml`), host port **5433**.
- **Automated tests:** Use **H2** in-memory with Spring profile **`test`**.

## Alternatives considered

- **Testcontainers for all IT:** closer to prod, but heavier and optional for this demo scope.
- **H2 only:** simpler, but increases risk of dialect and SQL behavior drift vs PostgreSQL.

## Consequences

**Positive**

- Aligns demo with common Spring + Postgres deployments.
- Keeps the default test command lightweight.

**Negative**

- Developers must run Docker for app dev (not for unit/IT if H2 is configured).
- Two databases to document (`docs/setup/`, simulator mirror).

**Risks**

- JPA features that differ between H2 and Postgres — mitigate with conservative mappings and IT scenarios documented in the task file.

## Related

- Brief: `.operational-resources/simulator/DEMO-PROJECT-BRIEF.md` §2, §6  
- Feature spec: `docs/specs/feature-shelflog-items.md`
