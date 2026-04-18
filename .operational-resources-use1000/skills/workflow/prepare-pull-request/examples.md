# Examples: Prepare Pull Request

Thay `PROJ-123`, branch, lệnh test cho đúng repo. Không dán secret.

## Markdown mô tả PR (GitLab / GitHub)

```markdown
## What
- Fix NPE in `OrderMapper` when `dueDate` is null for Asia/HCM timezone.
- Add unit test covering null due date path.

## Why
- [PROJ-123](https://jira.example/PROJ-123) — checkout flow crashed for same-day orders.

## How to test
1. `./mvnw test -Dtest=OrderMapperTest`
2. Optional: POST `/api/v1/orders` with payload from ticket (redacted) on local profile `dev`.

## Risk / rollback
- **Risk:** None — internal mapping only.
- **Rollback:** revert single commit.

## Links
- Task: `current-task/20260411-order-mapper-npe.md`
```

## Title mẫu

- `fix(order): handle null dueDate in OrderMapper [PROJ-123]`
- `[PROJ-123] Fix NPE when dueDate missing`

**Last updated:** 2026-04-11
