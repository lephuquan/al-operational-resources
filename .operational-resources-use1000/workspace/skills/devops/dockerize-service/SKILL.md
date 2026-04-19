# Skill: Dockerize Service (Spring Boot)

## TL;DR (VI)

- **Multi-stage** build: stage build (Maven/Gradle) → image runtime **JRE** nhẹ; **`.dockerignore`** để build nhanh và giảm context.
- Runtime: user **non-root**, `ENTRYPOINT` dạng **exec**, port **8080** (hoặc đúng `server.port` app); cấu hình qua **`JAVA_OPTS`**, **`SPRING_PROFILES_ACTIVE`** — **không bake secret** vào image.
- **Healthcheck** (Docker) dùng actuator khi đã bật; với K8s ưu tiên **liveness/readiness** probe riêng.

## Goal

Produce a **production-minded** container image for a Spring Boot service: reproducible build, small attack surface, observable health, and alignment with team env/profile conventions.

## Preconditions

- Runnable app: **Spring Boot** (typical JAR from Maven or Gradle).
- Agreed **base image** policy (e.g. `eclipse-temurin`) and **Java major version** match the project.
- **Secrets** available only at runtime (env, secret store, orchestrator) — not in Git or image layers.

## Steps

1. **Choose layout**
   - One **`Dockerfile`** at repo root or module root (same directory as build file); document path in `docs/setup/` if non-obvious.
   - Add **`.dockerignore`** beside the Dockerfile (or effective build context root).

2. **Multi-stage build**
   - **Build stage:** official Maven or Gradle image aligned with JDK version; copy `pom.xml` / `build.gradle*` first when useful for layer cache, then source, then `package` / `bootJar`.
   - **Runtime stage:** slim **JRE** image (e.g. `eclipse-temurin:*-jre-*`); copy only the **fat JAR** (or extracted layers if team uses layered JAR — see `examples.md`).

3. **Runtime user & filesystem**
   - Create a non-privileged user/group; `USER` that user before `ENTRYPOINT`.
   - JAR path readable by that user only; avoid world-writable dirs.

4. **Process model**
   - Use **exec form** `ENTRYPOINT ["java", ...]` so PID 1 is Java (signal handling).
   - Pass JVM/app tuning via **`JAVA_OPTS`** (or `JAVA_TOOL_OPTIONS` if team standardizes on it) — document variable **names** in `docs/setup/03-configuration.md`, not values.

5. **Spring profiles & port**
   - Set **`SPRING_PROFILES_ACTIVE`** from orchestrator or `docker run -e`; defaults in Dockerfile only for local convenience (e.g. `dev`) if team agrees.
   - `EXPOSE` the port the app listens on (often **8080**); keep consistent with `server.port`.

6. **Health**
   - Optional **Docker `HEALTHCHECK`** curling **`/actuator/health`** when actuator is on the classpath and network allows; use **liveness/readiness** paths for Boot 3 if probes are split (see `skills/devops/health-check-endpoint/README.md`).
   - Do not expose sensitive dependency detail on **public** health responses.

7. **Security**
   - No **ARG/ENV** for passwords, API keys, or private keys.
   - Pin image **tags** with digest or minor version policy team uses; avoid `latest` in prod without process.
   - Scan image in CI if team requires (Trivy, etc.) — out of scope for file content here.

8. **Verify**
   - `docker build` and `docker run` locally; hit health or a smoke endpoint.
   - Confirm logs go to **stdout/stderr** as expected for log aggregation (align with `skills/devops/configure-logging/SKILL.md`).

## Output

- `Dockerfile`, `.dockerignore`, and optional `docker-compose.yml` (if team uses it).
- Short note in **`docs/setup/`** (e.g. build context, env var names, default port).

## References

- `skills/devops/configure-environment/README.md` (profiles, env)
- `skills/devops/configure-logging/SKILL.md` (stdout, rotation outside container)
- `skills/devops/health-check-endpoint/README.md` (Actuator, probes)
- `rules/06-security.md`
- `docs/setup/02-local-development.md`, `docs/setup/04-deployment-overview.md`

**Last updated:** 2026-04-11
