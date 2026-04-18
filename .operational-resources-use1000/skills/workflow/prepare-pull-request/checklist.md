# Checklist: Prepare Pull Request

Dùng **trước** khi chuyển MR sang **Ready for review** (hoặc trước khi ping reviewer).

## Diff & scope

- [ ] Không có file **nhầm** (local config, `.idea`, secret, dump)
- [ ] Diff **khớp** ticket — refactor lớn không liên quan đã tách hoặc được ghi rõ

## Quality

- [ ] Test (và lint/format nếu team bắt buộc) đã **chạy local** xanh
- [ ] Không còn **debug** log tạm / `println` vô ý nghĩa

## Mô tả MR

- [ ] Có **What / Why / How to test**
- [ ] Link **ticket**; link **`docs/current-task/...`** nếu task dẫn dắt PR
- [ ] **Risk / rollback** đã nêu khi có migration, breaking API, flag, cache

## Review

- [ ] Đã **self-review** (`rules/08-review-checklist.md` + `review-code` nếu dùng)

## Hậu push

- [ ] **CI** xanh hoặc có ghi chú blocker rõ + owner

**Last updated:** 2026-04-11
