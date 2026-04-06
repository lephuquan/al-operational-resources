# Skill: Implement Webhook Handler

## Goal

Endpoint nhận webhook: xác thực nguồn, idempotency, fast ACK, xử lý async nếu cần.

## Steps

1. `POST` endpoint riêng; raw body để verify signature (nếu provider yêu cầu).
2. Verify HMAC/signature trước khi xử lý business.
3. Idempotency key: lưu event id đã xử lý (tránh duplicate).
4. Trả 200 nhanh; tác vụ nặng đưa queue nếu SLA yêu cầu.
5. Log event id + status + latency (không log secret).
