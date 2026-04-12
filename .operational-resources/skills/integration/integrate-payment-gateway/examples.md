# Examples: Integrate Payment Gateway

Mô tả **trừu tượng**; thay tên trạng thái theo provider (Stripe, Adyen, …). Không dán secret hay số thẻ.

## Luồng tổng quan

```text
Client → Your API: create payment (orderId)
Your API → Provider API: create PaymentIntent (idempotency key = internal payment id)
Your API → Client: client_secret / redirect URL
Provider → Webhook: payment.succeeded | payment.failed
Your handler: verify sig → idempotent update → 2xx
(Optional) Cron: reconcile PENDING older than N minutes
```

## Trạng thái nội bộ (ví dụ)

| Internal status | Ý nghĩa |
|-----------------|--------|
| `CREATED` | Đã tạo bản ghi, chưa có provider id |
| `REQUIRES_ACTION` | Chờ 3DS / redirect |
| `PROCESSING` | Đã gửi provider, chờ kết quả |
| `SUCCEEDED` | Tiền đã capture theo provider |
| `FAILED` | Từ chối / lỗi xác định |
| `CANCELED` | Huỷ trước capture |

Quy tắc: chỉ chuyển trạng thái **hợp lệ** (ví dụ không từ `SUCCEEDED` về `FAILED` trừ khi chargeback được mô hình hóa riêng).

## Idempotency-Key (REST)

```http
POST /v1/payment_intents
Idempotency-Key: pay-550e8400-e29b-41d4-a716-446655440000
Authorization: Bearer ${PROVIDER_SECRET}
Content-Type: application/json
```

Key ổn định theo **một** thao tác nghiệp vụ (ví dụ một `internalPaymentId`), không random mỗi retry.

## Webhook — xử lý trùng

1. Lưu `event_id` unique.
2. Nếu insert trùng → return **200** ngay (đã xử lý).
3. Cập nhật `payments` row theo `provider_object_id`.

## Đối soát (pseudo)

```java
if (payment.isStuckProcessing()) {
  var remote = gatewayPort.fetchPaymentStatus(payment.getProviderId());
  payment.reconcileWith(remote);
}
```

Gọi API qua adapter đã cấu hình timeout (`call-external-api`).

**Last updated:** 2026-04-11
