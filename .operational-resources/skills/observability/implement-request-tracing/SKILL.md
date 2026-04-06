# Skill: Implement Request Tracing

## Goal

Truy vết request qua service: trace id, W3C Trace Context.

## Steps

1. Propagate `traceparent` / `X-B3-*` nếu gateway gửi.
2. Micrometer Tracing + Brave/OpenTelemetry theo stack team.
3. Log: in trace id trong MDC.
4. Test: trace qua outbound call (WebClient filter).
