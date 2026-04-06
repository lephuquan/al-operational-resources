# System Architecture Overview

**Last updated**: 06/04/2026

## 1. High-level architecture

```
Client (Browser / Mobile / Internal tools)
        |
        v (HTTPS)
API Gateway / Load Balancer (nếu có)
        |
        v
Spring Boot Application (al-operational-resources)
  - Auth / User / [Order, Payment, ...]
        |
        v
Database (PostgreSQL / …) + Cache (Redis) + Message Queue (nếu có)
```

## 2. Architecture style

- Kiến trúc chính: **Layered Architecture** + ranh giới rõ (presentation / application / domain / infrastructure — tùy mức độ tách package).
- **DDD** có thể áp dụng ở domain layer khi module phức tạp.
- **Event-driven** (optional) cho module như Payment, Notification khi team chọn.

## 3. Các layer chính (Spring Boot)

| Layer | Trách nhiệm | Công nghệ / vị trí điển hình |
|-------|-------------|------------------------------|
| Presentation | REST controller, DTO, validation trigger | `@RestController`, `@Valid` |
| Application | Orchestration, use case | `@Service` |
| Domain | Entity, rule nghiệp vụ (khi tách được) | Domain models, domain services |
| Infrastructure | DB, client ngoài | Spring Data JPA, `RestTemplate`/`WebClient`, v.v. |

## 4. Data flow (ví dụ: tạo Order)

User → Controller → Service → (Domain) → Repository → DB + (Event nếu có)

## 5. Non-functional requirements

- **Scalability**: scale instance theo deployment (stateless app).
- **Performance**: ví dụ p95 dưới 300ms cho API quan trọng [điều chỉnh theo SLO team].
- **Reliability**: retry + circuit breaker cho tích hợp ngoài (Resilience4j / team standard).
- **Security**: authentication + authorization nhiều tầng.

## 6. Integration points

- Payment gateway: [Stripe / VNPay / Momo / …]
- Notification: [email / push / queue — …]
- Third-party: […]
