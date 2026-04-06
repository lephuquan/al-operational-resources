# Skill: Health Check Endpoint

## Goal

Actuator health: liveness/readiness, probe DB, Redis, custom.

## Steps

1. Thêm `spring-boot-starter-actuator`; expose `health`, `info` (theo security).
2. `management.endpoint.health` + custom `HealthIndicator` cho dependency.
3. Kubernetes: `/actuator/health/liveness` vs readiness (Spring Boot 3.x có sẵn groups).
4. Không lộ chi tiết nhạy cảm trong `health` public.
