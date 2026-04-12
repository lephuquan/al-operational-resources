# Skill: Integrate Message Queue

## TL;DR (VI)

- **Producer / consumer** với **schema message** có **`type` + `version`**; đính **correlation / trace id** để debug xuyên suốt.
- **Publish sau khi DB commit** (transactional outbox hoặc `TransactionalEventListener`) — tránh “commit fail nhưng message đã gửi”.
- Consumer **idempotent**; **ack** đúng semantics (manual ack sau xử lý thành công); **DLQ** cho poison message; quan sát **lag** và **error rate**.

## Goal

Integrate a **durable asynchronous** messaging path (RabbitMQ, Kafka, AWS SQS, etc.) with clear contracts, safe failure handling, and alignment with **`docs/architecture/08-transactions-and-consistency.md`**.

## Preconditions

- Broker choice and naming conventions documented in **`docs/architecture/07-integrations.md`** (message broker subsection).
- Network access and credentials via **env** — **`skills/devops/configure-environment/README.md`**.

## Steps

1. **Name and bound the use case**
   - Define **exchange/topic/queue** names (or SQS queue URLs) and whether the flow is **commands**, **events**, or **notifications**.
   - Document **ordering** expectations (partition key for Kafka, single consumer for strict order, etc.).

2. **Message contract**
   - Use a **versioned** envelope: e.g. `schemaVersion`, `eventType`/`commandType`, `payload`, `occurredAt`, **`correlationId`** (and optional `causationId`).
   - Prefer **JSON** with explicit schema or codegen; avoid dumping arbitrary maps without a type discriminator.
   - Plan **backward-compatible** evolution (additive fields, new types) — document in `07-integrations.md` or ADR.

3. **Producer implementation**
   - Serialize in infrastructure adapter; inject **metadata** (tenant, trace) from MDC or request context **before** send.
   - Handle **send failures**: retry with backoff where the broker API allows; surface persistent failure to ops (metric/alert).
   - **Do not publish inside the same DB transaction** as business writes without **outbox** — see step 7.

4. **Consumer implementation**
   - **Deserialize** → validate **version/type** → delegate to **application service** (port), not to controllers.
   - **Idempotency:** natural key or **`messageId`** / dedup table with **UNIQUE** constraint; duplicates must be **safe no-ops**.
   - **Acknowledgment:** use **manual ack** where supported; ack **after** successful processing and persistence; **nack/requeue** only for **transient** errors with limits.

5. **Retries and DLQ**
   - Configure **max retries** with backoff; route **poison** or **non-retryable** messages to **DLQ** (or dead-letter exchange / Kafka DLQ topic).
   - Operate DLQ with **replay** tooling and clear ownership — avoid infinite redelivery loops.

6. **Concurrency and prefetch**
   - Tune **prefetch** / **max.poll.interval** (Kafka) / **visibility timeout** (SQS) for expected processing time.
   - Cap **consumer concurrency** to protect DB and downstream APIs.

7. **Consistency with the database**
   - Follow **`08-transactions-and-consistency.md`**: after local commit, publish via **transactional outbox** table + publisher, or **`@TransactionalEventListener(phase = AFTER_COMMIT)`** for in-process events that trigger a sender.
   - Never hold a **long DB transaction** open while waiting on broker or network.

8. **Security**
   - TLS to broker in non-dev; **IAM** / SASL / username-password only from env.
   - Do not put **secrets** or full PII in message bodies unless encrypted and policy-approved (`rules/06-security.md`).

9. **Observability**
   - Metrics: publish/consume rate, failures, **consumer lag**, age of oldest message.
   - Logs: **correlation id**, message type, outcome — not full payload in prod (`skills/observability/add-metrics/SKILL.md`, `skills/observability/implement-request-tracing/SKILL.md`).

10. **Testing**
   - **Testcontainers** (RabbitMQ, Kafka, LocalStack for SQS) for integration tests.
   - Unit-test **handler** with mocked port; contract-test **serialization** round-trip.

11. **Documentation**
   - Update **`07-integrations.md`**: broker product, topic/queue list, retention, DLQ policy, and on-call notes.

## Output

- Producer and/or consumer configuration + adapters + message DTOs.
   - Infrastructure config (Spring Boot properties, beans).
   - Tests and integration doc updates.

## References

- `skills/backend/create-service-layer/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/integration/call-external-api/README.md` (side effects from consumers)
- `skills/integration/implement-webhook-handler/README.md` (webhook → publish)
- `skills/observability/implement-request-tracing/SKILL.md`
- `skills/observability/add-metrics/SKILL.md`
- `docs/architecture/07-integrations.md`, `docs/architecture/08-transactions-and-consistency.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
