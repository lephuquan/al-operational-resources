# API Overview

**Last updated**: 2026-04-08

## General information

- Base URL: `/api/v2/`
- API style: RESTful
- Data format: JSON
- Versioning: URL versioning (`/api/v2/`)
- Status: v2 la chuan hien tai, can dong bo voi chuan team truoc release

## Design principles

- Resource-oriented (noun-based).
- Response format nhat quan toan du an.
- Error handling va error codes ro rang.
- Backward compatibility khi co the.

## Idempotency va concurrency

- `GET`, `HEAD`, `OPTIONS`: idempotent.
- `PUT`, `DELETE`: idempotent theo semantics cua resource.
- `POST`: khong idempotent; neu endpoint co retry tu client, can nhac `Idempotency-Key`.
- Voi update canh tranh du lieu, uu tien optimistic locking (`version`) hoac `If-Match`/ETag.

## Rate limiting (vi du)

- Public endpoints: 60 requests/phut
- Authenticated endpoints: 300 requests/phut
- Auth endpoints: 20 requests/phut
