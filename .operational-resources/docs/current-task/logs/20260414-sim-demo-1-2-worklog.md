# Worklog - SIM-DEMO-1 and SIM-DEMO-2 preparation

**Date:** 2026-04-14
**Scope:** Build simulator infrastructure baseline (SIM-DEMO-1) and prepare main feature ticket (SIM-DEMO-2).

## 1) Context

- Demo theme: ShelfLog (Spring Boot + Postgres dev + H2 test).
- Constraint: one source of docs under `.operational-resources/docs/`.
- Goal: make infra runnable/testable first, then keep API ticket as main implementation task.

## 2) Actions performed (chronological)

### A. Simulator/docs consolidation

1. Removed duplicate `simulator/docs/` tree to avoid dual source of truth.
2. Updated references in:
   - `simulator/DEMO-PROJECT-BRIEF.md`
   - `simulator/README.md`
   - `.operational-resources/MAP.md`
   - `docs/project-overview.md`, `docs/specs/*`, `docs/api/*`, `docs/current-task/*`
3. Re-validated references by searching `simulator/docs` occurrences.

### B. Introduced two-task sequence

1. Added **SIM-DEMO-1** infra task: `docs/current-task/20260414-shelflog-infra.md`.
2. Kept **SIM-DEMO-2** as main feature: `docs/current-task/20260411-shelf-items-api.md`.
3. Synced simulator template tickets:
   - `simulator/DEMO-TICKET-20260414-shelflog-infra.md`
   - `simulator/DEMO-TICKET-20260411-shelf-items-api.md`
4. Updated dashboard in `docs/current-task/README.md`.

### C. Implemented SIM-DEMO-1 infrastructure in code

1. Updated `pom.xml` dependencies:
   - `spring-boot-starter-web`
   - `spring-boot-starter-validation`
   - `spring-boot-starter-data-jpa`
   - `spring-boot-starter-actuator`
   - `postgresql` (runtime)
   - `h2` (test)
2. Added/updated Spring config files:
   - `src/main/resources/application.yml`
   - `src/main/resources/application-dev.yml`
   - `src/main/resources/application-test.yml`
   - `src/test/resources/application.properties` (active profile `test`)
3. Removed old `src/main/resources/application.properties`.
4. Added integration test:
   - `src/test/java/com/programming_with_al/al_operational_resources/infra/ActuatorHealthIntegrationTest.java`

## 3) Validation evidence

### Command

```text
./mvnw.cmd -q test
```

### Result

- Exit code: `0`
- `AlOperationalResourcesApplicationTests` passed with active profile `test`.
- `ActuatorHealthIntegrationTest` passed; `/actuator/health` returned status `UP`.
- DataSource during tests: H2 in-memory (`jdbc:h2:mem:shelflogtest`).

## 4) Issues encountered and fixes

1. **PowerShell command chaining issue** (`&&` not valid separator).
   - Fix: use `;` and explicit `Set-Location`.
2. **Unneeded H2 dialect warning** in logs.
   - Fix: removed explicit dialect property from `application-test.yml`.
3. **Accidental notebook edit tool attempts** on markdown files.
   - Fix: switched to markdown/file edit tools.

## 5) Lessons learned

- Split infra and feature tasks improves traceability and onboarding.
- Keeping one docs source (`docs/`) reduces drift and review overhead.
- For simulator demos, baseline infra should be validated by at least one infra-focused IT before feature work.

## 6) Suggested improvements for next iterations

1. Add a lightweight runbook snippet in `docs/setup/02-local-development.md` for daily dev reset.
2. Consider adding a CI check that fails if `simulator/docs/` is recreated.
3. When SIM-DEMO-2 ships, append endpoint-level verification samples (curl/Postman) in a new dated worklog file.

---

**Status:** SIM-DEMO-1 complete, SIM-DEMO-2 ready to implement.
