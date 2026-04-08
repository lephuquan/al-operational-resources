# Endpoint List (Overview)

| Module | Method | Path | Auth | Main response | Notes |
|--------|--------|------|------|---------------|-------|
| Auth | POST | `/api/v2/auth/login` | Public | `AuthTokenResponse` | |
| Auth | POST | `/api/v2/auth/refresh` | Refresh cookie | `AuthTokenResponse` | |
| Auth | POST | `/api/v2/auth/logout` | Access token | Empty | |
| Order | POST | `/api/v2/orders` | USER+ | `OrderResponse` | |
| Order | GET | `/api/v2/orders` | USER+ | `OrderPageResponse` | Pagination |
| Order | GET | `/api/v2/orders/{id}` | USER+ | `OrderResponse` | |
| Order | PATCH | `/api/v2/orders/{id}/status` | MANAGER+ | `OrderResponse` | |
| Ops | GET | `/actuator/health` | Internal | Health payload | Neu bat actuator |

Su dung `{id}` thay cho `:id` de dong bo voi OpenAPI.
