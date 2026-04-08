# API Deprecation Policy

## Muc dich

Thong nhat cach thong bao va dong endpoint/phien ban cu de client co thoi gian migration.

## Policy

- Moi API deprecate phai co thong bao toi thieu 90 ngay (hoac theo team policy).
- Neu co breaking change lon, uu tien ra version moi (`/api/v3/...`) thay vi sua ngat trong v2.
- Endpoint deprecate can ghi ro trong changelog va `10-current-api-changes.md`.

## Communication checklist

- [ ] Ghi deprecation notice trong docs
- [ ] Danh dau endpoint affected
- [ ] Cung cap migration guide ngan
- [ ] Chot ngay end-of-support
