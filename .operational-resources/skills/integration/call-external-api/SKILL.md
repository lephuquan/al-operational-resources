# Skill: Call External API

## Goal

Gọi HTTP API bên ngoài an toàn: timeout, retry có điều kiện, circuit breaker, observability.

## Steps

1. Dùng `WebClient` (khuyến nghị) hoặc `RestTemplate` (legacy) theo team.
2. Cấu hình base URL qua config (`@ConfigurationProperties`), không hardcode prod URL.
3. Timeout connect/read; không block vô hạn.
4. Map 4xx/5xx sang exception domain; log correlation id.
5. Resilience4j (nếu có): retry idempotent, circuit breaker cho dependency dễ sập.
6. Test: mock server (WireMock) hoặc testcontainers.
