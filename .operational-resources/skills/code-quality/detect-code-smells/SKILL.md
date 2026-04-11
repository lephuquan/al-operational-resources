# Skill: Detect Code Smells

## TL;DR (VI)

- Rà soát code Java/Spring để **nhận diện smell** (long method, god class, duplicate, N+1, primitive obsession, …).
- **Không** refactor lớn trong bước này — chỉ **liệt kê có bằng chứng** và gợi ý bước xử lý an toàn.
- Kết quả dùng cho self-review hoặc đầu vào **`refactor-clean-code`** / MR comment.

## Goal

Tạo danh sách code smells có thể kiểm chứng (file, symbol, ngắn gọn “tại sao là smell”) trên một scope đã chốt (class, package, PR diff), ưu tiên rủi ro cao (correctness, security, perf) trước style thuần túy.

## Preconditions

- Scope rõ: ví dụ “chỉ diff PR”, “package X”, “toàn module order”.
- Có thể đọc code + test hiện có (để tránh báo false positive).
- Đã nắm chuẩn team: `rules/02-coding-standards.md` (hoặc tương đương).

## Steps

1. **Thu thập scope**
   - Liệt kê file/class/method trong phạm vi; nếu theo PR thì bám diff.

2. **Kích thước và cấu trúc**
   - Method dài (~80+ dòng) hoặc **cyclomatic** cao (nhiều nhánh lồng): đánh dấu **long method / complex method**.
   - Class quá nhiều trách nhiệm hoặc dependency (SRP): **god class / feature envy** (logic “thèm” data của class khác).

3. **API và tham số**
   - Nhiều tham số primitive/flag (`boolean isX`): **primitive obsession** / unclear API — gợi ý parameter object hoặc tách method.
   - Public API lộ implementation (entity JPA ra controller): smell **layering**.

4. **Trùng lặp**
   - Copy-paste block: **duplicate logic** — ghi vị trí cả hai; gợi extract khi có test.

5. **Dữ liệu và hiệu năng**
   - Query/remote call trong vòng lặp: **N+1** / chatty I/O — gợi batch, join fetch, bulk API.
   - Transaction bọc remote dài: smell **transaction boundary** (xem architecture transactions doc).

6. **Bất biến và side effect**
   - Mutable shared state, static mutable, singleton abuse: ghi rủi ro concurrency/test.

7. **Đầu ra có thể hành động**
   - Mỗi smell: **vị trí** + **mức độ** (P0/P1/P2) + **gợi ý một bước** nhỏ (không rewrite cả module).
   - Tránh liệt kê chung chung không trỏ được code.

## Output

- Báo cáo dạng bullet hoặc bảng: smell → evidence → severity → suggested next step.
- Không bắt buộc sửa code trong cùng phiên — có thể handoff sang `refactor-clean-code`.

## References

- `rules/02-coding-standards.md`
- `rules/08-review-checklist.md`
- `docs/architecture/06-backend-layers-and-dependencies.md`
- `docs/architecture/08-transactions-and-consistency.md`
- `skills/code-quality/review-code/SKILL.md`
- `skills/code-quality/refactor-clean-code/SKILL.md`
- `skills/database/optimize-query/SKILL.md` (khi smell liên quan query)

**Last updated:** 2026-04-09
