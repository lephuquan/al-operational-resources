# Examples: Write Integration Test

## `@SpringBootTest` + MockMvc (khung minh họa)

```java
@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
class OrderControllerIT {

  @Autowired MockMvc mockMvc;

  @Test
  void createOrder_returns201() throws Exception {
    mockMvc.perform(post("/api/v1/orders")
            .contentType(MediaType.APPLICATION_JSON)
            .content("{\"productId\":\"550e8400-e29b-41d4-a716-446655440000\",\"quantity\":1}"))
        .andExpect(status().isCreated());
  }
}
```

Kết hợp **`@WithMockUser`** hoặc `jwt()` post-processor khi endpoint yêu cầu auth.

## `@DataJpaTest`

```java
@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
class OrderRepositoryIT {

  @Autowired OrderRepository orders;

  @Test
  void savesAndFinds() {
    var order = OrderFactory.pending(UUID.randomUUID());
    orders.save(order);
    assertThat(orders.findById(order.getId())).isPresent();
  }
}
```

`Replace.NONE` thường dùng khi Testcontainers cung cấp datasource thật — chỉnh theo team.

## Testcontainers + `@DynamicPropertySource`

```java
@Testcontainers
@SpringBootTest
class AppWithPostgresIT {

  @Container
  static PostgreSQLContainer<?> postgres = new PostgreSQLContainer<>("postgres:16-alpine");

  @DynamicPropertySource
  static void datasource(DynamicPropertyRegistry r) {
    r.add("spring.datasource.url", postgres::getJdbcUrl);
    r.add("spring.datasource.username", postgres::getUsername);
    r.add("spring.datasource.password", postgres::getPassword);
  }

  @Test
  void contextLoads() { }
}
```

Phiên bản image và module Maven/Gradle theo dự án thật.

## `@WebMvcTest` (controller slice)

```java
@WebMvcTest(OrderController.class)
class OrderControllerSliceTest {

  @Autowired MockMvc mockMvc;
  @MockBean OrderService orderService;

  @Test
  void delegatesToService() throws Exception {
    when(orderService.create(any())).thenReturn(new OrderResponse(UUID.randomUUID()));

    mockMvc.perform(post("/api/v1/orders").contentType(MediaType.APPLICATION_JSON).content("{}"))
        .andExpect(status().isCreated());
  }
}
```

**Last updated:** 2026-04-11
