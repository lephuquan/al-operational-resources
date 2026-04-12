# Skill: Review Code

## TL;DR (VI)

- Review **có cấu trúc**: correctness → design → security → test → performance → vận hành.
- Mỗi nhận xét **actionable** (gợi ý cụ thể hoặc câu hỏi mở); phân loại **must-fix** vs **nit/suggestion**.
- Self-review trước MR hoặc peer review; bám **`rules/08-review-checklist.md`**.

## Goal

Đánh giá thay đổi code (diff/PR) đủ để giảm bug, lỗ hổng, và nợ kỹ thuật — với kết luận rõ: có thể merge / cần sửa / cần thảo luận thêm.

## Preconditions

- Có diff hoặc danh sách commit; có context (task, ticket AC, spec) khi có.
- Biết tiêu chí team: branch, test bắt buộc, format MR (nếu peer review).

## Steps

1. **Nắm ngữ cảnh**
   - Đọc mô tả PR/task: mục tiêu, scope, cách test.
   - Xem file “nóng” trước (controller, security, migration, concurrency).

2. **Correctness**
   - Logic nghiệp vụ, edge case, null, idempotency, race nếu có.
   - Transaction boundary: rollback, isolation, không giữ lock quá lâu.

3. **Design & maintainability**
   - SRP, naming, coupling; controller mỏng; không leak entity ra API.
   - Độ phức tạp chấp nhận được; duplicate có cần extract không (có thể defer).

4. **API & contract**
   - Validation đầu vào; response/error envelope nhất quán `docs/api/`.
   - Breaking change được ghi rõ và đồng bộ docs.

5. **Security**
   - Authn/authz, input validation, path traversal/upload nếu liên quan.
   - Secret, PII, log an toàn (`rules/06-security.md`).

6. **Tests**
   - AC → test; happy path + nhánh lỗi quan trọng; flake risk.
   - Test thật sự chứng minh thay đổi (không chỉ tăng coverage vô nghĩa).

7. **Performance & ops**
   - N+1, batch, timeout, retry; logging/metrics đủ debug production.

8. **Kết luận review**
   - Tóm tắt: **Approve** / **Request changes** / **Comment only**.
   - Liệt kê must-fix (blocking) tách khỏi nit; gắn file/dòng khi có thể.

## Output

- Comment trên PR hoặc ghi chú self-review: danh sách must-fix + optional improvements + summary trạng thái.

## References

- `rules/08-review-checklist.md`
- `rules/02-coding-standards.md`
- `rules/06-security.md`
- `skills/security/security-review/README.md` (security pass chuyên sâu khi PR đụng auth, payment, PII)
- `rules/03-api-development.md`
- `docs/api/01-README.md`, `docs/api/05-error-handling.md` (nếu có)
- `skills/code-quality/detect-code-smells/SKILL.md`
- `skills/code-quality/refactor-clean-code/SKILL.md`
- `skills/workflow/prepare-pull-request/README.md`

**Last updated:** 2026-04-09
