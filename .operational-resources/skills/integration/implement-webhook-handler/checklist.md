# Checklist: Implement Webhook Handler

Dùng trước khi merge endpoint webhook mới hoặc đổi luồng verify.

## Security

- [ ] Chữ ký (hoặc cơ chế auth provider) được verify trên **đúng payload** provider ký (thường raw body).
- [ ] So sánh chữ ký **constant-time** (MAC bytes) hoặc dùng SDK chính thức.
- [ ] Secret chỉ từ **env/vault**; không log secret hay full payload chứa PII/PCI.

## Idempotency

- [ ] Có **event id** (hoặc khóa ổn định) và **unique** ở DB/store để chống duplicate delivery.
- [ ] Giao hàng lại cùng event → **2xx** và **không** lặp side effect (thanh toán, email, …).

## Semantics & HTTP

- [ ] **4xx** vs **5xx** khớp kỳ vọng provider (retry hay không); đã ghi trong doc/runbook.
- [ ] Thời gian xử lý trong request **chấp nhận được** hoặc đã tách **async/queue**.

## Architecture

- [ ] Controller mỏng; logic nghiệp vụ qua service/port (`create-service-layer`).
- [ ] Transaction + messaging (nếu có) tuân `08-transactions-and-consistency.md` (outbox khi cần).

## Spring Security

- [ ] Path webhook **permit** đúng chỗ; không mở rộng thừa; CSRF policy đã chốt cho POST không session.

## Observability

- [ ] Log có **event id** + provider + kết quả; có correlation/trace nếu team dùng.

## Test

- [ ] Test verify chữ ký (vector cố định).
- [ ] Test **gửi trùng** event → idempotent 2xx.

## Docs

- [ ] `07-integrations.md` (hoặc spec API) mô tả inbound: header, idempotency, mã HTTP.

**Last updated:** 2026-04-11
