# Task lifecycle — ticket → Done (điểm vào)

## TL;DR (VI)

- **Một nguồn** cho luồng **một task** (ticket → code → test → MR → đóng): đọc **`FROM-TICKET-TO-DONE.md`**.
- **`PLAYBOOK.md`** và **`WORKFLOW.md`** ở gốc `.operational-resources/` chỉ còn **stub redirect** — giữ link cũ/bookmark.
- Playbook **theo giai đoạn** (implement / bug / MR) vẫn nằm trong **`skills/workflow/`**.

## Đọc gì

| File | Khi nào |
|------|---------|
| [`FROM-TICKET-TO-DONE.md`](FROM-TICKET-TO-DONE.md) | Luồng đầy đủ: DoR, từng bước, prompt, evidence, DoD |
| [`../guides/README.md`](../guides/README.md) | Triển khai & duy trì docs/skills/rules (bootstrap, review định kỳ) |
| [`../skills/workflow/implement-feature/README.md`](../skills/workflow/implement-feature/README.md) | Khi đang code feature theo slice |

**Last updated:** 2026-04-11
