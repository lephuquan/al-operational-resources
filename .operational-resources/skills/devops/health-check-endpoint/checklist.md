# Checklist: Health Check Endpoint

Dùng trước khi merge cấu hình Actuator / security / probe.

## Exposure & privacy

- [ ] Chỉ expose endpoint **management** cần thiết (`health`, tối đa `info` nếu có lý do).
- [ ] **`management.endpoint.health.show-details`** không làm lộ chi tiết nhạy cảm cho client **anonymous** (prod: thường **`never`** hoặc **`when_authorized`**).
- [ ] Không bật **`env`**, **`beans`**, … trên cùng cổng public prod nếu không có tách network / auth mạnh.

## Probes (K8s / LB)

- [ ] **`management.endpoint.health.probes.enabled: true`** khi dùng **`/liveness`** và **`/readiness`**.
- [ ] **Liveness** trỏ **`/actuator/health/liveness`**; **readiness** trỏ **`/actuator/health/readiness`** (hoặc chiến lược team đã chốt).
- [ ] **Spring Security** (nếu có): probe path trả **200** khi healthy **không** cần credentials (hoặc dùng port management riêng + policy mạng).

## Custom health

- [ ] Mọi **`HealthIndicator`** tùy chỉnh có **timeout** / fail nhanh; không block thread vô hạn.
- [ ] **Detail** trong response không chứa secret, connection string đầy đủ, stack trace đầy đủ, hoặc PII.

## Verification

- [ ] `curl` (hoặc tương đương) từ ngoài giống probe thực tế; thử **readiness** khi tắt dependency phụ thuộc.
- [ ] Có test hoặc checklist thủ công đã ghi trong MR / `docs/setup/`.

**Last updated:** 2026-04-11
