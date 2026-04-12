# Examples: Analyze Application Logs

Điều chỉnh label/field theo stack thật. Luôn **giới hạn thời gian** query.

## Grep (file hoặc stream)

```bash
grep -E "ERROR|Exception" app.log | tail -n 200
grep "correlationId=req-7f3a" app.log
```

## Loki (LogQL — minh hoạ)

```logql
{app="order-service", env="prod"} |= "ERROR" | json | line_format "{{.message}}"
```

Thêm filter JSON khi log là một dòng JSON: `| json | level="ERROR"`.

## OpenSearch / KQL (minh hoạ)

```text
level: "ERROR" and service.name: "order-service"
```

## Ticket an toàn (mẫu)

```text
Time: 2026-04-11 10:12–10:45 UTC
Service: order-service v1.4.2
Pattern: 1.2k x NullPointerException at OrderService.confirm (45% of errors)
Sample traceId: a1b2c3d4 (redacted payload)
Suspected deploy: v1.4.2 at 10:05 UTC — correlates with spike
```

**Last updated:** 2026-04-11
