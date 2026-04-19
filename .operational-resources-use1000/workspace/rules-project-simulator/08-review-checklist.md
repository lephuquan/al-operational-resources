# 08 - Code Review Checklist (Trước khi PR)

- [ ] Code tuân thủ coding standards (personal + team)
- [ ] **Java compile** sạch; không có warning “tạm” cần fix (theo policy team)
- [ ] Test pass (**unit + integration** liên quan thay đổi)
- [ ] Error handling đầy đủ; error code/mapping nhất quán
- [ ] Security: không leak secret; validate input; authz đúng layer
- [ ] Performance: tránh N+1, query không cần thiết, vòng lặp nặng
- [ ] Docs / comments cập nhật khi đổi contract hoặc hành vi
- [ ] Code dễ đọc; logic phức tạp có giải thích ngắn
- [ ] Không để **debug thừa** (`System.out`, log noisy tạm, commented-out code lớn)
