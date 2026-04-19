# Checklist: Analyze stacktrace

Dùng khi đọc log/test failure. Bỏ qua mục không áp dụng.

## Đầu vào

- [ ] Có đủ stack (exception + ít nhất một khối `Caused by` nếu có)
- [ ] Biết package prefix ứng dụng để nhận diện frame “của mình”

## Phân tích

- [ ] Đã xác định exception/message ở tầng ngoài và ở `Caused by` sâu nhất (nếu có)
- [ ] Đã bỏ qua frame noise (CGLIB/proxy) trước khi kết luận
- [ ] Đã chỉ ra ít nhất một frame thuộc app hoặc ghi rõ “không có frame app”

## Ngữ cảnh

- [ ] Đã ghi endpoint/request id/correlation id (nếu có) — không ghi secret

## Handoff

- [ ] Có câu tóm tắt root cause + nơi mở code đầu tiên
- [ ] Có bước reproduce hoặc verify tiếp theo (breakpoint, query, curl đã redact)

**Last updated:** 2026-04-09
