# ADR-005: (Optional) Frontend Next.js nếu tách SPA

**Ngày**: 2026-04-01  
**Trạng thái**: Proposed

## Context

Tài liệu gốc đề xuất Next.js + Tailwind + shadcn cho frontend. Repo hiện tại là **Spring Boot**.

## Decision

Giữ backend Spring Boot; nếu sau này có frontend riêng, ưu tiên stack phù hợp team (có thể Next.js).

## Consequences

- Tách contract API rõ ràng (OpenAPI) để frontend/backend độc lập.
- Không áp dụng ADR này cho đến khi có quyết định sản phẩm/UX.
