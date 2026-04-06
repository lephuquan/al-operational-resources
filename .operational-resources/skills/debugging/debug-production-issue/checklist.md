# Checklist: Production Issue

- [ ] Xác định impact (user, revenue, SLA)
- [ ] Xác định scope (single pod vs toàn hệ thống)
- [ ] Thu thập log + trace id mẫu
- [ ] Kiểm tra deploy mới nhất (diff config)
- [ ] Mitigation: rollback / hotfix / scale — có owner approval
- [ ] Sau khi ổn: action items (test, alert, monitoring)
