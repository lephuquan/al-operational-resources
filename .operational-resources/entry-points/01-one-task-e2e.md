# Entry 1 — Một task: ticket → code → test → MR → Done

## Mục đích

Định tuyến **end-to-end** cho **đúng một** work item (feature / bugfix / refactor nhỏ trong scope ticket), dùng tài liệu sẵn có trong `.operational-resources/`.

## Nội dung chuẩn nằm ở đâu?

| Nội dung | File (canonical) |
|----------|------------------|
| **Single entry** — DoR, phase, prompt contract, evidence trước MR | `.operational-resources/PLAYBOOK.md` |
| **Flow chi tiết** — thu thập context, test, review, MR | `.operational-resources/WORKFLOW.md` |
| **File task** — một file markdown / ticket | `.operational-resources/docs/current-task/` + `TEMPLATE.md` |

File này (**`01-one-task-e2e.md`**) chỉ **thứ tự đọc** và **chỗ rẽ** theo loại task; không thay hai file trên.

## Thứ tự đọc khuyến nghị

1. **`.operational-resources/AGENTS.md`** — ưu tiên và điều cấm khi dùng AI.
2. **`.operational-resources/PLAYBOOK.md`** — DoR/DoD, 6 phase, checklist evidence.
3. **`.operational-resources/WORKFLOW.md`** — chi tiết từng bước (test, review, MR).
4. **Task file:** copy / cập nhật từ **`.operational-resources/docs/current-task/TEMPLATE.md`**; đọc **`.operational-resources/docs/current-task/README.md`** (dashboard, convention).
5. **Triển khai theo loại task**
   - **Feature (mặc định):** **`.operational-resources/skills/workflow/implement-feature/README.md`**
   - **Bugfix:** **`.operational-resources/skills/workflow/investigate-bug/README.md`** (có thể song song với debugging: `skills/debugging/analyze-stacktrace/README.md`, `debug-backend-error/README.md`, …)
   - **Refactor có kiểm soát:** **`.operational-resources/skills/code-quality/refactor-clean-code/README.md`**
6. **Mở MR:** **`.operational-resources/skills/workflow/prepare-pull-request/README.md`**
7. **Self-review:** **`.operational-resources/rules/08-review-checklist.md`** + (nếu dùng) **`skills/code-quality/review-code/README.md`**

## Skills thường dùng (chọn theo task)

- Backend slice: `skills/backend/create-rest-api/README.md`, `create-service-layer/README.md`, `create-jpa-entity/README.md`
- Test: `skills/testing/write-unit-test/README.md`, `write-integration-test/README.md`, `create-test-data/README.md`
- Security (khi đụng API/DTO): `skills/security/validate-input/README.md`, `secure-api-endpoint/README.md`

## Kết thúc task

- Cập nhật **§12 Progress log** và **§13 DoD** trong file task; dashboard **`docs/current-task/README.md`** nếu team dùng.
- Phase 6 trong **`PLAYBOOK.md`** (close task, learned notes).

**Last updated:** 2026-04-11
