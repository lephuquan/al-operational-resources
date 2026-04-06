# Examples: Create REST API

## Controller snippet

```java
@RestController
@RequestMapping("/api/v2/orders")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;

    @PostMapping
    public ResponseEntity<ApiResponse<OrderResponse>> create(
            @Valid @RequestBody CreateOrderRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.ok(orderService.create(request)));
    }
}
```

## Request DTO

```java
public record CreateOrderRequest(
        @NotNull @Size(min = 1) List<OrderLineRequest> lines
) {}
```

Điều chỉnh `ApiResponse` theo envelope thực tế của dự án.
