# Checklist: Configure logging

Dùng trước khi merge thay đổi logging. Bỏ qua mục không áp dụng.

## Profile & level

- [ ] `dev` / `prod` (và profile khác) có level phù hợp; prod không để DEBUG/TRACE mặc định cho root hoặc SQL
- [ ] SQL/hibernate log chỉ bật có kiểm soát (thường dev hoặc incident tạm)

## Output & disk

- [ ] Console và/hoặc file appender rõ ràng
- [ ] Rolling / retention cấu hình (tránh đầy disk trên VM)

## Correlation & vận hành

- [ ] Pattern có trace/correlation id nếu stack đã set MDC
- [ ] JSON encoder (nếu dùng) khớp pipeline log team

## Bảo mật

- [ ] Không log secret/PII; đã rà pattern `log.*` nguy hiểm trong PR liên quan

## Docs

- [ ] `docs/setup/` cập nhật nếu dev cần bật flag/log đặc biệt để chạy local

**Last updated:** 2026-04-09
