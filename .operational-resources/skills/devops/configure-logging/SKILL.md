# Skill: Configure Logging (Logback)

## TL;DR (VI)

- Chuẩn hóa **Logback** theo **Spring profile**: level hợp lý, **rotation**, pattern có **correlation id** (khi có MDC/trace).
- Prod: **INFO** root; **DEBUG** chỉ package app khi cần có kiểm soát — không để SQL/verbose vĩnh viễn.
- **Không log PII/secret**; JSON log khi tích hợp ELK/Loki (tuỳ stack).

## Goal

Cấu hình logging nhất quán giữa môi trường: đủ để debug incident, không ồn ào và không rò rỉ dữ liệu nhạy cảm.

## Preconditions

- Dự án dùng **Spring Boot + Logback** (mặc định) hoặc tương đương đã thống nhất.
- Biết nơi gom log (file local, stdout container, ELK, …) và policy retention.

## Steps

1. **Chọn cơ chế cấu hình**
   - Ưu tiên `logback-spring.xml` để dùng `<springProfile name="dev">` / `prod`.
   - Hoặc `application-*.yml` với `logging.level.*` cho phần đơn giản; phức tạp (JSON, nhiều appender) dùng XML.

2. **Level theo profile**
   - `dev`: có thể `DEBUG` cho `com.yourcompany`; `TRACE` chỉ tạm khi debug.
   - `prod`: `INFO` root; `WARN` cho framework ồn; bật `DEBUG` package app chỉ khi incident có timebox.

3. **Appenders & rotation**
   - Console cho container/K8s; file rolling cho VM nếu cần.
   - Rolling: **max size** + **max history** (hoặc time-based) để tránh đầy disk.

4. **Pattern & correlation**
   - Pattern gồm: timestamp, level, thread, logger, **message**.
   - Thêm `%X{correlationId}` hoặc tên MDC team dùng (trace id) khi middleware đã set MDC.

5. **Structured / JSON (tuỳ chọn)**
   - Encoder JSON (Logstash/Logback) khi log shipper yêu cầu; giữ field ổn định (`level`, `message`, `logger`).

6. **Bảo mật & tuân thủ**
   - Không log password, token, full credit card, đủ PII để identify người (trừ khi policy cho phép và mask).
   - Tránh `log.info("user {}", userObject)` nếu `toString()` lộ dữ liệu — log id/state tối thiểu.

7. **Kiểm tra**
   - Chạy app từng profile; xác nhận format và level.
   - Một request mẫu có correlation id xuyên suốt log (nếu đã bật tracing).

## Output

- `logback-spring.xml` và/hoặc chỉnh `application-*.yml` + ghi chú trong `docs/setup/` nếu thay đổi hành vi log cho dev.

## References

- `skills/devops/configure-environment/README.md` (profile)
- `skills/observability/add-logging/SKILL.md` (SLF4J usage trong code)
- `skills/observability/implement-request-tracing/SKILL.md` (MDC / trace id)
- `rules/06-security.md`
- `docs/setup/02-local-development.md`

**Last updated:** 2026-04-09
