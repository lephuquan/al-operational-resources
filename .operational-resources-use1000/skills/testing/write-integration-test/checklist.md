# Checklist: Write Integration Test

Dùng trước merge khi thêm **IT mới** hoặc **đổi** cấu hình test (DB, security, profile).

## Scope

- [ ] Đã chọn **slice** nhỏ nhất đủ mục tiêu — không `@SpringBootTest` toàn app nếu `@WebMvcTest` / `@DataJpaTest` đủ.

## Database

- [ ] Chiến lược DB (**Testcontainers** / H2 / embedded) khớp policy team; không phụ thuộc DB dev máy local.
- [ ] Migration / schema test **đồng bộ** với app (hoặc có lý do và ghi chú rõ).

## Isolation & data

- [ ] Test **không** phụ thuộc thứ tự chạy không kiểm soát; không để dữ liệu “dính” giữa class (trừ strategy có tên — shared container + clean DB).
- [ ] Nếu service **commit** transaction: không giả định rollback `@Transactional` vẫn thấy dữ liệu — dùng `@Sql`/cleanup phù hợp.

## HTTP & security

- [ ] Status code + body assert **ổn định**; lỗi validation/security khớp handler thật.
- [ ] Endpoint bảo vệ: có **auth mock** hoặc test security config — không tắt security trong `main`.

## Flakiness

- [ ] Không assert theo **`now()`** thực; clock/random đã kiểm soát khi liên quan.
- [ ] Gọi ra ngoài đã **stub** (WireMock/mock) hoặc test không phụ thuộc mạng.

## CI

- [ ] Thời gian / tài nguyên Testcontainers chấp nhận được trên CI (reuse, parallel policy).

**Last updated:** 2026-04-11
