# DT015 — Quicksort và lần vết phân hoạch

Đồ án môn học Cấu trúc dữ liệu và Giải thuật (INT13185 - Nhóm 03)  
Học viện Công nghệ Bưu chính Viễn thông - Cơ sở tại TP. Hồ Chí Minh.

---

## 1. Thông tin sinh viên và căn cứ đề tài

- **Họ và tên:** Nguyễn Tiến Đạt
- **MSSV:** N24DCDT011
- **Lớp:** D24CQDT01-N
- **Mã đề tài:** DT015
- **Tên đề tài:** Quicksort và lần vết phân hoạch
- **Giảng viên hướng dẫn:** ThS. Hồ Nhựt Minh
- **Tài liệu căn cứ:** *Giáo trình Cấu trúc dữ liệu và Giải thuật (INT1306)*
  - Chương 2, Mục 2.3.1–2.3.5;
  - Bảng 2.6–2.7;
  - Mục 2.8 bài tập 12;
  - Trang in 41–45, 61 (Trang PDF 53–57, 73).
- **Môi trường thực thi:** Julia 1.12.7 trên hệ điều hành Windows.

---

## 2. Đặc tả dữ liệu vào / ra (Hợp đồng Input / Output)

- **Input:** Mảng một chiều chứa các số nguyên (`Vector{Int}`), kích thước $0 \le n \le 10000$.
- **Quy ước chỉ số:** Chỉ số mảng 1-based (bắt đầu từ 1 đến $n$).
- **Chọn chốt (Pivot):** Lấy giá trị ở giữa đoạn: `chot = a[(l + r) ÷ 2]`.
- **Output:**
  - Mảng đã sắp xếp theo thứ tự tăng dần.
  - Lần vết chi tiết (trace) qua từng bước phân hoạch: giá trị chốt, vị trí con trỏ $i, j$, các lần đổi chỗ (swap).
  - Thống kê: Tổng số phép so sánh, tổng số lần đổi chỗ, chiều sâu ngăn xếp đệ quy lớn nhất.
- **Xử lý ngoại lệ:** Kiểm tra mảng đầu vào qua hàm `kiem_tra_dau_vao(a)`. Ném ngoại lệ `ArgumentError` nếu mảng chứa phần tử không phải số nguyên hoặc kích thước vượt quá 10000 phần tử.

---

## 3. Cấu trúc thư mục mã nguồn

```
Khung_ma_nguon_ca_nhan/
├── src/
│   └── DeTai.jl              # Module chứa toàn bộ thuật toán Quicksort, phân hoạch và thống kê
├── test/
│   └── runtests.jl           # Bộ kiểm thử tự động gồm 14 ca kiểm thử độc lập (A01 - A14)
├── scripts/
│   └── khao_sat_quy_mo.jl    # Kịch bản đo lường hiệu năng trên 4 quy mô n = 8, 50, 500, 5000
├── docs/
│   └── anh_ket_qua/          # Thư mục lưu 11 ảnh minh chứng chụp màn hình kết quả chạy
├── demo.jl                   # Chương trình chạy minh họa Ví dụ 1, Ví dụ 2 và 5 ca kiểm thử bắt buộc
├── README.md                 # Tài liệu hướng dẫn sử dụng và kiểm tra
└── .gitignore
```

---

## 4. Hướng dẫn chạy chương trình và kiểm thử

Mở PowerShell / Terminal tại thư mục này và chạy các lệnh sau:

### 4.1. Kiểm tra phiên bản Julia
```powershell
julia --version
```

### 4.2. Chạy chương trình minh họa (Demo)
```powershell
julia --startup-file=no demo.jl
```
Lệnh này sẽ tự động:
- Chạy và in vết chi tiết Ví dụ 1 (`a = [6, 1, 7, 5, 3, 8, 2, 4]`).
- Chạy và in vết Ví dụ 2 (`a = [2, 2, 1]`).
- Chạy toàn bộ 5 ca kiểm thử mẫu của phiếu giao đề tài.

### 4.3. Chạy bộ kiểm thử tự động (Unit Tests)
```powershell
julia --startup-file=no test/runtests.jl
```
**Kết quả thực tế:** 14 ca kiểm thử độc lập với tổng cộng 40 phép kiểm tra (assertions), đạt **40/40 PASS (100%)**.

### 4.4. Chạy khảo sát hiệu năng theo quy mô (Scales)
```powershell
julia --startup-file=no scripts/khao_sat_quy_mo.jl
```
Đo đạc thời gian chạy (ms), số phép so sánh, số lần đổi chỗ, độ sâu đệ quy trên 4 loại mảng (Ngẫu nhiên, Tăng dần, Giảm dần, Toàn trùng) tại các kích thước $n = 8, 50, 500, 5000$.

---

## 5. Quy trình đẩy lên GitHub và kiểm tra bản clone

1. Khởi tạo Git và commit:
```powershell
git init
git add README.md .gitignore src demo.jl test scripts docs
git commit -m "N24DCDT011 - Hoan thanh ma nguon va bo test de tai DT015"
git branch -M main
git remote add origin https://github.com/<TEN_GITHUB>/<TEN_REPO>.git
git push -u origin main
git rev-parse HEAD
```

2. Kiểm tra bản clone ngoại tuyến:
```powershell
git clone https://github.com/<TEN_GITHUB>/<TEN_REPO>.git kiem_tra_clone
cd kiem_tra_clone
git rev-parse HEAD
julia --startup-file=no demo.jl
julia --startup-file=no test/runtests.jl
```

---

## 6. Danh sách 4 tệp nộp bài lên Google Classroom

1. `N24DCDT011_DT015_NguyenTienDat_BaoCao.docx`
2. `N24DCDT011_DT015_NguyenTienDat_BaoCao.pdf`
3. `N24DCDT011_DT015_NguyenTienDat_MaNguon.zip`
4. `N24DCDT011_DT015_NguyenTienDat_ThongTinNop.txt`
