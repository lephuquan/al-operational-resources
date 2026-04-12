# Skill: Implement Request Tracing

## Goal

Truy vết request qua service: trace id, W3C Trace Context.

## Steps

1. Propagate `traceparent` / `X-B3-*` nếu gateway gửi.
2. Micrometer Tracing + Brave/OpenTelemetry theo stack team.
3. Log: in trace id trong MDC.
4. Test: trace qua outbound call (WebClient filter).

## References

- `skills/observability/analyze-application-logs/README.md` (lọc log theo trace / correlation)
- `skills/observability/add-metrics/README.md` (Micrometer Tracing cùng hệ sinh thái)
- `skills/observability/add-logging/README.md` (MDC xuất hiện trong log)
- `skills/integration/call-external-api/README.md` (propagate header outbound)

**Last updated:** 2026-04-11
