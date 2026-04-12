# Skill: Health Check Endpoint (Spring Boot Actuator)

## TL;DR (VI)

- Bật **`spring-boot-starter-actuator`**, expose **`health`** (và **`info`** nếu cần) qua **`management.endpoints.web`**; prod: **`show-details: never`** hoặc **`when_authorized`**.
- K8s / orchestrator: bật **`management.endpoint.health.probes.enabled`** → dùng **`/actuator/health/liveness`** và **`/actuator/health/readiness`**; **Spring Security** phải **permit** các path probe (không để 401 làm restart loop).
- **`HealthIndicator`** tùy chỉnh cho dependency quan trọng; **không** trả về secret, stack trace, hoặc PII trong body health **public**.

## Goal

Expose **reliable** liveness and readiness signals for load balancers and Kubernetes (or Docker healthcheck), with optional dependency checks, without leaking sensitive operational detail.

## Preconditions

- **Spring Boot** service (2.3+ for built-in probe endpoints; **3.x** assumed in examples).
- Decision who may call **`/actuator/*`** (public probes vs authenticated admin).

## Steps

1. **Add dependency**
   - Include **`spring-boot-starter-actuator`** (often alongside `spring-boot-starter-web` or WebFlux).

2. **Expose endpoints safely**
   - Set **`management.endpoints.web.exposure.include`** to the minimum needed (e.g. `health`, optionally `info`).
   - Set **`management.endpoint.health.show-details`** to **`never`** for anonymous/public health in prod, or **`when_authorized`** if operators authenticate.
   - Avoid exposing **`env`**, **`beans`**, or other sensitive endpoints on the same management port in production.

3. **Kubernetes-style probes (recommended when on K8s)**
   - Enable **`management.endpoint.health.probes.enabled: true`** so Boot registers **`/actuator/health/liveness`** (UP if JVM up) and **`/actuator/health/readiness`** (aggregates contributors: DB, disk, custom indicators, etc.).
   - Point **liveness** at **liveness** and **readiness** at **readiness** — do not use the same path for both unless team standard says otherwise.

4. **Spring Security**
   - If the app uses **Spring Security**, permit probe URLs for anonymous access (or use a dedicated management port with network policy). Typical matchers: `/actuator/health`, `/actuator/health/**` for probe paths only — tighten if you expose more under `/actuator/`.
   - Verify with **`curl`** without credentials returns **200** and status **UP** (or expected DOWN semantics) for probe paths.

5. **Dependency checks**
   - Rely on **auto-configured** contributors when possible (e.g. **DataSource**, **Redis** if starters present).
   - Add **`HealthIndicator`** beans for critical externals (feature flags, mandatory partner API) — keep checks **fast** and **timeout-bounded** so readiness does not hang the whole app.
   - Use **`HealthContributorRegistry`** / **`ReactiveHealthIndicator`** patterns per stack (MVC vs WebFlux) as per Spring docs.

6. **Custom indicator behavior**
   - Return **`Health.up().build()`** / **`Health.down().withDetail("code", "…").build()`** with **stable, non-secret** detail keys.
   - Do not put connection strings, tokens, or full exception messages in details visible to unauthenticated callers.

7. **Docker (optional)**
   - If using **`HEALTHCHECK`** in Dockerfile, prefer the same paths as K8s or a single **`/actuator/health`** only when liveness/readiness are not split — align with **`skills/devops/dockerize-service/README.md`**.

8. **Verify**
   - Hit endpoints locally per profile; simulate DB down and confirm **readiness** fails while **liveness** may still pass (expected pattern).
   - Add or extend an **integration test** that asserts actuator health is reachable with security config (if applicable).

## Output

- Actuator dependency and **`application-*.yml`** (or `.properties`) management/health settings.
- Optional **`SecurityFilterChain`** (or equivalent) adjustments for probe paths.
- Optional **`HealthIndicator`** implementations.
- **`docs/setup/`** or runbook note: probe paths, ports, and auth expectations.

## References

- `skills/devops/dockerize-service/README.md` (container healthcheck)
- `skills/devops/configure-environment/README.md` (profiles)
- `skills/observability/add-metrics/README.md` (Micrometer / Actuator metrics, if enabled)
- `skills/security/secure-api-endpoint/SKILL.md` (security patterns)
- `rules/06-security.md`
- Spring Boot reference: [Actuator — Health](https://docs.spring.io/spring-boot/reference/actuator/endpoints.html#actuator.endpoints.health)

**Last updated:** 2026-04-11
