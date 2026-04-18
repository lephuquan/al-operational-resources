# Checklist: Integrate Message Queue

Dùng trước khi merge producer/consumer/topic/queue mới.

## Contract

- [ ] Message có **type** và **schemaVersion** (hoặc tương đương); tài liệu evolution.
- [ ] **correlationId** (và trace nếu có) được truyền xuyên suốt.

## Producer

- [ ] Không publish “cùng lúc” ghi DB mà không có **outbox** / **after_commit** — đã kiểm tra với `08-transactions-and-consistency.md`.
- [ ] Lỗi gửi có **metric** / log để vận hành phát hiện.

## Consumer

- [ ] Xử lý **idempotent** (khóa dedup / unique business key).
- [ ] **Ack** sau khi xử lý + persist thành công (hoặc semantics đã ghi rõ).
- [ ] Retry giới hạn; **DLQ** cho poison / lỗi không hồi phục.

## Ops

- [ ] **Prefetch / concurrency / timeout** broker phù hợp thời gian xử lý (không requeue vô hạn).
- [ ] Có kế hoạch **replay DLQ** hoặc owner rõ.

## Security

- [ ] Kết nối broker bảo mật (TLS/SASL/IAM theo môi trường).
- [ ] Payload không chứa secret; PII tuân `rules/06-security.md`.

## Observability

- [ ] Lag / error rate / consumer health có metric hoặc dashboard tối thiểu.

## Test

- [ ] Testcontainers (hoặc sandbox) cho luồng publish-consume tối thiểu.
- [ ] Unit test handler + duplicate delivery.

## Docs

- [ ] `07-integrations.md` cập nhật tên queue/topic, retention, DLQ.

**Last updated:** 2026-04-11
