# Checklist: Add Metrics

Dùng trước khi merge meter mới hoặc bật scrape Prometheus.

## Exposure

- [ ] Endpoint metrics/Prometheus chỉ expose khi **policy** cho phép; khớp cấu hình **Spring Security** (`health-check-endpoint`).

## Naming & types

- [ ] Tên meter **ổn định** và theo convention team (prefix, snake/dot).
- [ ] Đúng loại: **Counter** (tăng), **Timer** (latency), **Gauge** (trạng thái hiện tại).

## Cardinality

- [ ] Mọi tag có **tập giá trị hữu hạn** hoặc rất nhỏ — không tag `userId`, email, URL đầy đủ, free-text lỗi.

## Performance

- [ ] Đăng ký gauge/timer không làm **nóng** path quan trọng (callback gauge phải nhẹ).

## Test

- [ ] Unit test với **`SimpleMeterRegistry`** cho meter quan trọng (ít nhất một happy path).

## Docs

- [ ] Ghi lại tên meter + ý nghĩa tag trong doc vận hành hoặc `docs/setup/`.

**Last updated:** 2026-04-11
