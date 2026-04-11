# Checklist: Debug backend (local)

Dùng trước khi coi bug đã xử lý xong.

## Thu thập

- [ ] Stack / response lỗi đã lưu; request đã redact secret/PII
- [ ] Branch/commit và profile chạy local đã ghi

## Tái hiện

- [ ] Có bước reproduce tối thiểu (curl/MockMvc/postman) — ai cũng làm lại được
- [ ] Không phụ thuộc “trên máy tôi thì được” mà không ghi rõ điều kiện

## Khoanh vùng

- [ ] Đã xác định lớp chính (web/service/repo/integration) theo bằng chứng
- [ ] Đã dùng `analyze-stacktrace` hoặc tương đương trước khi sửa lung tung

## Sửa & log

- [ ] Fix nhỏ, đúng root cause
- [ ] Không commit log DEBUG/SQL verbose vĩnh viễn

## Chốt

- [ ] Test regression hoặc verify manual được ghi rõ
- [ ] (Tuỳ chọn) Đã cập nhật `notes/debugging/bug-history.md` nếu bug lặp lại

**Last updated:** 2026-04-09
