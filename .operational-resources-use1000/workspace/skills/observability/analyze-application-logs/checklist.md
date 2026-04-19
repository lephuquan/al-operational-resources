# Checklist: Analyze Application Logs

Dùng trước khi báo cáo incident hoặc kết luận RCA chủ yếu từ log.

## Scope

- [ ] Khung **thời gian** và **môi trường** đúng (prod/stage); timezone rõ (UTC khuyến nghị).
- [ ] Đã lọc **service / version / pod** phù hợp — không trộn nhiễu không liên quan.

## Method

- [ ] Đã xem **ERROR** (và **WARN** khi cần); có **số lượng** hoặc tỷ lệ tương đối pattern chính.
- [ ] Nếu có **correlation/trace id**, đã trace đủ một vài request mẫu end-to-end.

## Correlation với hệ thống

- [ ] Đã so với **deploy / flag / scale** hoặc traffic; loại trừ giả thuyết rõ ràng khi có bằng chứng.

## Security

- [ ] Ticket / chat công khai **không** chứa secret, token, đủ PII; đã redact hoặc thay bằng id.

## Limits

- [ ] Ghi rõ chỗ log **không đủ** (cần trace, metric, DB) — handoff tới playbook debug prod nếu cần.

**Last updated:** 2026-04-11
