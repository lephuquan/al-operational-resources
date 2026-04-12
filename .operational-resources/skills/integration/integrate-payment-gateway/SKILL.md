# Skill: Integrate Payment Gateway

## TL;DR (VI)

- **Source of truth** trạng thái thanh toán = **provider** (webhook + đối soát API khi cần), **không** tin “client báo success” hay redirect URL một mình.
- **Idempotency** cho mọi thao tác **ghi** (create intent, capture, refund): **`Idempotency-Key`** hoặc tương đương; lưu **provider object id** (`payment_intent_id`, …) **unique**.
- **PCI**: không xử lý / log **full PAN/CVV**; dùng **tokenization / hosted fields / Elements** của provider. Webhook: **`implement-webhook-handler`** (chữ ký + idempotency event).

## Goal

Integrate a third-party payment provider behind a clear **application port**, with safe money handling, durable state, webhook ingestion, and operational clarity documented in **`docs/architecture/07-integrations.md`**.

## Preconditions

- Provider chosen; **sandbox** and **live** keys separated in **env** (`skills/devops/configure-environment/README.md`).
- Payment row in **`07-integrations.md`** filled (auth, idempotency, webhooks, failure modes).
- Public error mapping for payment failures agreed (`skills/error-handling/map-exceptions-to-http/README.md`).

## Steps

1. **Port and boundaries**
   - Define `PaymentGatewayPort` (or similar) in **application** layer: create session/intent, cancel, refund, **query status** — not raw HTTP in domain.
   - Implement **adapter** in infrastructure using **`WebClient`** per **`call-external-api`**: timeouts, retries only on **safe/idempotent** reads.

2. **Persist local payment records**
   - Store **internal payment id**, **provider id**, **amount** (minor units), **currency**, **status**, **customer reference**, timestamps.
   - **Unique** constraints on provider id and on internal idempotency business keys to prevent double charges.

3. **Create / confirm flows**
   - **Amount** always from **server-side** trusted data (order total), never only from client JSON.
   - Return **client_secret** or redirect URL to client per provider model; document what the mobile/web client may see.

4. **Idempotency for mutations**
   - Send provider-required **idempotency key** on create/capture/refund; reuse the same key on retries of the **same** business operation.
   - Map duplicate idempotent responses to the same local state (no second charge).

5. **Webhooks**
   - Implement **`POST`** handler per **`skills/integration/implement-webhook-handler/README.md`**: verify signature, **idempotent** by provider **event id**, **fast 2xx**.
   - Handle **out-of-order** events: e.g. `processing` after `succeeded` must not regress state incorrectly — define **state machine** and ignore or reconcile.

6. **Reconciliation**
   - Periodic or on-demand **GET** status from provider for stuck payments; align DB with provider outcome.
   - On mismatch, alert and follow runbook (never silently drop money discrepancies).

7. **Error and decline mapping**
   - Map provider **declines**, **insufficient funds**, **fraud blocks** to stable **`error.code`** and appropriate HTTP for **your** API (often **402** / **409** / **422** per team table in **`05-error-handling.md`**).
   - Transient provider errors → **502/503** with safe message; log technical detail server-side.

8. **PCI and data minimization**
   - Do not log card numbers, CVV, full magnetic data; store only tokens/ids the provider returns if needed.
   - If using redirect/hosted page, document **return URL** validation to prevent open redirects.

9. **Security**
   - Rotate API keys; restrict webhook IP only if provider documents it (often signature is enough).
   - Follow **`rules/06-security.md`** and run **`skills/security/security-review/SKILL.md`** for payment features.

10. **Observability**
   - Metrics: success/decline rates, latency, webhook processing failures (`skills/observability/add-metrics/README.md`); correlation id on outbound/inbound (`skills/observability/implement-request-tracing/README.md`).

11. **Optional async**
   - Heavy post-payment work → **`skills/integration/integrate-message-queue/README.md`** after webhook ACK + durable state update.

12. **Testing**
   - **Sandbox** cards/scenarios; **replay webhooks** (idempotency); contract tests for adapter serialization.
   - Never run live charges in CI.

13. **Documentation**
   - Update **`07-integrations.md`** with lifecycle, webhook types, idempotency header names, and support links.

## Output

- Port + adapter + persistence (entities/migrations) for payments.
   - Webhook controller/handler wiring.
   - Tests (sandbox + WireMock where applicable) + doc updates.

## References

- `skills/integration/call-external-api/README.md`
- `skills/integration/implement-webhook-handler/README.md`
- `skills/backend/create-service-layer/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/error-handling/map-exceptions-to-http/README.md`
- `skills/integration/integrate-message-queue/README.md`
- `skills/observability/add-metrics/README.md`
- `skills/observability/implement-request-tracing/README.md`
- `skills/security/security-review/SKILL.md`
- `docs/architecture/07-integrations.md`, `docs/architecture/08-transactions-and-consistency.md`
- `docs/api/05-error-handling.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
