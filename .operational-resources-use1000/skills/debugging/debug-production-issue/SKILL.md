# Skill: Debug Production Issue

## TL;DR (VI)

- Xử lý sự cố **production** an toàn: **giảm blast radius** trước, tìm nguyên nhân từ **log / metrics / trace**, rồi mới hotfix/rollback.
- **Không** dán secret/token/log đầy PII vào chat AI — chỉ mô tả đã redact hoặc dùng id giả.
- Sau ổn định: **post-incident** ngắn (notes) + action items (alert, test, runbook).

## Goal

Khôi phục dịch vụ hoặc giới hạn thiệt hại nhanh nhất có kiểm soát; có đủ bằng chứng để quyết định mitigation (scale, flag, rollback, hotfix) và tránh lặp lại cùng lỗi.

## Preconditions

- Có quyền truy cập log/metrics/tracing theo policy tổ chức (hoặc có người hỗ trợ lấy).
- Biết kênh incident (on-call, Slack, PagerDuty) và **ai approve** rollback/hotfix.
- Không paste secret vào prompt; dùng correlation id, time range, version deploy.

## Steps

1. **Triage nhanh**
   - Triệu chứng: thời gian bắt đầu, **% lỗi / latency**, region, user segment, feature bị ảnh hưởng.
   - Xác định **impact** (SLA, revenue, data) và **scope** (một pod vs toàn cluster vs một dependency).

2. **Thu thập ngữ cảnh triển khai**
   - Version image/commit deploy gần nhất; thay đổi config/flag/migration trong cửa sổ thời gian.
   - So sánh với staging/preprod nếu có.

3. **Sức khỏe hạ tầng & dependency**
   - Health: load balancer, **DB pool**, queue, cache, DNS, TLS.
   - Kiểm tra saturation: CPU, memory, GC, thread pool, connection exhaustion.

4. **Log & trace**
   - Tìm exception theo **correlation/request/trace id**; đọc `Caused by` (dùng `analyze-stacktrace` cho từng mẫu).
   - Tập trung dòng đầu tiên lặp lại nhiều request, không chase random noise.

5. **Metrics**
   - Error rate, p95/p99 latency, throughput; phân rã theo route, dependency, DB.
   - Xác định regression sau deploy hay spike traffic.

6. **Mitigation (theo runbook team)**
   - Ưu tiên hành động **đảo ngược nhanh**: tắt feature flag, scale tạm, circuit open, **rollback** version.
   - Hotfix chỉ khi rollback không khả thi hoặc rủi ro thấp hơn — có owner và plan verify.

7. **Sau khi ổn**
   - Ghi ngắn vào `notes/` hoặc doc incident (timeline, root cause giả thuyết, action) — **không PII**.
   - Action items: thêm alert, test regression, sửa runbook, ticket follow-up.

## Output

- Trạng thái dịch vụ + mitigation đã làm + giả thuyết root cause + next steps (ticket/PR).

## References

- `skills/debugging/analyze-stacktrace/SKILL.md`
- `skills/debugging/debug-backend-error/SKILL.md` (reproduce local sau khi redact)
- `skills/observability/analyze-application-logs/README.md`
- `skills/observability/implement-request-tracing/README.md`
- `rules/06-security.md`
- `skills/devops/health-check-endpoint/README.md` (Actuator health, nếu dùng)

**Last updated:** 2026-04-09
