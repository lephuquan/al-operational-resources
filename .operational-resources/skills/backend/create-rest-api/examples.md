# Examples: Create REST API

Use these snippets as a baseline. Replace package names and envelope fields with your project conventions.

## 1) Controller (create endpoint)

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

## 2) Request DTO with validation

```java
public record CreateOrderRequest(
        @NotNull @Size(min = 1) List<OrderLineRequest> lines,
        @NotBlank String customerId
) {}
```

## 3) Example success payload (201)

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

## 4) Example validation error payload (400)

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

## 5) WebMvcTest skeleton

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

## 6) cURL quick check

```bash
curl -X POST "http://localhost:8080/api/v2/orders" \
  -H "Content-Type: application/json" \
  -d '{
    "customerId": "cus_001",
    "lines": [{"productId": "p01", "quantity": 2}]
  }'
```

Notes:
- Keep controller thin (mapping + validation + service call only).
- Centralize domain-to-HTTP error mapping in `@ControllerAdvice`.
- Adapt `ApiResponse` and error codes to your real project contract.
