# Checklist: Production issue

Dùng trong và sau incident. Bỏ qua mục không áp dụng.

## Triage

- [ ] Impact (user, SLA, data) đã ước lượng
- [ ] Scope (toàn hệ / partial / một dependency) đã xác định
- [ ] Thời gian bắt đầu + mẫu correlation/trace id (không secret) đã có

## Ngữ cảnh deploy

- [ ] Version/commit deploy và thay đổi config/flag/migration gần đây đã kiểm tra
- [ ] So sánh với staging khi có thể

## Observability

- [ ] Log đã truy theo id; stack đã phân tích (analyze-stacktrace) cho mẫu đại diện
- [ ] Metrics/traces hỗ trợ giả thuyết (latency, error rate, dependency)

## Mitigation

- [ ] Hành động giảm blast radius đã làm (flag/scale/circuit/rollback) — có approval nếu policy yêu cầu
- [ ] Không lộ secret/PII khi trao đổi trong chat hoặc ticket

## Sau sự cố

- [ ] Post-incident note ngắn (timeline + mitigation + giả thuyết RC) — không PII
- [ ] Action items: alert, test, runbook, ticket theo dõi

**Last updated:** 2026-04-09
