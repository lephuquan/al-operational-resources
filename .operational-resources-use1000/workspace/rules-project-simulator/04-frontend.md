# 04 - Frontend Guidelines (Nếu có frontend)

**Repo hiện tại**: chủ yếu Spring Boot — không bắt buộc áp dụng block dưới đây cho đến khi có frontend trong monorepo hoặc app riêng.

Khi stack là **Next.js** (hoặc tương tự), tham khảo:

- Ưu tiên **Server Components** mặc định (Next.js App Router).
- **Client Components** chỉ khi cần tương tác (state, browser API).
- Server state: **TanStack Query** (hoặc tương đương); client UI state: **Zustand** (hoặc team chọn).
- Component nhỏ, tái sử dụng; JSDoc/TSDoc khi API component không tầm thường.
- Styling: **Tailwind** + utility `cn` / `clsx` nếu team dùng.
- **Accessibility**: `aria-*`, label rõ ràng khi cần.
