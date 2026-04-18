# Skill: Implement Request Tracing

## TL;DR (VI)

- Chuẩn hoá **trace** theo **W3C Trace Context** (`traceparent` / `tracestate`) hoặc **B3** — **khớp gateway** và dịch vụ upstream.
- Spring Boot 3: **Micrometer Tracing** (Brave hoặc **OpenTelemetry**) + đưa **`traceId` / `spanId`** vào **MDC** để **Logback** in ra (`configure-logging`).
- **Outbound** (`WebClient`, messaging): **propagate** header/map header; **async** cần **propagate context** (không để MDC mất trên thread pool).

## Goal

Give every request a **stable correlation and distributed trace** across services so logs, metrics, and traces align for incident response.

## Preconditions

- Ingress or mesh policy: which headers are **trusted** and forwarded (`traceparent` vs `X-B3-*`).
- Log pattern updated to print MDC keys — **`skills/devops/configure-logging/README.md`**.

## Steps

1. **Pick propagation format**
   - Prefer **W3C** when the platform supports it end-to-end.
   - Use **B3** only when legacy services require it; document **single** primary format for new code.

2. **Add dependencies (Spring Boot 3 typical)**
   - **`micrometer-tracing-bridge-brave`** (Zipkin/Brave) and **`spring-boot-starter-actuator`** with tracing, **or** OpenTelemetry stack per team choice.
   - Enable **HTTP server** instrumentation (MVC/WebFlux auto-config) so incoming requests create or join a span.

3. **Incoming HTTP**
   - Rely on **`ServerRequestObservationContext`** / filters to **parse** incoming `traceparent` (or B3) and **continue** the trace.
   - If the gateway **generates** ids only in a custom header (e.g. `X-Request-Id`), map it into **MDC** and optionally **link** to the trace (same value in both if policy allows).

4. **MDC for logs**
   - Ensure **`traceId`** and **`spanId`** (names depend on bridge) are copied into **MDC** via Micrometer’s **`Observation`** / **`TracingObservationHandler`** or a thin **`Filter`**.
   - Update **`logback-spring.xml`** pattern with `%X{traceId}` / `%X{spanId}` (exact keys from your bridge doc).

5. **Outgoing HTTP (`WebClient`)**
   - Register **`ObservationRegistry`**-aware client or explicit **propagator** so child spans and **headers** are injected (`skills/integration/call-external-api/README.md`).
   - Verify with integration test: downstream receives **`traceparent`** (or B3) matching parent.

6. **Outgoing `RestTemplate` (legacy)**
   - Apply **`ClientHttpRequestInterceptor`** or tracing **`RestTemplateCustomizer`** from the same stack — plan migration to `WebClient` if possible.

7. **Async and executors**
   - **`@Async`** and custom **thread pools** must **propagate** `Observation` / `TracingContext` (e.g. **`ContextSnapshot`** / **`TaskDecorator`** from Micrometer 1.11+ patterns) so child work keeps the same trace.
   - Always **clear MDC** in `finally` on borrowed threads if you set extra keys manually (`skills/observability/add-logging/README.md`).

8. **Messaging**
   - For Kafka/Rabbit, map trace to **message headers** (W3C or B3 binary/text) in producer; **extract** on consumer and resume the trace (`skills/integration/integrate-message-queue/README.md`).

9. **Sampling and cost**
   - Configure **sampler** (always on dev; tail or percentage in prod if needed). Document impact on **metrics** cardinality.

10. **Security**
   - Treat incoming trace headers as **untrusted metadata** for logging only; do not use them for **authorization** decisions.
   - Do not log **full `tracestate`** if it may carry vendor-sensitive payloads (`rules/06-security.md`).

11. **Verify**
   - One request through **API → service → outbound** shows **one trace id** in logs and in the tracing UI (Jaeger/Tempo/Zipkin/X-Ray).
   - Load test: no **thread-local** / MDC leaks between requests on pooled threads.

12. **Operations**
   - Document where to **view traces** and sample **LogQL/KQL** by `traceId` (`skills/observability/analyze-application-logs/README.md`).

## Output

- Tracing dependencies + minimal configuration beans (if any).
   - Logback/MDC alignment; tests proving header propagation.
   - Short note in `docs/setup/` or runbook: header names and UI links.

## References

- `skills/devops/configure-logging/README.md`
- `skills/observability/add-logging/README.md`
- `skills/observability/add-metrics/README.md`
- `skills/observability/analyze-application-logs/README.md`
- `skills/integration/call-external-api/README.md`
- `skills/integration/integrate-message-queue/README.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
