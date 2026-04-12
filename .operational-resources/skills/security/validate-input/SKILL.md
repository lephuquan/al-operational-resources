# Skill: Validate Input

## Goal

Validate input ở boundary: Bean Validation + custom validator khi cần.

## Steps

1. DTO request: annotation `@NotNull`, `@Size`, `@Email`, `@Pattern`.
2. ` @Valid` trên `@RequestBody` và `@PathVariable`/`@RequestParam` nếu dùng wrapper.
3. Custom `@Constraint` cho rule phức tạp (cross-field).
4. Không tin client: validate lại business rule trong service.
5. Không leak chi tiết validation nội bộ ra ngoài (message an toàn).

## References

- `skills/security/secure-api-endpoint/README.md` (boundary + hardening cùng security config)
