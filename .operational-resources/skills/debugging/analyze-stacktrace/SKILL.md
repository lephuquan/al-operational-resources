# Skill: Analyze Stacktrace

## Goal

Đọc stack trace Java/Spring để xác định **gốc lỗi** (root cause) và lớp chịu trách nhiệm.

## Steps

1. Tìm dòng **Caused by** cuối cùng (thường là nguyên nhân thật).
2. Bỏ qua noise: framework proxy (CGLIB), reactor nếu không dùng reactive.
3. Xác định package dự án (`com.yourcompany...`) — đó là điểm bắt đầu sửa.
4. Phân loại: `ValidationException`, `DataIntegrityViolation`, `HttpClientError`, timeout, OOM.
5. Ghi lại: input, endpoint, correlation id (nếu có log).

## Output

- 1–2 câu mô tả root cause + file/method đề xuất mở đầu tiên.
