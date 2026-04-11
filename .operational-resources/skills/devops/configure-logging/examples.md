# Examples: Logback (Spring)

Snippet tham chiếu. Điều chỉnh package, file path, encoder theo dự án.

## `logback-spring.xml` — profile dev vs prod

```xml
<configuration>
  <springProfile name="dev,local">
    <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
      <encoder>
        <pattern>%d{ISO8601} %-5level [%thread] %logger{36} [%X{correlationId:-}] - %msg%n</pattern>
      </encoder>
    </appender>
    <logger name="com.example" level="DEBUG"/>
    <root level="INFO">
      <appender-ref ref="CONSOLE"/>
    </root>
  </springProfile>

  <springProfile name="prod">
    <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
      <encoder>
        <pattern>%d{ISO8601} %-5level [%thread] %logger{40} [%X{correlationId:-}] - %msg%n</pattern>
      </encoder>
    </appender>
    <logger name="com.example" level="INFO"/>
    <root level="WARN">
      <appender-ref ref="CONSOLE"/>
    </root>
  </springProfile>
</configuration>
```

## Rolling file (VM-style)

```xml
<appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
  <file>logs/app.log</file>
  <rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
    <fileNamePattern>logs/app.%d{yyyy-MM-dd}.%i.log.gz</fileNamePattern>
    <maxFileSize>20MB</maxFileSize>
    <maxHistory>14</maxHistory>
    <totalSizeCap>2GB</totalSizeCap>
  </rollingPolicy>
  <encoder>
    <pattern>%d{ISO8601} %-5level [%thread] %logger{36} - %msg%n</pattern>
  </encoder>
</appender>
```

## Chỉ level qua `application.yml` (đơn giản)

```yaml
logging:
  level:
    root: INFO
    com.example.order: DEBUG
```

## Lưu ý

- `correlationId` trong pattern chỉ hiện khi code/filter gán MDC — xem `implement-request-tracing`.
- JSON encoder (Logstash) thêm khi cần — giữ field ổn định cho parser.

**Last updated:** 2026-04-09
