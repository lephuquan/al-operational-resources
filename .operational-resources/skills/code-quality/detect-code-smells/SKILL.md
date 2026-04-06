# Skill: Detect Code Smells

## Goal

Nhận diện smell phổ biến trong Spring/Java: long method, god class, feature envy, primitive obsession.

## Steps

1. Tìm method > ~80 dòng hoặc nhiều nhánh lồng nhau.
2. Class quá nhiều dependency (vi phạm SRP).
3. Boolean/flag parameters dư thừa → tách method hoặc strategy.
4. Duplicate logic (copy-paste) → extract.
5. Trùng query trong loop → batch hoặc join fetch.
6. Đề xuất refactor từng bước + test trước khi sửa hành vi.
