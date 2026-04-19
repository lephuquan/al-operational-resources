# Examples: Dockerize Service

Chỉ snippet **không chứa secret**. Đổi artifact name và version cho đúng project.

## Multi-stage Dockerfile (Maven)

```dockerfile
# syntax=docker/dockerfile:1

FROM maven:3.9-eclipse-temurin-17-alpine AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -q -B dependency:go-offline
COPY src ./src
RUN mvn -q -B -DskipTests package

FROM eclipse-temurin:17-jre-alpine
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
EXPOSE 8080
ENV JAVA_OPTS=""
ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar /app/app.jar"]
```

Notes:

- Pattern `sh -c "exec java ..."` keeps **exec** for Java as PID 1 while allowing **`JAVA_OPTS`** expansion.
- Nếu team dùng **Maven Wrapper** (`mvnw`), có thể thay stage build bằng JDK + copy `mvnw` + `.mvn/` thay vì image `maven:`.
- Nếu team dùng **fixed JAR name**, thay `*.jar` bằng tên cụ thể (tránh copy nhầm nhiều JAR trong `target/`).

## `.dockerignore` (gợi ý)

Khi build chạy hoàn toàn trong container, ignore `target/` trên host để giảm context:

```gitignore
.git
.gitignore
.idea
.vscode
*.iml
target/
```

## Build & run (commands)

```bash
docker build -t my-service:local .
docker run --rm -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=dev \
  -e JAVA_OPTS="-XX:MaxRAMPercentage=75" \
  my-service:local
```

## Optional: HEALTHCHECK (Actuator)

Chỉ khi image có **curl** và actuator mở nội bộ; với slim JRE có thể bỏ và dùng probe K8s.

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD wget -qO- http://127.0.0.1:8080/actuator/health || exit 1
```

Alpine thường có `wget`; image khác có thể cần cài tool hoặc dùng probe ngoài container.

## Optional: layered JAR (Spring Boot)

Khi đã bật layered JAR trong build (`spring-boot-maven-plugin` layers), có thể tách layers để cache tốt hơn — tham khảo [Spring Boot docs — Docker](https://docs.spring.io/spring-boot/reference/container-images/dockerfiles.html) (packaging layers). Chỉ áp dụng khi team đồng ý pipeline extract layers.

**Last updated:** 2026-04-11
