USE quan_ly_cua_hang_tap_hoa;

# Trigger 1: Cập nhật điểm thưởng khi khách hàng có giao dịch
DELIMITER //
CREATE TRIGGER cap_nhat_diem_thuong
AFTER INSERT ON hoa_don
FOR EACH ROW
BEGIN
    -- Tính số điểm thưởng dựa trên tổng tiền hoá đơn
    DECLARE diem_thuong_moi INT;
    SET diem_thuong_moi = FLOOR(NEW.tong_tien / 10000);
    
    -- Cập nhật điểm thưởng cho khách hàng
    UPDATE khach_hang
    SET diem_thuong = diem_thuong + diem_thuong_moi
    WHERE ma_kh = NEW.ma_kh;
END;
//
DELIMITER ;



# Trigger 2: Sử dụng điểm thưởng để giảm giá
DELIMITER //

CREATE TRIGGER su_dung_diem_thuong
BEFORE INSERT ON hoa_don
FOR EACH ROW
BEGIN
    DECLARE diem_hien_tai INT;
    DECLARE tien_giam INT;

    -- Lấy số điểm thưởng hiện tại của khách hàng
    SELECT diem_thuong INTO diem_hien_tai
    FROM khach_hang
    WHERE ma_kh = NEW.ma_kh;

    -- Đảm bảo khách hàng không sử dụng quá số điểm họ có
    IF NEW.diem_su_dung > diem_hien_tai THEN
        SET NEW.diem_su_dung = diem_hien_tai;
    END IF;

    -- Tính số tiền giảm giá dựa trên điểm thưởng (1 điểm = 100 VNĐ)
    SET tien_giam = NEW.diem_su_dung * 100;

    -- Nếu số tiền giảm lớn hơn tổng tiền, điều chỉnh điểm sử dụng
    IF tien_giam > NEW.tong_tien THEN
        SET NEW.diem_su_dung = FLOOR(NEW.tong_tien / 100);
        SET tien_giam = NEW.diem_su_dung * 100;
    END IF;

    -- Cập nhật tổng tiền hóa đơn sau khi giảm giá
    SET NEW.tong_tien = NEW.tong_tien - tien_giam;

    -- Cập nhật điểm thưởng của khách hàng
    UPDATE khach_hang
    SET diem_thuong = diem_thuong - NEW.diem_su_dung
    WHERE ma_kh = NEW.ma_kh;
END;
//

DELIMITER ;


# Xem điểm thưởng cập nhật sau khi thêm 1 giao dịch
SELECT ma_kh, ten_kh, diem_thuong
FROM khach_hang;
INSERT INTO hoa_don (ma_kh, ngay_mua, tong_tien)
VALUES (1, '2024-12-26', 250000);


# Xem điểm sử dụng và tiền thanh toán sau khi giảm 
INSERT INTO hoa_don (ma_kh, ngay_mua, tong_tien, diem_su_dung)
VALUES (1, '2024-12-26', 200000, 30);
SELECT * 
FROM hoa_don
WHERE ma_hd = (SELECT MAX(ma_hd) FROM hoa_don);

# Xem hoá đơn khách hàng cụ thể 
SELECT * 
FROM hoa_don
WHERE ma_kh = 1
ORDER BY ngay_mua DESC;

# Triger 3: Tự động xử lý việc kiểm tra, thêm hoặc cập nhật
DELIMITER //

CREATE PROCEDURE them_hoac_cap_nhat_mat_hang(
    IN p_ten_mh VARCHAR(255),
    IN p_don_vi_tinh VARCHAR(50),
    IN p_don_gia DOUBLE,
    IN p_ngay_nhap DATE,
    IN p_so_luong INT,
    IN p_nhom_hang INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM mat_hang
        WHERE ten_mh = p_ten_mh AND nhom_hang = p_nhom_hang
    ) THEN
        -- Nếu mặt hàng đã tồn tại, cập nhật số lượng tồn kho
        UPDATE mat_hang
        SET so_luong_ton_kho = so_luong_ton_kho + p_so_luong
        WHERE ten_mh = p_ten_mh AND nhom_hang = p_nhom_hang;
    ELSE
        -- Nếu mặt hàng chưa tồn tại, thêm mới
        INSERT INTO mat_hang (ten_mh, don_vi_tinh, don_gia, ngay_nhap, so_luong_ton_kho, nhom_hang)
        VALUES (p_ten_mh, p_don_vi_tinh, p_don_gia, p_ngay_nhap, p_so_luong, p_nhom_hang);
    END IF;
END;
//

DELIMITER ;

CALL them_hoac_cap_nhat_mat_hang('Pepsi', 'Lon', 9500, '2024-06-02', 1200, 1);
SELECT * FROM mat_hang;


# Trigger 4
DELIMITER //

CREATE TRIGGER cap_nhat_ton_kho_sau_mua_hang
BEFORE INSERT ON chi_tiet_hoa_don
FOR EACH ROW
BEGIN
    DECLARE so_luong_kho INT;

    -- Lấy số lượng tồn kho hiện tại
    SELECT so_luong_ton_kho INTO so_luong_kho
    FROM mat_hang
    WHERE ma_mh = NEW.ma_mh;

    -- Kiểm tra nếu tồn kho không đủ
    IF NEW.so_luong > so_luong_kho THEN
        -- Lưu thông tin lỗi vào bảng log
        INSERT INTO log_kiem_tra (ma_mh, so_luong_dat, so_luong_ton, trang_thai, ngay_ghi)
        VALUES (NEW.ma_mh, NEW.so_luong, so_luong_kho, 'Thất bại: Không đủ hàng', NOW());

        -- Dừng thêm chi tiết hóa đơn
        SET NEW.so_luong = 0; -- Không cho phép thêm
    ELSE
        -- Trừ số lượng tồn kho nếu đủ hàng
        UPDATE mat_hang
        SET so_luong_ton_kho = so_luong_ton_kho - NEW.so_luong
        WHERE ma_mh = NEW.ma_mh;

        -- Lưu thông tin thành công vào bảng log
        INSERT INTO log_kiem_tra (ma_mh, so_luong_dat, so_luong_ton, trang_thai, ngay_ghi)
        VALUES (NEW.ma_mh, NEW.so_luong, so_luong_kho, 'Thành công', NOW());
    END IF;
END;
//

DELIMITER ;
CREATE TABLE log_kiem_tra (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ma_mh INT,
    so_luong_dat INT,
    so_luong_ton INT,
    trang_thai VARCHAR(50),
    ngay_ghi DATETIME
);
SELECT * FROM log_kiem_tra;








