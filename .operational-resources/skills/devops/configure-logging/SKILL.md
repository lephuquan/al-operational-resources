# Skill: Configure Logging (Logback)

## Goal

Log level theo profile; appenders; rotation; JSON log nếu ELK.

## Steps

1. `logback-spring.xml` với `<springProfile>`.
2. Prod: INFO root; DEBUG chỉ package app khi cần.
3. Rolling policy: size + time.
4. Correlation id trong pattern.
