# Checklist: Implement Feature

Dùng trước khi coi feature slice là xong hoặc trước khi mở MR. Bỏ qua mục không áp dụng.

## Chuẩn bị (DoR nhẹ)

- [ ] File `current-task/<task>.md` đã có AC và scope rõ
- [ ] Context pack (rules + docs + skill) đã ghi trong task hoặc đính kèm prompt
- [ ] First slice đã chốt (không làm “cả feature” một phát)

## Triển khai

- [ ] Code bám layer/package theo `docs/architecture/`
- [ ] Validation, authz, transaction boundary đã xem xét
- [ ] Không nhét business logic nặng vào controller (trừ khi team cho phép pattern khác và đã ghi rõ)

## Test

- [ ] Bảng AC → Test trong task đã cập nhật
- [ ] Có ít nhất happy path + một nhánh lỗi/edge quan trọng (nếu AC yêu cầu)
- [ ] Đã chạy `./mvnw test` (hoặc lệnh test chuẩn của team) thành công

## Docs & contract

- [ ] Nếu đổi API: đã cập nhật `docs/api/08-endpoint-list.md` và `docs/api/10-current-api-changes.md` (và file contract liên quan)
- [ ] Error codes / envelope nhất quán với `docs/api/` và project

## Chất lượng & an toàn

- [ ] Self-review: `rules/08-review-checklist.md` (+ `skills/code-quality/review-code/README.md` nếu dùng)
- [ ] Không secret, không log PII nhạy cảm
- [ ] Task file có progress log / blocker rõ (nếu chưa MR)

## Handoff MR

- [ ] Đã chuẩn bị mô tả MR (What / Why / How to test) — xem `skills/workflow/prepare-pull-request/README.md`
- [ ] Breaking change (nếu có) đã ghi rõ

**Last updated:** 2026-04-11
