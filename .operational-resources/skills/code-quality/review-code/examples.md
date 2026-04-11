# Examples: Code review

Mẫu văn phong ngắn, có thể dán vào PR hoặc ghi self-review.

## Tóm tắt review (PR comment)

```markdown
## Review summary

**Verdict:** Request changes

**Blocking**
1. `OrderController.java` — Missing authz on `POST /orders`; should match `GET /orders/{id}` policy.
2. `OrderServiceImpl.java` — `save` inside loop over lines → N+1; batch or aggregate update.

**Non-blocking / suggestions**
- Consider extracting discount block to private method (readability).
- Test name `test1` → rename for intent.

**Tests:** `./mvnw test` not evidenced in description — please confirm green.
```

## Comment có actionable (inline style)

```text
Suggestion: use `Optional.orElseThrow` with domain exception here so `ControllerAdvice` maps consistently — same pattern as `UserService.findById`.
```

```text
Blocking: `customerId` from client is concatenated into file path — risk path traversal; sanitize or use UUID object name only (see implement-file-upload skill).
```

## Self-review checklist ngắn (trước khi push)

```markdown
- [ ] Ran `./mvnw test`
- [ ] Re-read diff for secrets/PII
- [ ] Updated `docs/api/08-endpoint-list.md` if new route
- [ ] MR has What / Why / How to test
```

**Last updated:** 2026-04-09
