# Create Service Layer (index)

## TL;DR (VI)

- Playbook triển khai **lớp service / use case**: logic nghiệp vụ, **transaction**, exception domain, test mock dependency.
- Neo **`docs/architecture/06-backend-layers-and-dependencies.md`** và **`08-transactions-and-consistency.md`**.
- Controller/API: **`create-rest-api`**; persistence: **`create-jpa-entity`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình đầy đủ: use case, DI, transaction, ports, lỗi, test |
| `examples.md` | Service + exception + readOnly + Mockito + PaymentClient port |
| `checklist.md` | Quality gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Chốt use case trong task hoặc design architecture.
2. Làm theo `SKILL.md`; tách `*Client`/port khi có integration (xem `skills/integration/call-external-api/README.md`).
3. Map exception sang HTTP ở layer advice (xem error-handling skills).
4. Chạy `checklist.md`.

## Liên kết nhanh

- `docs/architecture/06-backend-layers-and-dependencies.md`
- `docs/architecture/08-transactions-and-consistency.md`
- `docs/knowledge-base/coding-patterns.md`
- `skills/backend/create-rest-api/SKILL.md`
- `skills/backend/create-jpa-entity/SKILL.md`
- `skills/workflow/implement-feature/README.md`
- `skills/integration/call-external-api/README.md`
- `skills/integration/integrate-email-service/README.md`
- `skills/integration/integrate-message-queue/README.md`

**Last updated:** 2026-04-11
