# Skill: Add Metrics (Micrometer)

## TL;DR (VI)

- Dùng **Micrometer** qua **`MeterRegistry`**: **Counter**, **Timer**, **Gauge** (và **DistributionSummary** khi cần phân vị) — tên + **tag** ít **cardinality**.
- Spring Boot: **Actuator** expose **`/actuator/prometheus`** (hoặc registry khác) khi team bật; HTTP server metrics thường **auto** nếu đã có dependency.
- **Không** dùng `userId`, `email`, `orderId` làm tag hàng loạt — gây nổ time series; gom theo **loại** (`status`, `partner`, `operation`).

## Goal

Expose **actionable** application and integration metrics for dashboards and alerts while keeping **cardinality** under control and aligning with the team’s scraping stack (Prometheus, Datadog, etc.).

## Preconditions

- Observability backend chosen (Prometheus pull, agent push, cloud vendor).
- Agreement on **metric naming** prefix (`app_`, `mycompany_`, …) and allowed **tag keys**.

## Steps

1. **Enable infrastructure**
   - Add **`spring-boot-starter-actuator`** + **`micrometer-registry-prometheus`** (or the registry matching prod).
   - Expose **`metrics`** (and **`prometheus`** if used) via **`management.endpoints.web.exposure.include`** — align with **`skills/devops/health-check-endpoint/README.md`** so `/actuator` security stays tight.

2. **Use `MeterRegistry` in code**
   - Inject **`MeterRegistry`** in services/adapters (constructor injection).
   - Prefer **named** meters with stable base names: e.g. `app.orders.confirmed`, `app.payment.webhook.processed`.

3. **Counters**
   - **`Counter`** for monotonically increasing events: successes, failures, messages consumed.
   - Example tags: `result=success|failure`, `provider=stripe` (small enum set), not per-user.

4. **Timers**
   - **`Timer`** (or **`@Timed`** where appropriate) for latency of outbound calls, DB-heavy operations, or domain steps.
   - Records count + total time + often percentiles when using **histogram** / **SLA buckets** (enable via config for Prometheus).

5. **Gauges**
   - **`Gauge`** for point-in-time values: queue depth, cache size, connection pool usage — register once, callback reads current value.

6. **Cardinality rules**
   - **Never** tag with unbounded values (raw IDs, free-text error messages, URLs).
   - Prefer **`error_type`** or mapped **`error_code`** from a small catalog.

7. **HTTP and framework metrics**
   - Rely on **auto-configured** MVC/WebFlux metrics when possible; add **custom** timers only where auto metrics miss business context.

8. **Alerts and SLOs (team process)**
   - Document which metrics back **error rate**, **latency p95/p99**, **saturation** (CPU, pool, queue lag) — out of code, in runbook or dashboard repo.

9. **Testing**
   - Use **`SimpleMeterRegistry`** in unit tests to assert a counter incremented or timer recorded.
   - Smoke-test **`/actuator/prometheus`** in integration test if exposed.

10. **Documentation**
   - List new metrics and tags in **`docs/setup/`** or observability README so on-call knows what to graph.

## Output

- `MeterRegistry` usage in relevant components; Actuator/Prometheus config as agreed.
   - Tests asserting key meters; short doc of names/tags.

## References

- `skills/observability/add-logging/README.md`
- `skills/observability/implement-request-tracing/README.md`
- `skills/devops/health-check-endpoint/README.md`
- `skills/devops/configure-environment/README.md`
- `rules/06-security.md` (do not leak secrets in metric labels)

**Last updated:** 2026-04-11
