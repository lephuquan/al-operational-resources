# Examples: Unit Test

```java
@ExtendWith(MockitoExtension.class)
class OrderServiceTest {

    @Mock OrderRepository orderRepository;
    @InjectMocks OrderService orderService;

    @Test
    void create_shouldPersist_whenValid() {
        when(orderRepository.save(any())).thenAnswer(i -> i.getArgument(0));
        var result = orderService.create(new CreateOrderCommand(List.of()));
        assertThat(result).isNotNull();
    }
}
```
