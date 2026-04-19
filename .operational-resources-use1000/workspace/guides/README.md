# Guides — triển khai & duy trì `docs/`, `skills/`, `rules/`

## TL;DR (VI)

- Thư mục này là **hướng dẫn cụ thể** (mỗi file một chủ đề) cho việc **dựng / mở rộng** và **rà soát / cập nhật** tài nguyên trong `.operational-resources/`.
- **Không** phải luồng làm một task sản phẩm — luồng đó nằm ở **`task-lifecycle/`**.

## Tài liệu

| File | Khi dùng |
|------|----------|
| [`bootstrap-docs-skills-rules.md`](bootstrap-docs-skills-rules.md) | Dự án mới, onboard AI context, thêm rule/doc/skill lần đầu hoặc mở rộng có kiểm soát |
| [`review-and-update-docs-skills-rules.md`](review-and-update-docs-skills-rules.md) | Định kỳ, trước release, hoặc **ngay khi** đổi contract / kiến trúc / cấu trúc skill |
| [`../RESOURCE-CHANGE-LOG.md`](../RESOURCE-CHANGE-LOG.md) | **Nhật ký delta:** mỗi lần thêm/sửa lớn `rules/`, `skills/`, `docs/`, … — append một mục (mới nhất trên cùng) |
| [`how-to-use-operational-system.md`](how-to-use-operational-system.md) | Huong dan tung buoc; **C.1** = giao AL trong Cursor (`@TASK.md` + prompt); xem them `HUMAN-AL-WORKFLOW-GUIDE.md` **Bước B2** |

## Neo nhanh

- **Một task ticket → Done:** [`../task-lifecycle/README.md`](../task-lifecycle/README.md)
- **Bản đồ:** [`../MAP.md`](../MAP.md) — **AI + quy tắc:** [`../AGENTS.md`](../AGENTS.md)

**Last updated:** 2026-04-17
