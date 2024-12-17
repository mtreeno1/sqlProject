-- Dữ liệu cho bảng NhómMặtHàng
INSERT INTO NhómMặtHàng (TenNhomMH) VALUES 
('Hàng điện tử'),
('Hàng gia dụng'),
('Hàng thực phẩm'),
('Hàng văn phòng phẩm');

-- Dữ liệu cho bảng MặtHàng
INSERT INTO MatHang (TenMH, DonViTinh, DonGia, NgayNhap, NhomHang, SoLuongTonKho) VALUES
('Tivi Samsung 55 Inch', 'Cái', 15000000, '2024-06-01', 1, 20),
('Nồi cơm điện Sharp', 'Cái', 1200000, '2024-06-02', 2, 50),
('Bánh quy Cosy', 'Hộp', 50000, '2024-06-03', 3, 100),
('Giấy A4 Double A', 'Ram', 70000, '2024-06-04', 4, 200);

-- Dữ liệu cho bảng KháchHàng
INSERT INTO KhachHang (TenKH, DiaChi, SoDT, DiemThuong) VALUES
('Nguyễn Văn A', 'Hà Nội', '0987654321', 100),
('Trần Thị B', 'Hải Phòng', '0912345678', 200),
('Phạm Minh C', 'TP.HCM', '0901234567', 150);

-- Dữ liệu cho bảng MuaHàng
INSERT INTO MuaHang (MaMH, MaKH, NgayMua, SoLuong) VALUES
(1, 1, '2024-06-05', 2),
(2, 2, '2024-06-06', 1),
(3, 3, '2024-06-07', 10),
(4, 1, '2024-06-08', 5);
