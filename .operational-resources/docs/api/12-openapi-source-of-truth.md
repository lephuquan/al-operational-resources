# OpenAPI and machine-readable source of truth

## TL;DR (VI)

- Nếu team có **OpenAPI/Swagger**, đây là nơi ghi **URL hoặc file** spec để AI và dev cùng đối chiếu.
- Markdown trong `docs/api/` mô tả **chuẩn**; OpenAPI nên **khớp** hoặc ghi rõ khi nào chỉ là draft.

**Last updated:** 2026-04-08

## Purpose

- Link **one place** where the generated or hand-written OpenAPI document lives.
- Avoid drift between free-form markdown and the spec actually used by CI/CD or clients.

## Where to point

Fill in for your project (delete unused rows):

| Kind | Location |
|------|----------|
| OpenAPI JSON (local path) | e.g. `src/main/resources/static/openapi.json` |
| OpenAPI YAML (local path) | e.g. `docs/openapi/openapi.yaml` |
| Hosted Swagger UI (dev) | `https://...` |
| CI artifact | link or job name |

## Sync rules

- When an endpoint changes, update **both**:
  - `08-endpoint-list.md` / `09-contract-template.md` (human-readable)
  - OpenAPI (machine-readable)
- If markdown is **ahead** of implementation, label the change in `10-current-api-changes.md` as **draft**.

## Optional: codegen

- If clients generate SDKs from OpenAPI, note the command or pipeline step here (one line).

## Related

- Response envelope: if OpenAPI does not match `03-response-format.md`, document the exception here.
