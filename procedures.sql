USE quan_ly_cua_hang_tap_hoa;

# Procedure 1: Báo cáo top 5 khách hàng có điểm thưởng cao nhất
DELIMITER //

CREATE PROCEDURE bao_cao_diem_thuong()
BEGIN
    -- Tổng điểm thưởng
    SELECT SUM(diem_thuong) AS tong_diem_thuong
    FROM khach_hang;

    -- Top 5 khách hàng có điểm thưởng cao nhất
    SELECT ma_kh, ten_kh, diem_thuong
    FROM khach_hang
    ORDER BY diem_thuong DESC
    LIMIT 5;
END;
//

DELIMITER ;
CALL bao_cao_diem_thuong();


# Procedure 2: Tạo chương trình khuyến mãi theo điểm thưởng nếu khách hàng đạt ngưỡng điểm nhất định
DELIMITER //

CREATE PROCEDURE khuyen_mai_dac_biet()
BEGIN
    SELECT ma_kh, ten_kh, diem_thuong
    FROM khach_hang
    WHERE diem_thuong >= 100
    ORDER BY diem_thuong DESC;
END;
//

DELIMITER ;

CALL khuyen_mai_dac_biet();

# Procedure 3: Thực hiện mua hàng
DELIMITER //

CREATE PROCEDURE thuc_hien_mua_hang(
    IN p_ma_kh INT,
    IN p_ngay_mua DATE,
    IN p_chi_tiet JSON
)
BEGIN
    DECLARE p_ma_hd INT;
    DECLARE idx INT DEFAULT 0;
    DECLARE cur_item JSON;

    -- Tạo hóa đơn mới
    INSERT INTO hoa_don (ma_kh, ngay_mua, tong_tien, diem_su_dung)
    VALUES (p_ma_kh, p_ngay_mua, 0, 0);

    -- Lấy mã hóa đơn vừa tạo
    SET p_ma_hd = LAST_INSERT_ID();

    -- Duyệt qua danh sách chi tiết mua hàng
    WHILE JSON_LENGTH(p_chi_tiet) > idx DO
        SET cur_item = JSON_EXTRACT(p_chi_tiet, CONCAT('$[', idx, ']'));

        -- Thêm chi tiết hóa đơn
        INSERT INTO chi_tiet_hoa_don (ma_hd, ma_mh, so_luong, thanh_tien)
        VALUES (
            p_ma_hd,
            JSON_UNQUOTE(JSON_EXTRACT(cur_item, '$.ma_mh')),
            JSON_UNQUOTE(JSON_EXTRACT(cur_item, '$.so_luong')),
            JSON_UNQUOTE(JSON_EXTRACT(cur_item, '$.so_luong')) * JSON_UNQUOTE(JSON_EXTRACT(cur_item, '$.don_gia'))
        );

        SET idx = idx + 1;
    END WHILE;

    -- Tính tổng tiền hóa đơn
    UPDATE hoa_don
    SET tong_tien = (
        SELECT SUM(thanh_tien)
        FROM chi_tiet_hoa_don
        WHERE ma_hd = p_ma_hd
    )
    WHERE ma_hd = p_ma_hd;
END;
//

DELIMITER ;

CALL thuc_hien_mua_hang(
    1,
    '2024-12-26',
    '[{"ma_mh": 2, "so_luong": 1000, "don_gia": 9500}, {"ma_mh": 3, "so_luong": 5, "don_gia": 25000}]'
);
SELECT * FROM mat_hang;

INSERT INTO chi_tiet_hoa_don (ma_hd, ma_mh, so_luong, thanh_tien)
VALUES (101, 2, 10, 95000);


# Procedure xem lịch sử nhập hàng

DELIMITER //

CREATE PROCEDURE xem_lich_su_nhap_hang(
    IN p_ngay_bat_dau DATE,
    IN p_ngay_ket_thuc DATE
)
BEGIN
    SELECT 
        nh.ma_nhap AS MaNhap,
        nh.ngay_nhap AS NgayNhap,
        ncc.ten_ncc AS NhaCungCap,
        ncc.dia_chi AS DiaChi,
        ncc.so_dt AS SoDienThoai,
        mh.ten_mh AS TenMatHang,
        ctnh.so_luong AS SoLuongNhap,
        ctnh.don_gia_nhap AS DonGiaNhap,
        ctnh.thanh_tien AS ThanhTien
    FROM nhap_hang nh
    JOIN nha_cung_cap ncc ON nh.ma_ncc = ncc.ma_ncc
    JOIN chi_tiet_nhap_hang ctnh ON nh.ma_nhap = ctnh.ma_nhap
    JOIN mat_hang mh ON ctnh.ma_mh = mh.ma_mh
    WHERE nh.ngay_nhap BETWEEN p_ngay_bat_dau AND p_ngay_ket_thuc
    ORDER BY nh.ngay_nhap DESC;
END;
//	

DELIMITER ;

CALL xem_lich_su_nhap_hang('2024-01-01', '2024-12-31');




