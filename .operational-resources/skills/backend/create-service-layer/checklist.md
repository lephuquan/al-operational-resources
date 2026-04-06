# Checklist: Create Service Layer

- [ ] Một method = một use case rõ (tránh “god service”)
- [ ] Transaction boundary rõ (ghi nhiều bảng trong một `@Transactional` khi cần)
- [ ] Exception nghiệp vụ có loại/mã ổn định
- [ ] Không lộ chi tiết DB/exception ra ngoài không kiểm soát
- [ ] Unit test với Mockito cho dependency
- [ ] Logging: INFO cho milestone, DEBUG cho chi tiết (không log secret)
