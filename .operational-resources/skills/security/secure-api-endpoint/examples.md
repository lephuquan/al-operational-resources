# Examples: Secure API Endpoint

Illustrative **Spring Security 6** style — đổi path, roles, và provider JWT theo project.

## `SecurityFilterChain` (API Bearer, CSRF off cho API)

```java
@Bean
public SecurityFilterChain apiChain(HttpSecurity http) throws Exception {
  http
      .securityMatcher("/api/**")
      .csrf(csrf -> csrf.disable())
      .sessionManagement(sm -> sm.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
      .authorizeHttpRequests(auth -> auth
          .requestMatchers("/api/v1/auth/**").permitAll()
          .requestMatchers(HttpMethod.GET, "/api/v1/public/**").permitAll()
          .anyRequest().authenticated())
      .oauth2ResourceServer(oauth2 -> oauth2.jwt(Customizer.withDefaults()));
  return http.build();
}
```

## Health public (chain riêng hoặc cùng matcher — tùy cấu trúc)

```java
@Bean
@Order(0)
public SecurityFilterChain healthChain(HttpSecurity http) throws Exception {
  http
      .securityMatcher("/actuator/health", "/actuator/health/**")
      .authorizeHttpRequests(auth -> auth.anyRequest().permitAll())
      .csrf(csrf -> csrf.disable());
  return http.build();
}
```

## Method security

```java
@PreAuthorize("hasRole('ADMIN')")
@DeleteMapping("/api/v1/admin/users/{id}")
public void deleteUser(@PathVariable UUID id) { /* ... */ }
```

Kích hoạt: `@EnableMethodSecurity` trên cấu hình hoặc application class.

## Gợi ý test (MockMvc)

- Gọi endpoint bảo vệ **không** header → expect **401** (hoặc **403** nếu team map vậy).
- Gọi có JWT mock **thiếu** role → **403**.

**Last updated:** 2026-04-11
