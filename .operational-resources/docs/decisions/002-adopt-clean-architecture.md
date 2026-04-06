# ADR-002: Áp dụng Clean / Layered Architecture cho backend

**Ngày**: 2026-03-01  
**Trạng thái**: Accepted

## Context

Dự án nhiều module, cần codebase dễ maintain, test và mở rộng lâu dài.

## Decision

Áp dụng **layered architecture** với ranh giới rõ:

- Presentation (controllers + DTO)
- Application (services / use cases)
- Domain (entities/domain logic khi tách được)
- Infrastructure (repositories, adapters)

## Consequences

**Positive**

- Tách business logic khỏi framework boundary.
- Dễ test từng lớp.

**Negative**

- Nhiều file/boilerplate hơn khi module nhỏ.

**Risks**

- Over-engineering nếu áp dụng quá sớm cho CRUD đơn giản.
