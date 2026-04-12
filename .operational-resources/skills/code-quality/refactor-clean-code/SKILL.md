# Skill: Refactor Clean Code

## TL;DR (VI)

- Refactor **an toàn**: giữ **hành vi quan sát được** (observable behavior), **bước nhỏ**, mỗi bước **test xanh**.
- Luôn có **test hồi quy** trước khi đổi cấu trúc; tránh trộn “cleanup không liên quan” vào cùng commit.
- Đầu vào smell có thể từ **`detect-code-smells`** hoặc task/PR cụ thể.

## Goal

Cải thiện cấu trúc code (đọc dễ hơn, ít trùng lặp, ranh giới rõ) mà **không** đổi contract công khai và **không** làm hỏng hành vi đã được test — phù hợp merge dần (small PRs).

## Preconditions

- Scope refactor đã chốt (một smell / một method / một package).
- Có test che chở hành vi hiện tại hoặc cam kết viết test **trước** khi đổi logic (characterization test nếu cần).
- Không refactor rộng khi đang hotfix production (trừ khi có quyết định rõ).

## Steps

1. **Bảo vệ hành vi**
   - Viết/củng cố test cho path quan trọng (happy + ít nhất một negative/edge nếu liên quan).
   - Ghi “intent” hiện tại vài dòng trong task file nếu code khó đọc (không paste logic dài).

2. **Refactor theo bước nhỏ (micro-steps)**
   - Ưu tiên thứ tự an toàn: **rename** → **extract method** → **move method** → **introduce object** → đổi cấu trúc lớn hơn.
   - Mỗi bước: diff nhỏ, compile, chạy test phạm vi module (hoặc full nếu nhanh).

3. **Giữ contract**
   - Không đổi signature public API, DTO JSON, mã lỗi HTTP nếu không có task/ADR riêng.
   - Nếu phải đổi contract: tách PR/refactor riêng sau khi thống nhất.

4. **Tránh regression**
   - Sau extract: đảm bảo call site vẫn đi qua cùng invariant.
   - Cẩn trọng với **null**, **transaction boundary**, **exception mapping** — refactor dễ làm lệch hành vi.

5. **Kiểm soát commit**
   - Một commit/PR = một mục tiêu refactor (hoặc một chuỗi commit rất nhỏ có message rõ).
   - Không “drive-by” format cả file không liên quan.

6. **Kết thúc**
   - Chạy test suite liên quan; cập nhật task/MR: what changed, what behavior preserved.
   - Nếu còn smell: ghi follow-up thay vì mở rộng scope vô hạn.

## Output

- Code đã refactor + test xanh + ghi chú ngắn (task hoặc MR) về hành vi được giữ nguyên.

## References

- `docs/current-task/TEMPLATE.md` (khối refactor / task type)
- `rules/02-coding-standards.md`
- `rules/08-review-checklist.md`
- `skills/code-quality/detect-code-smells/SKILL.md`
- `skills/code-quality/review-code/SKILL.md`
- `skills/testing/write-unit-test/SKILL.md`
- `skills/testing/create-test-data/README.md` (fixture khi bổ sung test cùng refactor)
- `skills/workflow/implement-feature/README.md`

**Last updated:** 2026-04-09
