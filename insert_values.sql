INSERT INTO nhom_mat_hang (ten_nhom_mh) 
VALUES 
('Đồ uống'),
('Bánh kẹo'),
('Gia vị'),
('Hóa mỹ phẩm'),
('Đồ hộp'),
('Đồ gia dụng'),
('Đồ đông lạnh'),
('Sữa và chế phẩm'),
('Đồ khô'),
('Rau củ quả'),
('Thịt cá tươi sống'),
('Thức ăn nhanh'),
('Gia cầm trứng'),
('Đồ dùng học tập'),
('Thức ăn cho thú cưng');

SELECT * from mat_hang where nhom_hang = 1;

INSERT INTO mat_hang (ten_mh, don_vi_tinh, don_gia, ngay_nhap, so_luong_ton_kho, nhom_hang) 
VALUES 
('Coca-Cola', 'Lon', 10000, '2024-06-01', 100, 1),
('Pepsi', 'Lon', 9500, '2024-06-02', 120, 1),
('Bánh Oreo', 'Hộp', 25000, '2024-06-02', 150, 2),
('Muối i-ốt', 'Gói', 5000, '2024-06-02', 200, 3),
('Dầu ăn Simply', 'Chai', 45000, '2024-06-03', 80, 3),
('Xà phòng Lifebuoy', 'Bánh', 12000, '2024-06-04', 90, 4),
('Mì tôm Hảo Hảo', 'Thùng', 96000, '2024-06-05', 60, 5),
('Sữa Vinamilk', 'Hộp', 12000, '2024-06-05', 150, 8),
('Bột giặt Omo', 'Gói', 35000, '2024-06-06', 75, 4),
('Cá basa tươi', 'Kg', 75000, '2024-06-06', 50, 11),
('Thịt gà ta', 'Kg', 120000, '2024-06-07', 60, 11),
('Rau cải xanh', 'Kg', 15000, '2024-06-07', 100, 10),
('Bánh Chocopie', 'Hộp', 35000, '2024-06-07', 85, 2),
('Sữa đặc Ông Thọ', 'Lon', 20000, '2024-06-08', 90, 8),
('Cà phê G7', 'Hộp', 55000, '2024-06-08', 70, 1);

INSERT INTO mat_hang (ten_mh, don_vi_tinh, don_gia, ngay_nhap, so_luong_ton_kho, nhom_hang) 
VALUES ('Pepsi', 'Lon', 9500, '2024-06-02', 1200, 1);
SELECT * FROM mat_hang;

INSERT INTO khach_hang (ten_kh, dia_chi, so_dt, diem_thuong) 
VALUES 
('Nguyen Van A', '123 Đường ABC, TP.HCM', '0123456789', 10),
('Tran Thi B', '456 Đường XYZ, Hà Nội', '0987654321', 20),
('Le Van C', '789 Đường LMN, Đà Nẵng', '0345678901', 15),
('Pham Van D', '321 Đường UVW, Hải Phòng', '0765432198', 25),
('Hoang Thi E', '654 Đường DEF, Cần Thơ', '0981122334', 30),
('Bui Van F', '987 Đường GHI, Bình Dương', '0356789123', 40),
('Nguyen Thi G', '741 Đường JKL, Nha Trang', '0777899102', 10),
('Vu Thi H', '852 Đường MNO, Vũng Tàu', '0888999222', 35),
('Tran Van I', '963 Đường PQR, Đà Lạt', '0912233445', 20),
('Phan Thi K', '159 Đường STU, Huế', '0345566778', 50),
('Nguyen Van L', '753 Đường VWX, Buôn Ma Thuột', '0707070707', 45),
('Dang Thi M', '369 Đường YZ, Quảng Ninh', '0901234567', 15),
('Ho Van N', '951 Đường ABC, Biên Hòa', '0987001122', 25),
('Tran Thi O', '147 Đường DEF, Long An', '0978003344', 35),
('Ngo Van P', '258 Đường GHI, Tây Ninh', '0944005566', 10);










INSERT INTO nha_cung_cap (ten_ncc, dia_chi, so_dt) 
VALUES 
('Công ty TNHH ABC', 'KCN Bình Dương', '0274123456'),
('Công ty CP XYZ', 'KCN Long An', '0274234567'),
('Công ty TNHH Thực Phẩm', 'KCN Đồng Nai', '0251357890'),
('Nhà phân phối Minh Phát', 'TP.HCM', '0281234567'),
('Công ty Gia Vị Việt', 'Hà Nội', '0249876543'),
('Công ty TNHH Sữa Việt Nam', 'TP.HCM', '0285678901'),
('Công ty Bánh Kẹo Bình An', 'Đà Nẵng', '0236781234'),
('Nhà cung cấp Fresh Food', 'Cần Thơ', '0291234987'),
('Công ty Xuất Nhập Khẩu Nam Định', 'Nam Định', '0228123456'),
('Nhà phân phối Green Market', 'Hải Phòng', '0225781234'),
('Công ty Hóa Mỹ Phẩm An Khang', 'Bình Dương', '0271234789'),
('Công ty Nông Sản Việt', 'Đồng Tháp', '0675432198'),
('Công ty Bánh Kẹo SweetHome', 'Nha Trang', '0258123456'),
('Công ty TNHH Thức Ăn Chăn Nuôi', 'Long An', '0278123456'),
('Công ty Thủy Hải Sản Thanh Long', 'Quảng Ninh', '0203123987');










INSERT INTO nhap_hang (ma_ncc, ngay_nhap, tong_tien) 
VALUES 
(1, '2024-06-01', 1000000),
(2, '2024-06-02', 2000000),
(3, '2024-06-03', 1500000),
(4, '2024-06-04', 800000),
(5, '2024-06-05', 1200000),
(6, '2024-06-06', 950000),
(7, '2024-06-07', 1100000),
(8, '2024-06-08', 1300000),
(9, '2024-06-09', 1700000),
(10, '2024-06-10', 900000),
(11, '2024-06-11', 750000),
(12, '2024-06-12', 680000),
(13, '2024-06-13', 990000),
(14, '2024-06-14', 1200000),
(15, '2024-06-15', 2100000);










INSERT INTO hoa_don (ma_kh, ngay_mua, tong_tien)
VALUES
(1, '2024-06-10', 300000),
(2, '2024-06-11', 450000),
(3, '2024-06-12', 120000),
(4, '2024-06-13', 600000),
(5, '2024-06-14', 750000),
(6, '2024-06-15', 200000),
(7, '2024-06-16', 900000),
(8, '2024-06-17', 150000),
(9, '2024-06-18', 320000),
(10, '2024-06-19', 700000),
(11, '2024-06-20', 800000),
(12, '2024-06-21', 1000000),
(13, '2024-06-22', 110000),
(14, '2024-06-23', 500000),
(15, '2024-06-24', 650000);











INSERT INTO chi_tiet_hoa_don (ma_hd, ma_mh, so_luong, thanh_tien)
VALUES
(1, 1, 10, 100000),
(1, 2, 5, 47500),
(2, 3, 4, 100000),
(2, 4, 10, 50000),
(3, 5, 2, 90000),
(4, 6, 8, 96000),
(4, 7, 2, 192000),
(5, 8, 5, 60000),
(6, 9, 3, 105000),
(7, 10, 10, 750000),
(8, 11, 1, 120000),
(9, 12, 3, 45000),
(10, 13, 4, 140000),
(11, 14, 5, 100000),
(12, 15, 2, 110000);










INSERT INTO chi_tiet_nhap_hang (ma_nhap, ma_mh, so_luong, don_gia_nhap, thanh_tien)
VALUES
(1, 1, 100, 9000, 900000),
(1, 2, 50, 8700, 435000),
(2, 3, 150, 22000, 3300000),
(2, 4, 200, 4500, 900000),
(3, 5, 80, 40000, 3200000),
(3, 6, 90, 10000, 900000),
(4, 7, 60, 90000, 5400000),
(4, 8, 150, 10000, 1500000),
(5, 9, 75, 30000, 2250000),
(6, 10, 50, 70000, 3500000),
(7, 11, 60, 110000, 6600000),
(8, 12, 100, 14000, 1400000),
(9, 13, 85, 33000, 2805000),
(10, 14, 90, 18000, 1620000),
(11, 15, 70, 50000, 3500000);

SELECT * FROM mat_hang;