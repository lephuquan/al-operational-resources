# Skill: Create Service Layer

## Goal

Triển khai lớp service (use case): business logic rõ ràng, transaction đúng chỗ, dễ unit test.

## Steps

1. Xác định use case: input/output, invariant, lỗi nghiệp vụ (exception có mã).
2. Định nghĩa interface service nếu team tách interface; không bắt buộc với module nhỏ.
3. Inject repository / client qua constructor; tránh field `@Autowired` nếu team chuẩn constructor injection.
4. Đặt `@Transactional` trên method cần ghi nhiều bước; read-only cho query thuần (`readOnly = true`).
5. Không gọi HTTP từ service trừ khi đó là “adapter”; cân nhắc tách `*Client` riêng.
6. Unit test: mock repository/client, kiểm tra nhánh lỗi và happy path.

## Output

- `*Service` (và test) + exception domain khi cần.

## References

- `docs/knowledge-base/coding-patterns.md`
