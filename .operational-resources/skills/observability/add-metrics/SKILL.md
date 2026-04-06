# Skill: Add Metrics

## Goal

Micrometer: HTTP metrics, custom timer/counter, dashboard readiness.

## Steps

1. Bật Actuator + Prometheus (`metrics`) nếu team dùng.
2. Custom metric: `MeterRegistry.counter/timer` cho domain event.
3. Thẻ (tags) ít cardinality (tránh userId làm tag).
4. Alert: error rate, latency, saturation.
