# Endpoint contract template

## TL;DR (VI)

- Copy một section dưới đây cho **mỗi endpoint mới**; sau đó thêm dòng vào `08-endpoint-list.md`.
- Giữ contract **đồng bộ** với OpenAPI (nếu có) — xem `12-openapi-source-of-truth.md`.

**Last updated:** 2026-04-08

---

## Endpoint: `<VERB> /api/v{major}/...`

### 1. Summary

- **Purpose:** one sentence.
- **Owner module / bounded context:**
- **Idempotency:** required / not required / supported via `Idempotency-Key`.

### 2. Authentication and authorization

- **Auth:** Public | Bearer | Cookie | API key | …
- **Roles / scopes:** e.g. `USER`, `orders:write`.
- **Authorization rules:** e.g. “only owner or admin”, “only when order status = DRAFT”.

### 3. Request

**Path parameters**

| Name | Type | Description |
|------|------|-------------|
| `{id}` | UUID / string | |

**Query parameters**

| Name | Required | Default | Description |
|------|----------|---------|-------------|
| | | | |

**Headers**

| Name | Required | Description |
|------|----------|-------------|
| `Authorization` | Yes/No | |
| `Idempotency-Key` | Optional | |

**Body (JSON)**

| Field | Type | Required | Constraints |
|-------|------|----------|-------------|
| | | | |

**Example request**

```http
POST /api/v2/orders HTTP/1.1
Content-Type: application/json

{
  "example": true
}
```

### 4. Response

**Success**

- **HTTP status:** 200 / 201 / 204 / …
- **Body schema:** name of DTO or inline field list.
- **Example:**

```json
{
  "success": true,
  "data": {},
  "meta": {}
}
```

**Errors**

| HTTP | `error.code` | When |
|------|--------------|------|
| 400 | | |
| 401 | | |
| 403 | | |
| 404 | | |
| 409 | | |
| 422 | | |
| 429 | | |

### 5. Side effects

- Database writes, messages published, emails sent, etc.

### 6. Backward compatibility

- **Safe to add optional fields later:** yes/no.
- **Breaking changes:** require new major version or deprecation path (see `06-versioning.md`, `11-deprecation-policy.md`).

### 7. References

- Spec / ticket: `docs/specs/...` or `current-task/...`
- OpenAPI operation id: `...` (if any)
