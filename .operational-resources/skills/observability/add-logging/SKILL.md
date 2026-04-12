# Skill: Add Logging (application code)

## TL;DR (VI)

- Dùng **SLF4J** (`LoggerFactory.getLogger(Class)`): **parameterized** `log.info("x={}", x)` — không nối chuỗi + không `System.out`.
- **Level:** `ERROR`/`WARN`/`INFO`/`DEBUG` có chủ đích; `INFO` = mốc nghiệp vụ; `DEBUG` chi tiết (chủ yếu dev/staging hoặc timebox prod).
- **Không** log password, token đầy đủ, thẻ, đủ PII để định danh; **MDC** cho correlation khi đã có filter (`implement-request-tracing`); cấu hình appenders/level theo **`configure-logging`**.

## Goal

Add **consistent, safe** application logging so operators can triage incidents without noise or data leakage.

## Preconditions

- Log stack agreed (typically **SLF4J + Logback** on Spring Boot).
- **Global logging config** (pattern, JSON, rotation) owned by **`skills/devops/configure-logging/README.md`**.

## Steps

1. **Obtain a logger**
   - `private static final Logger log = LoggerFactory.getLogger(TheClass.class);` (or instance logger in rare cases).
   - Use **class** as category so levels can be tuned per package in Logback.

2. **Prefer parameterized messages**
   - `log.warn("Order {} failed status={}", orderId, status);` — avoids string concat when level disabled and reduces accidental eager `toString()` on large objects.
   - For exceptions: `log.error("Failed to capture payment orderId={}", orderId, ex);` (last arg `Throwable`).

3. **Choose levels deliberately**

   | Level | Typical use |
   |-------|-------------|
   | `ERROR` | Failure needs action; may include exception |
   | `WARN` | Degraded / unexpected but handled (retry succeeded, fallback) |
   | `INFO` | Business milestones (order placed, job finished), audit-lite |
   | `DEBUG` | Diagnostic detail; off in prod by default |
   | `TRACE` | Very verbose; almost never in prod |

4. **What to log at boundaries**
   - **Service use case:** start/end of important operations, **ids** (orderId, userId as stable id only), outcome.
   - **Integration:** partner name, correlation id, HTTP status / error code — not full response bodies with PII.
   - **Avoid** logging inside tight loops at `INFO`; aggregate or sample if needed.

5. **MDC (Mapped Diagnostic Context)**
   - Do **not** set MDC in random utils unless the team owns cleanup; prefer a **filter/interceptor** (`skills/observability/implement-request-tracing/SKILL.md`).
   - If you must set locally: `MDC.put("key", value)` in `try` and **`MDC.remove`** or **`MDC.clear`** in `finally` (especially on thread pools).

6. **Security and privacy**
   - Never log credentials, OAuth codes, refresh tokens, API keys, CVV, full account numbers.
   - Avoid `log.info("user={}", user)` if `toString()` includes email/phone — log **opaque ids** and minimal state.
   - Redact or omit query strings that may contain tokens.

7. **Exceptions**
   - Log once at a **boundary** (e.g. global handler) with stack trace; inner layers can log **without** stack at `WARN` if adding context — avoid triple logging the same failure.

8. **“Structured” in plain Logback**
   - Consistent **key=value** fragments in messages help grep: `action=confirmPayment orderId=… durationMs=…`.
   - Full JSON log lines are primarily a **`configure-logging`** concern.

9. **Performance**
   - Guard expensive debug: `if (log.isDebugEnabled()) { ... }` only when building the message is costly.

10. **Verify**
   - Run with **dev** and **prod** profiles; confirm no `DEBUG` flood in prod unless intended.
   - One traced request shows **correlation id** in log lines when tracing is enabled.

## Output

- Logger usage in touched classes; optional MDC usage aligned with tracing skill.
   - No change to `logback-spring.xml` unless co-owned with DevOps (`configure-logging`).

## References

- `skills/devops/configure-logging/README.md`
- `skills/observability/implement-request-tracing/SKILL.md`
- `skills/observability/analyze-application-logs/SKILL.md`
- `skills/backend/create-service-layer/README.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
