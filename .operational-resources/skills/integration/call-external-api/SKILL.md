# Skill: Call External API

## TL;DR (VI)

- Outbound HTTP qua **`WebClient`** (khuyến nghị) hoặc **`RestTemplate`** (legacy): **base URL + auth** từ **config/env**, không hardcode prod.
- **Timeout** connect/response; **giới hạn buffer** body; map **4xx/5xx/timeout** → exception domain (hoặc `Result`) rồi tới **`map-exceptions-to-http`** (thường **502/503**).
- **Retry** chỉ cho thao tác **idempotent**; **circuit breaker** cho dependency hay sập; **log/metric/trace** có **correlation id** — không log secret/PII.

## Goal

Implement maintainable outbound HTTP clients behind clear **ports/adapters**, with safe defaults for timeouts, errors, and resilience, aligned with `docs/architecture/07-integrations.md`.

## Preconditions

- Integration row (or ADR) describing direction, auth mechanism, and failure expectations — see **`docs/architecture/07-integrations.md`**.
- Service layer uses **constructor-injected** client abstraction when tests need mocks — see **`skills/backend/create-service-layer/README.md`**.
- Secrets available via **environment** / vault — see **`skills/devops/configure-environment/README.md`**.

## Steps

1. **Choose client stack**
   - Prefer **`WebClient`** (reactive stack, non-blocking friendly, Spring 6 mainstream).
   - Use **`RestTemplate`** only if the codebase is already standardized on it; plan migration if greenfield.

2. **Configuration bean**
   - Externalize **base URL**, path prefixes, and feature flags via **`@ConfigurationProperties`** (e.g. `app.partner-api.base-url`).
   - Never commit **API keys**; bind header names and env var **names** in docs only.

3. **Timeouts and resource limits**
   - Set **connection** and **read/response** timeouts (WebClient: `ReactorClientHttpConnector` / `HttpClient` options; RestTemplate: `RestTemplateBuilder` or `ClientHttpRequestFactory`).
   - Cap **in-memory body size** (WebClient `ExchangeStrategies` / `CodecProperties`) to avoid OOM on large responses.

4. **Auth**
   - Inject tokens via **Supplier** or refresh strategy if needed; rotate without code change.
   - Do not log **Authorization** headers or raw tokens.

5. **Adapter boundary**
   - Implement a dedicated `*Client` / `*Adapter` class (infrastructure) implementing a **port interface** consumed by application services.
   - Map provider JSON to **DTOs** internal to the adapter; surface **domain-friendly** results or exceptions to the service.

6. **Error mapping**
   - Translate HTTP status + body (when safe) into **typed failures**: e.g. provider 429 → retryable flag; 5xx/timeout → domain exception mapped to **502/503** per **`skills/error-handling/map-exceptions-to-http/README.md`**.
   - Avoid propagating raw `WebClientResponseException` message to end users.

7. **Resilience (optional, team-approved)**
   - **Retry:** only for **GET**/idempotent operations or requests with **idempotency keys**; backoff + jitter; cap attempts.
   - **Circuit breaker / bulkhead:** use **Resilience4j** (or platform equivalent) for flaky partners; configure via properties.

8. **Observability**
   - Log at **INFO** for outbound call start/failure summary with **correlation id** (`skills/observability/implement-request-tracing/SKILL.md`).
   - Add **metrics** (latency, error rate) if the team uses Micrometer (`skills/observability/add-metrics/README.md`).

9. **Testing**
   - **Unit:** mock the port interface in application tests.
   - **Contract / integration:** **WireMock** (or Testcontainers for real wire) for happy path, 4xx, 5xx, timeout — see `examples.md`.

10. **Documentation**
   - Update **`docs/architecture/07-integrations.md`** table for the partner: auth header **names**, idempotency, failure mapping summary.

## Output

- `*Client` / adapter implementation + configuration properties + Spring `@Bean` registration.
   - Tests (WireMock or equivalent).
   - Integration doc snippet under **`07-integrations.md`**.

## References

- `skills/backend/create-service-layer/README.md` (ports, no `RestTemplate` in domain)
- `skills/devops/configure-environment/README.md`
- `skills/error-handling/map-exceptions-to-http/README.md`
- `skills/observability/implement-request-tracing/SKILL.md`
- `skills/observability/add-metrics/README.md`
- `docs/architecture/06-backend-layers-and-dependencies.md`, `docs/architecture/07-integrations.md`, `docs/architecture/08-transactions-and-consistency.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
