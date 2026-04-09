# Checklist: Review Project Architecture

Checklist nhanh trước khi chốt narrative (strengths / risks / P0-P2 actions).

## Review setup

- [ ] Review scope đã chốt (whole repo / module / changed area)
- [ ] Timebox đã chốt (quick scan vs deep review)

## Baseline read

- [ ] `docs/architecture/02-system-overview.md`
- [ ] `docs/architecture/04-folder-structure.md`
- [ ] `docs/architecture/06-backend-layers-and-dependencies.md`

## Layering & coupling

- [ ] Controllers: chỉ mapping HTTP + validation; không chứa business rules
- [ ] Services: giữ orchestration + domain rules; boundaries rõ ràng
- [ ] Persistence: repositories/entities bám documented rules; không vi phạm layer

## Cross-cutting

- [ ] Security model nhất quán với `09-security-architecture-backend.md`
- [ ] Global error handling và API error shape đã được rà (`docs/api/` khi cần)
- [ ] Logging/observability đủ để debug production issues
- [ ] Integration failure behavior đã kiểm tra (timeout/retry/circuit breaker khi phù hợp)

## Tests

- [ ] Critical paths có automated coverage (unit và/hoặc integration)
- [ ] Đã nhận diện slow/flaky tests (nếu có)
- [ ] Đã đánh giá coverage cho negative/error-path ở use case chính

## Risk framing

- [ ] Mỗi risk có impact + likelihood
- [ ] Mỗi action có owner suggestion và smallest first step
- [ ] Không action nào vi phạm architecture rules nếu chưa có ADR/approval

## Output shape

- [ ] Review scope nằm ở đầu báo cáo
- [ ] Có Three strengths
- [ ] Có Three risks
- [ ] Có Three actions với nhãn **P0 / P1 / P2**
- [ ] Có recommended first implementation slice

**Last updated:** 2026-04-08
