# Skill: Debug Backend Error (Local)

## TL;DR (VI)

- Xử lý lỗi backend trên **dev/local**: **tái hiện** → **khoanh vùng lớp** → **fix tối thiểu** → **test hồi quy**.
- Luôn dùng **`analyze-stacktrace`** trước khi đoán mù.
- Không commit cấu hình log DEBUG ồn ào; không log secret/PII khi reproduce.

## Goal

Kết thúc với: nguyên nhân đã xác định, sửa đủ nhỏ để an toàn merge, và có test (hoặc bước verify rõ) chứng minh lỗi không còn.

## Preconditions

- Có stack trace hoặc HTTP status + body lỗi từ local.
- App chạy được trên máy (xem `docs/setup/` nếu thiếu bước).
- Biết branch/commit đang chạy.

## Steps

1. **Thu thập dữ liệu**
   - Stack trace đầy đủ; request: method, path, query, body **đã redact** token/PII.
   - Profile Spring (`local`, `dev`), version dependency nếu liên quan (serialize, driver).

2. **Phân tích stack**
   - Làm theo `skills/debugging/analyze-stacktrace/SKILL.md` để chốt root cause khả dĩ và frame app đầu tiên.

3. **Tái hiện tối thiểu**
   - curl/Postman/MockMvc với payload nhỏ nhất gây lỗi.
   - Nếu flaky: ghi điều kiện (thứ tự request, clock, data seed).

4. **Khoanh vùng lớp**
   - Controller (mapping/validation) → Service (rule/transaction) → Repository/DB → HTTP client ra ngoài.
   - Tách biệt: lỗi **code** vs **data** vs **config** (URL DB sai, profile thiếu bean).

5. **Điều tra sâu (local)**
   - Breakpoint tại frame app; hoặc log DEBUG **tạm** cho package liên quan (`logging.level.com.example.order=DEBUG`).
   - Bật SQL log tạm nếu nghi DB (chỉ local; không để mặc định prod).

6. **Sửa**
   - Fix **nhỏ nhất** đúng root cause; tránh refactor rộng trong cùng PR fix bug.
   - Nếu cần đổi contract: tách task/PR hoặc thống nhất stakeholder.

7. **Chốt**
   - Thêm test regression (unit hoặc integration) hoặc ghi rõ “không thể test tự động vì …” + bước manual.
   - (Tuỳ chọn) Ghi vào `notes/debugging/bug-history.md` nếu lỗi hay gặp lại.

## Output

- Fix + test/verify note + tóm tắt nguyên nhân (1 đoạn) cho MR hoặc task.

## References

- `skills/debugging/analyze-stacktrace/SKILL.md`
- `docs/setup/01-README.md`, `docs/setup/02-local-development.md` (khi cần)
- `rules/06-security.md` (redact secret khi paste log/request)
- `skills/testing/write-integration-test/README.md`

**Last updated:** 2026-04-09
