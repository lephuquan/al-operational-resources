# Skill: Analyze Application Logs

## TL;DR (VI)

- Triage log theo **khung thời gian** → **service / instance** → **level** (`ERROR` trước, mở rộng `WARN`) → **correlation / trace id** (một request xuyên suốt).
- Gom nhóm theo **logger**, **mẫu message**, **exception root**; đối chiếu **deploy / config / traffic** để tìm regression.
- **Không** dán log chứa **token, PII, secret** vào ticket công khai; dùng **hash / id** thay thế khi cần.

## Goal

Systematically extract **signals** from application logs to localize failures, correlate user-impacting incidents, and support post-incident review — in plain files, **Loki**, **ELK**, **CloudWatch**, or equivalent.

## Preconditions

- Access to the **log store** (UI, API, or SSH + files) for the target **environment**.
- Known **field names** for trace/correlation if structured JSON (`skills/observability/add-logging/README.md`, `skills/devops/configure-logging/README.md`).

## Steps

1. **Frame the question**
   - Symptom (error rate, latency, user report), **approximate start time**, affected **region/pod** if applicable.

2. **Narrow time and scope**
   - Select window: incident ± buffer; use **UTC** consistently.
   - Filter **service name**, **version/build id** (from log field or sidecar metadata), **host/pod** if noisy multi-tenant.

3. **Start from severity**
   - Pull **`ERROR`** (and **`FATAL`** if any); expand to **`WARN`** when errors are sparse or cascading.
   - Ignore known **noise** (health-check spam) via saved filters if the team maintains them.

4. **Follow a single request**
   - If **`correlationId`**, **`traceId`**, or **W3C `traceparent`** appears in logs, pivot all lines for that id (`skills/observability/implement-request-tracing/README.md`).
   - Reconstruct timeline: entry controller → service → outbound client → DB.

5. **Group and count**
   - **Top-N** stack traces or **exception class** + **first frame in app package**.
   - Group by **endpoint** / **job name** / **`logger`** to see dominant failure mode.

6. **Plain text / grep workflow**
   - Use **fixed strings** for stable codes (`error.code`, `orderId=` if safe); avoid over-broad regex on prod files.
   - **`zgrep`** / **`journalctl`** patterns as appropriate for the host.

7. **Log platform queries (examples)**
   - **Loki:** filter labels `{app="orders", env="prod"}`, then `|= "ERROR"` and parse JSON fields if present.
   - **ELK / OpenSearch:** KQL/Lucene on `level:ERROR` and time range; aggregate with **visualize** or **transform**.
   - Adapt to your vendor; keep queries **bounded** in time to protect the cluster.

8. **Cross-check with change and load**
   - Overlay **deploy**, **feature flag**, **scale** events; spike in **QPS** can explain timeouts unrelated to a bad deploy.

9. **Cross-check metrics**
   - Align log spikes with **`add-metrics`** dashboards (error rate, latency, saturation) to confirm impact and rule out client-only issues.

10. **Escalation data package**
   - For tickets: **counts**, **one redacted exemplar**, **time range**, **query link** (internal), **hypothesis** — not raw bulk export with secrets.

11. **Handoff to deeper debug**
   - If logs insufficient, follow **`skills/debugging/debug-production-issue/README.md`** (traces, DB, upstream).

## Output

- Notes: dominant error pattern, correlation ids for exemplar requests, timeline vs deploy, suggested owner component.
   - Safe excerpts suitable for a ticket or incident doc.

## References

- `skills/observability/add-logging/README.md`
- `skills/observability/add-metrics/README.md`
- `skills/observability/implement-request-tracing/README.md`
- `skills/devops/configure-logging/README.md`
- `skills/debugging/debug-production-issue/README.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
