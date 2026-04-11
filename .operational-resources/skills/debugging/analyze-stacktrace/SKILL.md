# Skill: Analyze Stacktrace

## TL;DR (VI)

- Đọc **stack trace** Java/Spring để tìm **root cause** (thường ở **`Caused by:`** cuối hoặc exception gốc).
- Bỏ **noise** (CGLIB, AOP, framework); tìm frame thuộc **package dự án** để mở code trước.
- Ghi lại **ngữ cảnh** (endpoint, input, correlation id) trước khi sửa.

## Goal

Từ một stack trace (log, test failure, IDE console), đưa ra: loại lỗi, nguyên nhân khả dĩ nhất, và điểm trong code nên mở đầu tiên — không lan man vào toàn bộ framework.

## Preconditions

- Có **full stack trace** (hoặc đủ từ dòng exception đến vài `Caused by`).
- Biết prefix package ứng dụng (ví dụ `com.example.`).

## Steps

1. **Đọc exception đầu tiên**
   - Ghi tên class exception và message (ví dụ `IllegalArgumentException`, `DataIntegrityViolationException`, `WebClientResponseException`).

2. **Theo chuỗi `Caused by`**
   - Cuộn xuống **tìm `Caused by:`**; thường **dòng cuối cùng** là nguyên nhân gốc (SQL, NPE, validation, timeout).
   - Nếu nhiều lớp bọc: đọc từ dưới lên để thấy lỗi thật.

3. **Lọc noise**
   - Bỏ qua frame thuần proxy: `$$SpringCGLIB$$`, `jdk.proxy`, `ReflectiveMethodInvocation` (trừ khi lỗi liên quan AOP config).
   - Reactive: tìm `Caused by` trong chuỗi reactor nếu stack dài.

4. **Tìm frame ứng dụng**
   - Scan từ trên xuống dưới (hoặc từ `Caused by` lên) dòng đầu tiên có package **`com.<yourapp>`** — đó là **điểm vào hợp lý** để debug.
   - Nếu không có frame app: lỗi có thể **cấu hình**, **dependency**, hoặc **dữ liệu DB** — ghi nhận và chuyển sang skill debug khác.

5. **Phân loại nhanh**
   - Validation / bind: `MethodArgumentNotValid`, `ConstraintViolation`, `BindException`.
   - DB: `DataIntegrityViolation`, `SQLGrammar`, deadlock/timeout.
   - HTTP client: `RestClientException`, `WebClientResponseException`, read timeout.
   - Spring Security: `AccessDenied`, `AuthenticationCredentialsNotFound`.
   - OOM / thread: `OutOfMemoryError`, `RejectedExecution`.

6. **Thu thập ngữ cảnh**
   - Request path, method, user/tenant (nếu log có), **correlation/trace id**, payload đã redact.

7. **Output cho bước tiếp**
   - 1–3 câu: root cause + file:line hoặc class#method đề xuất mở đầu + gợi ý bước verify (breakpoint, SQL log, reproduce curl).

## Output

- Tóm tắt root cause + điểm code ưu tiên + loại lỗi + context đã ghi.

## References

- `skills/debugging/debug-backend-error/SKILL.md`
- `skills/debugging/debug-production-issue/SKILL.md`
- `rules/06-security.md` (không paste secret vào log khi reproduce)

**Last updated:** 2026-04-09
