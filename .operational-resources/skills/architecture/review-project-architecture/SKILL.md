# Skill: Review Project Architecture

## TL;DR (VI)

- Rà soát repo **nhanh**: layer, coupling, security, testability — không refactor lớn trừ khi có plan riêng.
- Kết luận: **3 điểm mạnh + 3 rủi ro + hành động P0/P1/P2**.
- Tập trung finding có thể hành động ngay, tránh nhận xét chung chung.

## Goal

Thực hiện một bản **architecture review ngắn gọn nhưng hành động được** cho repository: layering, coupling, cross-cutting concerns, và test posture; từ đó đưa ra follow-up ưu tiên rõ ràng (không đề xuất refactor lớn nếu chưa có plan riêng).

## Preconditions

- **None** — áp dụng cho mọi backend style Spring Boot trong workspace này.
- Có quyền truy cập code hiện tại và docs kiến trúc trong `.operational-resources/docs/`.

## Steps

1. **Đọc baseline và chốt scope**
   - Bắt đầu với `docs/architecture/02-system-overview.md`, `04-folder-structure.md`, `06-backend-layers-and-dependencies.md`.
   - Chốt phạm vi review: toàn repo, theo module, hay chỉ vùng đang thay đổi.
2. **Rà soát layering và coupling**
   - Kiểm tra controller có mỏng (thin) và service có giữ orchestration/domain behavior.
   - Kiểm tra boundaries của repository/data access và chiều phụ thuộc (dependency direction).
   - Đánh dấu layer leaks (web logic lọt vào domain, domain logic nằm ở controller, gọi DB sai lớp).
3. **Đánh giá chất lượng cross-cutting**
   - Security model và endpoint protection (`09-security-architecture-backend.md`).
   - Tính nhất quán của error handling (`docs/api/05-error-handling.md` nếu có).
   - Chất lượng logging/metrics/tracing phục vụ debug và vận hành.
4. **Đánh giá test posture và độ tin cậy**
   - Cân bằng coverage (unit vs integration) trên critical flows.
   - Phát hiện test brittle/flaky, setup nặng, và thiếu negative cases.
5. **Ưu tiên findings**
   - Viết 3 strengths và 3 risks kèm impact reasoning.
   - Đề xuất hành động gắn nhãn **P0 / P1 / P2** với first safe step nhỏ nhất.
6. **Xuất báo cáo ngắn gọn**
   - Giữ output theo hướng implementation-oriented và đúng scope.
   - Tránh đề xuất refactor rộng nếu user chưa yêu cầu rõ.

## Output

- Một báo cáo review ngắn gồm:
  - Scope of review
  - Three strengths
  - Three risks kèm impact
  - Three prioritized actions (**P0/P1/P2**) và first slice đề xuất
- Tùy chọn: follow-up plan chỉ làm khi user yêu cầu implement/refactor.

## References

- Rules: `rules/` (ràng buộc toàn workspace)
- Docs: `docs/architecture/01-README.md`, `02-system-overview.md`, `04-folder-structure.md`, `06-backend-layers-and-dependencies.md`, `09-security-architecture-backend.md`
- API / errors: `docs/api/01-README.md`, `docs/api/05-error-handling.md` (nếu có)
- Related skills: `skills/architecture/design-feature-architecture/SKILL.md`, `skills/code-quality/review-code/SKILL.md`, `skills/workflow/implement-feature/SKILL.md`

**Last updated:** 2026-04-08
