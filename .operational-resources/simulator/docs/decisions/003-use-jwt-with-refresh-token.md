# ADR-003: Sử dụng JWT + HttpOnly Refresh Token

**Ngày**: 2026-03-10  
**Trạng thái**: [Proposed | Accepted | Rejected] — *cập nhật theo team*

## Context

Cần cơ chế authentication an toàn, scalable và UX tốt (không yêu cầu login lại thường xuyên).

## Decision

- Access Token: JWT (ví dụ TTL 15 phút)
- Refresh Token: HttpOnly + Secure cookie (ví dụ TTL 7 ngày)

## Alternatives Considered

- Session-based server-side: đơn giản nhưng phụ thuộc sticky session / store.
- JWT only (không refresh): UX kém hơn.
- OAuth2 + OIDC: phù hợp khi có IdP; phức tạp hơn cho internal.

## Consequences

- Tăng security (refresh token không lộ ở JS).
- Cần rotation + revoke strategy (blacklist / store) theo yêu cầu bảo mật.
