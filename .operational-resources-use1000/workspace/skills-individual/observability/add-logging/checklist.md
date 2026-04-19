# Checklist: Add Logging

Dùng khi thêm/chỉnh log trong code (service, client, job).

## API & style

- [ ] Dùng **SLF4J** `LoggerFactory.getLogger` — không `System.out` / `printStackTrace` trong luồng chính.
- [ ] Message **parameterized** (`{}`) thay vì nối chuỗi khi có thể.

## Levels

- [ ] `INFO` không tràn (không log từng bản ghi loop lớn).
- [ ] `DEBUG`/`TRACE` chỉ khi phù hợp profile / timebox.

## Security & privacy

- [ ] Không log password, token đầy đủ, secret header, thẻ, CVV.
- [ ] Không log object có `toString()` lộ PII — ưu tiên id/state tối thiểu.

## MDC

- [ ] Nếu tự `MDC.put`: luôn **remove/clear** trong `finally` (đặc biệt thread pool).

## Exceptions

- [ ] Tránh log cùng một exception nhiều lần không cần thiết; ưu tiên boundary (handler) có stack.

## Ops alignment

- [ ] Field cần grep (vd. `orderId=`) thống nhất với cách đọc log (`skills/observability/analyze-application-logs/README.md`).

**Last updated:** 2026-04-11
