# Checklist: Optimize API Response

Dùng trước khi merge thay đổi DTO/pagination/serialization.

## Shape & persistence

- [ ] Response **không** là entity JPA có lazy graph nguy hiểm; DTO/projection rõ ràng.
- [ ] Không dùng `@JsonIgnore` trên entity như **giải pháp dài hạn** thay cho DTO đúng endpoint.

## Lists

- [ ] List có **pagination** hoặc giới hạn theo chuẩn API; không unbounded.

## Contract

- [ ] `docs/api/` (hoặc OpenAPI) cập nhật nếu field/pagination đổi.

## Measurement

- [ ] Có so sánh **trước/sau** (timer, kích thước mẫu, hoặc ghi chú reproduce).

## Cache

- [ ] Nếu thêm cache: đã qua `caching-strategy` và không che slow query chưa xử lý.

**Last updated:** 2026-04-11
