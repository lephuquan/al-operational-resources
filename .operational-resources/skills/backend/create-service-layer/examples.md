# Examples: Service layer

Snippet baseline. Đổi package, tên exception, dependency theo dự án. Không hardcode secret.

## 1) Service interface + implementation

```java
public interface OrderService {

    OrderResponse create(CreateOrderCommand command);
}

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final OrderMapper orderMapper;

    @Override
    @Transactional
    public OrderResponse create(CreateOrderCommand command) {
        // invariant + domain rules...
        Order order = orderMapper.toEntity(command);
        Order saved = orderRepository.save(order);
        return orderMapper.toResponse(saved);
    }
}
```

## 2) Domain exception (gợi ý)

```java
public class InsufficientStockException extends RuntimeException {

    private final String code;

    public InsufficientStockException(String code, String message) {
        super(message);
        this.code = code;
    }

    public String getCode() {
        return code;
    }
}
```

## 3) Read-only query

```java
@Override
@Transactional(readOnly = true)
public Optional<OrderResponse> findById(Long id) {
    return orderRepository.findById(id).map(orderMapper::toResponse);
}
```

## 4) Unit test — Mockito (skeleton)

```java
@ExtendWith(MockitoExtension.class)
class OrderServiceImplTest {

    @Mock
    private OrderRepository orderRepository;

    @Mock
    private OrderMapper orderMapper;

    @InjectMocks
    private OrderServiceImpl orderService;

    @Test
    void create_persistsAndReturnsResponse() {
        // given / when / then...
    }
}
```

## 5) Port cho HTTP client (gợi ý)

```java
public interface PaymentClient {

    PaymentResult charge(ChargeRequest request);
}

@Service
@RequiredArgsConstructor
public class CheckoutService {

    private final PaymentClient paymentClient;
    // orchestrate: validate -> charge -> persist...
}
```

## Lưu ý

- Giữ service tập trung orchestration + rule; validation đầu vào có thể ở DTO/controller nhưng invariant nghiệp vụ nằm ở đây.
- Nếu cần idempotency/retry/outbox, xem `docs/architecture/08-transactions-and-consistency.md` trước khi thêm `@Transactional` quanh remote call.

**Last updated:** 2026-04-09
