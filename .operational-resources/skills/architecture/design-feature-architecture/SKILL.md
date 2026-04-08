# Skill: Design Feature Architecture

## Goal

Thiết kế feature trước khi code: ranh giới module, API, data, failure mode, và trade-off.

## Steps

1. Đọc spec: `docs/specs/feature-*.md` và task trong `docs/current-task/`.
2. Căn cứ kiến trúc: `docs/architecture/02-system-overview.md`, `docs/architecture/06-backend-layers-and-dependencies.md`, `docs/architecture/04-folder-structure.md`; phác boundary controller → application → domain/repository; event nếu có.
3. Định nghĩa contract: request/response, error codes, idempotency.
4. Data: entity mới hay mở rộng bảng; migration; index.
5. Non-functional: performance, security, observability.
6. Ghi ADR ngắn nếu quyết định đáng kể (`docs/decisions/`).

## Output

- Tài liệu ngắn trong task file hoặc ADR; không over-engineer CRUD nhỏ.
