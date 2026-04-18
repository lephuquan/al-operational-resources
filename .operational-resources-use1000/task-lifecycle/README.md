# Task lifecycle — ticket → Done (điểm vào)

## TL;DR (VI)

- **Một nguồn** cho luồng **một task** (ticket → **AL code/test** → MR human → đóng): đọc **`FROM-TICKET-TO-DONE.md`**; quyền sở hữu bước code mặc định: **`current-task/SCHEMA.md`**.
- Playbook **theo giai đoạn** (implement / bug / MR) nằm trong **`skills/workflow/`** — bổ sung cho luồng tổng, không thay `FROM-TICKET-TO-DONE.md`.

## Đọc gì

| File | Khi nào |
|------|---------|
| [`FROM-TICKET-TO-DONE.md`](FROM-TICKET-TO-DONE.md) | Luồng đầy đủ: DoR, từng bước, prompt, evidence, DoD |
| [`../guides/README.md`](../guides/README.md) | Triển khai & duy trì docs/skills/rules (bootstrap, review định kỳ) |
| [`../skills/workflow/implement-feature/README.md`](../skills/workflow/implement-feature/README.md) | Khi đang code feature theo slice |

**Last updated:** 2026-04-17
