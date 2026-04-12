# Integrate Message Queue (index)

## TL;DR (VI)

- Playbook **broker** (RabbitMQ / Kafka / SQS / …): **envelope** có version, **producer sau commit**, **consumer idempotent**, **DLQ**, **observability**.
- Neo **`docs/architecture/07-integrations.md`** và **`08-transactions-and-consistency.md`** (outbox, không publish trong transaction dài).

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình contract, produce/consume, retry, consistency, test |
| `examples.md` | Envelope JSON, gợi ý listener Spring, outbox ý niệm |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Ghi broker và naming trong `docs/architecture/07-integrations.md`.
2. Chốt **semantics** (at-least-once + idempotent consumer thường gặp).
3. Làm theo `SKILL.md`; tham chiếu `examples.md`.
4. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/backend/create-service-layer/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/integration/call-external-api/README.md`
- `skills/integration/implement-webhook-handler/README.md`
- `skills/observability/implement-request-tracing/SKILL.md`
- `docs/architecture/07-integrations.md`, `docs/architecture/08-transactions-and-consistency.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
