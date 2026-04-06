# Skill: Debug Production Issue

## Goal

Xử lý sự cố prod một cách an toàn: giảm blast radius, tìm nguyên nhân từ log/metrics/trace, quyết định hotfix vs rollback.

## Steps

1. Thu thập triệu chứng: thời gian, % lỗi, region, version deploy, thay đổi gần đây.
2. Kiểm tra health: actuator, load balancer, DB connection pool, dependency bên ngoài.
3. Log: tìm exception đầu tiên theo correlation/request id; so sánh với staging.
4. Metrics: latency, error rate, saturation (CPU, memory, thread pool).
5. Mitigation: scale, circuit break, feature flag off, rollback image (theo runbook team).
6. Post-incident: ghi ngắn vào notes (không PII).

## Preconditions

- Có quyền truy cập log/metrics theo policy tổ chức; không paste secret vào chat AI.
