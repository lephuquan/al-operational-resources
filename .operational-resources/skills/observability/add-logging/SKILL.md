# Skill: Add Logging

## Goal

Logging có cấu trúc: level đúng, correlation id, không PII/secret.

## Steps

1. Dùng SLF4J (`LoggerFactory.getLogger`); không `System.out`.
2. MDC: `traceId`/`requestId` từ filter hoặc gateway.
3. INFO: milestone; DEBUG: chi tiết (chỉ dev/staging).
4. Không log password, full token, full card.
5. Logback `logback-spring.xml` theo profile.
