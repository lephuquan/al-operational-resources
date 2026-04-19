# Examples: Refactor an toàn

Khung ghi chú và ví dụ bước nhỏ. Không thay thế test thật.

## Ghi chú trong task / MR (mẫu)

```markdown
## Refactor: extract validation from `OrderServiceImpl#placeOrder`

**Goal:** Giảm độ dài method; không đổi API public.

**Behavior preserved:**
- Same validation errors and HTTP mapping for existing integration tests X, Y.
- Same transaction boundary around `orderRepository.save`.

**Steps done:**
1. Extract `validateOrderRequest(...)` private method — tests green.
2. Extract `applyDiscount(...)` — tests green.

**Follow-up:** Consider `PricingPolicy` object (out of scope this PR).
```

## Chuỗi bước nhỏ điển hình

1. **Rename** biến/method private (IDE) — commit nhỏ.
2. **Extract method** một khối có tên nói đúng việc — test xanh.
3. **Move method** sang class phù hợp hơn (nếu SRP rõ) — cập nhật import, test xanh.
4. **Introduce parameter object** thay nhiều primitive — chỉ sau khi có test call path.

## Điều **không** nên

- Một PR: refactor + feature mới + đổi dependency.
- Refactor “im lặng” không chạy test vì “chỉ đổi tên”.
- Đổi thứ tự side effect (log, DB write, event emit) mà không kiểm chứng.

**Last updated:** 2026-04-09
