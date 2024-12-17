-- Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS QuanLyCuaHangTapHoa;
USE QuanLyCuaHangTapHoa;

-- Tạo bảng NhómMặtHàng
CREATE TABLE NhómMặtHàng (
    MaNhomMH INT PRIMARY KEY AUTO_INCREMENT,
    TenNhomMH VARCHAR(255) NOT NULL
);

-- Tạo bảng MặtHàng
CREATE TABLE MatHang (
    MaMH INT PRIMARY KEY AUTO_INCREMENT,
    TenMH VARCHAR(255) NOT NULL,
    DonViTinh VARCHAR(50),
    DonGia DOUBLE NOT NULL,
    NgayNhap DATE,
    NhomHang INT,
    SoLuongTonKho INT DEFAULT 0,
    FOREIGN KEY (NhomHang) REFERENCES NhómMặtHàng(MaNhomMH)
);

-- Tạo bảng KháchHàng
CREATE TABLE KhachHang (
    MaKH INT PRIMARY KEY AUTO_INCREMENT,
    TenKH VARCHAR(255) NOT NULL,
    DiaChi VARCHAR(255),
    SoDT VARCHAR(15),
    DiemThuong INT DEFAULT 0
);

-- Tạo bảng MuaHàng
CREATE TABLE MuaHang (
    MaMH INT,
    MaKH INT,
    NgayMua DATE NOT NULL,
    SoLuong INT NOT NULL,
    PRIMARY KEY (MaMH, MaKH, NgayMua),
    FOREIGN KEY (MaMH) REFERENCES MatHang(MaMH),
    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
);
