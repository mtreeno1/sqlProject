# CREATE DATABASE IF NOT EXISTS quan_ly_cua_hang_tap_hoa;
USE quan_ly_cua_hang_tap_hoa;
CREATE TABLE nhom_mat_hang (
    ma_nhom_mh INT PRIMARY KEY AUTO_INCREMENT,
    ten_nhom_mh VARCHAR(255) NOT NULL
);
CREATE TABLE mat_hang (
    ma_mh INT PRIMARY KEY AUTO_INCREMENT,
    ten_mh VARCHAR(255) NOT NULL,
    don_vi_tinh VARCHAR(50),
    don_gia DOUBLE NOT NULL,
    ngay_nhap DATE,
    so_luong_ton_kho INT DEFAULT 0,
    nhom_hang INT,
    FOREIGN KEY (nhom_hang) REFERENCES nhom_mat_hang(ma_nhom_mh)
);
CREATE TABLE khach_hang (
    ma_kh INT PRIMARY KEY AUTO_INCREMENT,
    ten_kh VARCHAR(255) NOT NULL,
    dia_chi VARCHAR(255),
    so_dt VARCHAR(15),
    diem_thuong INT DEFAULT 0
);
CREATE TABLE nha_cung_cap (
    ma_ncc INT PRIMARY KEY AUTO_INCREMENT,
    ten_ncc VARCHAR(255) NOT NULL,
    dia_chi VARCHAR(255),
    so_dt VARCHAR(15)
);
CREATE TABLE hoa_don (
    ma_hd INT PRIMARY KEY AUTO_INCREMENT,
    ma_kh INT,
    ngay_mua DATE NOT NULL,
    tong_tien DOUBLE DEFAULT 0,
    FOREIGN KEY (ma_kh) REFERENCES khach_hang(ma_kh)
);
CREATE TABLE chi_tiet_hoa_don (
    ma_hd INT,
    ma_mh INT,
    so_luong INT NOT NULL,
    thanh_tien DOUBLE NOT NULL,
    PRIMARY KEY (ma_hd, ma_mh),
    FOREIGN KEY (ma_hd) REFERENCES hoa_don(ma_hd),
    FOREIGN KEY (ma_mh) REFERENCES mat_hang(ma_mh)
);
CREATE TABLE nhap_hang (
    ma_nhap INT PRIMARY KEY AUTO_INCREMENT,
    ma_ncc INT,
    ngay_nhap DATE NOT NULL,
    tong_tien DOUBLE DEFAULT 0,
    FOREIGN KEY (ma_ncc) REFERENCES nha_cung_cap(ma_ncc)
);
CREATE TABLE chi_tiet_nhap_hang (
    ma_nhap INT,
    ma_mh INT,
    so_luong INT NOT NULL,
    don_gia_nhap DOUBLE NOT NULL,
    thanh_tien DOUBLE NOT NULL,
    PRIMARY KEY (ma_nhap, ma_mh),
    FOREIGN KEY (ma_nhap) REFERENCES nhap_hang(ma_nhap),
    FOREIGN KEY (ma_mh) REFERENCES mat_hang(ma_mh)
);
ALTER TABLE hoa_don
ADD COLUMN diem_su_dung INT DEFAULT 0;

ALTER TABLE mat_hang
ADD CONSTRAINT unique_ten_mh_nhom_hang UNIQUE (ten_mh, nhom_hang);

-- Tạo bảng tạm để lưu thông tin tổng hợp
CREATE TEMPORARY TABLE temp_mat_hang AS
SELECT ten_mh, nhom_hang, MIN(ma_mh) AS min_ma_mh, SUM(so_luong_ton_kho) AS total_so_luong
FROM mat_hang
GROUP BY ten_mh, nhom_hang;

-- Cập nhật số lượng tồn kho trong bảng chính dựa trên bảng tạm
UPDATE mat_hang m1
JOIN temp_mat_hang t
ON m1.ma_mh = t.min_ma_mh
SET m1.so_luong_ton_kho = t.total_so_luong;
SET SQL_SAFE_UPDATES = 0;

-- Xóa các hàng trùng lặp (không phải hàng có mã nhỏ nhất)
DELETE m1
FROM mat_hang m1
LEFT JOIN temp_mat_hang t
ON m1.ma_mh = t.min_ma_mh
WHERE t.min_ma_mh IS NULL;

SELECT * FROM mat_hang;


