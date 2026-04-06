# API Overview

**Last updated**: 06/04/2026

## General information

- Base URL: `/api/v2/`
- API style: RESTful (GraphQL chỉ nếu team quyết định thêm)
- Data format: JSON
- Versioning: URL versioning (`/api/v2/`)
- Status: phiên bản v2 đang là **chuẩn cá nhân** — đồng bộ với team trước khi release

## Design principles

- Tuân thủ RESTful standards.
- Resource-oriented (noun-based).
- Response format nhất quán toàn dự án.
- Error handling và error codes rõ ràng.
- Backward compatibility khi có thể.

## Rate limiting (ví dụ — điều chỉnh theo gateway/team)

- Public endpoints: 60 requests/phút
- Authenticated endpoints: 300 requests/phút
- Auth endpoints: 20 requests/phút

## Pagination strategy

- Default: cursor-based pagination (khi có dataset lớn)
- Fallback: offset + limit
