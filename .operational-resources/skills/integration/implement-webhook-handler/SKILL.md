# Skill: Implement Webhook Handler

## TL;DR (VI)

- **POST** endpoint nhận callback provider: đọc **raw body** để **verify chữ ký** (HMAC / scheme của provider) **trước** khi parse JSON và chạy nghiệp vụ.
- **Idempotency** theo **event id** (hoặc id tương đương): trùng → trả **2xx** an toàn, không xử lý lại; lưu bằng **unique constraint** hoặc store có transactional semantics.
- **ACK nhanh** (2xx); tác vụ nặng → **queue / async**; log **event id** + outcome, **không** log secret hay full payload nhạy cảm.

## Goal

Build a **secure, idempotent** inbound HTTP handler for third-party webhooks that matches provider contracts, survives retries and duplicates, and fits the project’s API error envelope when rejecting bad requests.

## Preconditions

- Provider docs: **signature algorithm**, headers, **replay** rules, expected **HTTP status** on success/failure/retry.
- Row in **`docs/architecture/07-integrations.md`** for this inbound integration (direction, auth, idempotency).
- Webhook signing secret available via **env** — **`skills/devops/configure-environment/README.md`**.

## Steps

1. **Route and contract**
   - Dedicated **`POST`** path (e.g. `/api/v1/webhooks/{provider}`); version if multiple providers share a controller.
   - Document in **`docs/api/`** or integration spec: content-type, headers, sample payload (no secrets).

2. **Read raw payload for verification**
   - Keep **exact bytes** the provider signed (often UTF-8 JSON). Use **`ContentCachingRequestWrapper`**, a **filter**, or **`@RequestBody byte[]`/`String`** per Spring setup — avoid parsing JSON before verify unless provider signs parsed canonical form.
   - If using MVC filters, ensure the body is still readable once for the controller.

3. **Authenticate the sender**
   - Verify **HMAC** (constant-time compare of MAC bytes) or call provider **SDK verify** if official.
   - Optional: **timestamp** / **nonce** window to limit replay (when provider supports it).
   - On failure: return **401** or **400** per provider expectations so they **stop** or **retry** correctly — document the choice.

4. **Parse and validate**
   - Map payload to internal DTO; reject malformed body with **400** and stable **`error.code`** if the project returns JSON errors to the caller (some teams return **plain 400** for webhooks only — document exception).

5. **Idempotency**
   - Extract stable **event id** (or composite key: provider + id + type).
   - **Insert-first** or **UPSERT** in a table with **`UNIQUE(event_id)`** (or equivalent); duplicate → **short-circuit 2xx** without re-running side effects.
   - Align with **`docs/architecture/08-transactions-and-consistency.md`** if webhook processing participates in DB + messaging (outbox pattern when needed).

6. **Business processing**
   - Keep request thread **light**: validate state transitions, persist, enqueue work.
   - For **long** work, use **queue** / **@Async** with monitoring; never rely only on provider retry for correctness.

7. **HTTP response**
   - Return **2xx** quickly on accepted + persisted idempotency record (or after synchronous processing if SLA allows).
   - Use **5xx** only when the provider **should retry** (transient DB down); avoid **5xx** for bad signature (usually **4xx**).

8. **Spring Security**
   - Permit webhook path **without** session CSRF if the contract is **signature-based**; do **not** expose the same path without verification.
   - See **`skills/security/secure-api-endpoint/README.md`** for matcher scoping.

9. **Observability**
   - Log **provider**, **event id**, **outcome**, duration; propagate **correlation id** if present (`skills/observability/implement-request-tracing/README.md`).
   - Metrics: received, verified, rejected, duplicates, processing failures.

10. **Testing**
   - **Unit:** signature verify with known vector from provider docs.
   - **Integration:** **WireMock** or recorded fixtures for full POST; test **duplicate** delivery returns **2xx** without double side effect.

11. **Documentation**
   - Update **`07-integrations.md`**: signature header names, idempotency key field, retry behavior, and operational runbook link.

## Output

- Controller (or router) + verification helper + idempotency persistence.
   - Migration or table for processed events if new.
   - Tests + doc updates.

## References

- `skills/integration/call-external-api/README.md` (outbound reconcile / follow-up calls)
- `skills/backend/create-rest-api/README.md` (controller boundaries)
- `skills/backend/create-service-layer/README.md` (orchestration behind the handler)
- `skills/devops/configure-environment/README.md`
- `skills/error-handling/map-exceptions-to-http/README.md`
- `skills/error-handling/global-exception-handler/README.md`
- `skills/security/secure-api-endpoint/README.md`
- `skills/observability/implement-request-tracing/README.md`
- `docs/architecture/07-integrations.md`, `docs/architecture/08-transactions-and-consistency.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
