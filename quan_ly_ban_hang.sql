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


