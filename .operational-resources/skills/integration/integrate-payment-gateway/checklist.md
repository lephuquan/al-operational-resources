# Checklist: Integrate Payment Gateway

Dùng trước khi merge luồng thanh toán, webhook, hoặc đổi provider.

## Money & state

- [ ] Số tiền / currency lấy từ **server** (order, pricing), không chỉ từ client.
- [ ] Trạng thái nội bộ có **state machine** rõ; event webhook **out-of-order** không làm hỏng dữ liệu.
- [ ] **Provider id** và idempotency key có **unique** khi cần.

## Idempotency

- [ ] Create/capture/refund gửi **idempotency key** đúng spec; retry cùng nghiệp vụ dùng lại key.

## Webhook

- [ ] Verify **chữ ký**; **idempotent** theo event id; **2xx** nhanh; không xử lý nặng không kiểm soát trong thread request (queue nếu cần).

## Trust model

- [ ] Không coi redirect/query client là bằng chứng duy nhất; đã có **webhook và/hoặc** reconcile API.

## PCI & privacy

- [ ] Không log / không lưu trữ trái phép **card data** thô; dùng flow provider (token, hosted page).
- [ ] Log không chứa secret provider hay full payload nhạy cảm.

## Errors

- [ ] Decline và lỗi provider map tới **`error.code`** + HTTP đã thống nhất (`05-error-handling.md`).

## Ops

- [ ] Sandbox vs live **tách key**; có runbook mismatch / stuck payment.

## Test

- [ ] Sandbox scenario (success, decline, timeout); **replay webhook** không double-apply side effects.

**Last updated:** 2026-04-11
