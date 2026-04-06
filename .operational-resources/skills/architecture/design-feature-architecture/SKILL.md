# Skill: Design Feature Architecture

## Goal

Thiết kế feature trước khi code: ranh giới module, API, data, failure mode, và trade-off.

## Steps

1. Đọc spec: `docs/specs/feature-*.md` và task trong `docs/current-task/`.
2. Phác boundary: controller → service → repository; event nếu có.
3. Định nghĩa contract: request/response, error codes, idempotency.
4. Data: entity mới hay mở rộng bảng; migration; index.
5. Non-functional: performance, security, observability.
6. Ghi ADR ngắn nếu quyết định đáng kể (`docs/decisions/`).

## Output

- Tài liệu ngắn trong task file hoặc ADR; không over-engineer CRUD nhỏ.
