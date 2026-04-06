# Skill: Dockerize Service

## Goal

Dockerfile cho Spring Boot: multi-stage, non-root user, JVM flags cơ bản.

## Steps

1. Build JAR: `./mvnw -DskipTests package` (hoặc theo CI).
2. Stage runtime: JRE nhẹ (eclipse-temurin).
3. `USER nonroot`; expose port 8080; `ENTRYPOINT` exec form.
4. Env: `JAVA_OPTS`, `SPRING_PROFILES_ACTIVE`.
5. Healthcheck: `curl` actuator `/actuator/health` nếu bật.
