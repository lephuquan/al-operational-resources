# Examples: Create REST API

Snippet dùng làm baseline. Thay package, envelope, path theo convention dự án. Không dán secret/token thật.

## 1) Controller — tạo resource (POST)

```java
@RestController
@RequestMapping("/api/v2/orders")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    @PostMapping
    public ResponseEntity<ApiResponse<OrderResponse>> create(
            @Valid @RequestBody CreateOrderRequest request) {
        OrderResponse response = orderService.create(request);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.ok(response));
    }
}
```

## 2) Request DTO — validation

```java
public record CreateOrderRequest(
        @NotNull @Size(min = 1) List<OrderLineRequest> lines,
        @NotBlank String customerId
) {}
```

## 3) GET theo id (gợi ý)

```java
@GetMapping("/{id}")
public ResponseEntity<ApiResponse<OrderResponse>> getById(@PathVariable Long id) {
    return orderService.findById(id)
            .map(o -> ResponseEntity.ok(ApiResponse.ok(o)))
            .orElseGet(() -> ResponseEntity.notFound().build());
}
```

## 4) JSON success (201)

```json
{
  "success": true,
  "data": {
    "id": "ord_20260409_001",
    "status": "CREATED",
    "createdAt": "2026-04-09T10:30:00Z"
  }
}
```

## 5) JSON validation error (400)

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Request validation failed",
    "details": [
      {
        "field": "lines",
        "message": "size must be between 1 and 2147483647"
      }
    ]
  }
}
```

## 6) WebMvcTest — skeleton

```java
@WebMvcTest(OrderController.class)
class OrderControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private OrderService orderService;

    @Test
    void create_returnsCreated() throws Exception {
        // arrange service mock...
        // perform POST /api/v2/orders...
        // assert 201 + response envelope...
    }
}
```

## 7) cURL — smoke test local

```bash
curl -X POST "http://localhost:8080/api/v2/orders" \
  -H "Content-Type: application/json" \
  -d '{
    "customerId": "cus_001",
    "lines": [{"productId": "p01", "quantity": 2}]
  }'
```

## Lưu ý

- Controller mỏng: mapping + `@Valid` + gọi service + build response.
- Map lỗi domain → HTTP tập trung trong `@ControllerAdvice`; chỉnh `ApiResponse` / mã lỗi theo contract thật của dự án.

**Last updated:** 2026-04-09
