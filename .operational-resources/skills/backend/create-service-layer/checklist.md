# Checklist: Create Service Layer

Dùng trước khi merge slice service. Bỏ qua mục không áp dụng.

## Thiết kế use case

- [ ] Một method / nhóm nhỏ = một use case rõ (tránh god service)
- [ ] Input/output và invariant đã chốt (hoặc ghi assumption trong task)

## Transaction

- [ ] `@Transactional` đúng chỗ: ghi nhiều bước cùng rollback khi cần
- [ ] Query thuần dùng `readOnly = true` khi phù hợp
- [ ] Không giữ transaction mở trong lúc chờ remote call lâu (trừ khi đã thiết kế cụ thể)

## Phụ thuộc

- [ ] Constructor injection; không field `@Autowired` nếu team cấm
- [ ] HTTP/integration tách `*Client` hoặc port khi cần test/substitute

## Lỗi & contract

- [ ] Exception nghiệp vụ có loại/mã ổn định (nếu team chuẩn hóa)
- [ ] Không leak SQLException/chi tiết DB ra ngoài không kiểm soát
- [ ] ControllerAdvice có thể map exception này sang HTTP đúng policy

## Logging & bảo mật

- [ ] Không log secret/token/PII nhạy cảm
- [ ] Mức log hợp lý (INFO milestone, DEBUG chi tiết)

## Test

- [ ] Unit test mock repository/client; có happy path + ít nhất một nhánh lỗi nghiệp vụ
- [ ] Nếu logic phụ thuộc DB: có IT hoặc ghi rõ lý do chưa có

**Last updated:** 2026-04-09
