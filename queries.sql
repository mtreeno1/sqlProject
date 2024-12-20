USE quan_ly_cua_hang_tap_hoa;
# câu 1: Danh sách khách hàng mua mặt hàng thuộc nhóm "Đồ uống" trong khoảng 01/06/2024 - 15/06/2024
SELECT DISTINCT KH.ten_kh, KH.dia_chi
FROM khach_hang KH
JOIN hoa_don HD ON KH.ma_kh = HD.ma_kh
JOIN chi_tiet_hoa_don CTHD ON HD.ma_hd = CTHD.ma_hd
JOIN mat_hang MH ON CTHD.ma_mh = MH.ma_mh
JOIN nhom_mat_hang NH ON MH.nhom_hang = NH.ma_nhom_mh
WHERE NH.ten_nhom_mh = 'Đồ uống'
  AND HD.ngay_mua BETWEEN '2024-06-01' AND '2024-06-15';

# câu 2: Tìm mặt hàng bán chạy nhất (doanh thu lớn nhất)
SELECT MH.ten_mh, SUM(CTHD.thanh_tien) AS doanh_thu
FROM chi_tiet_hoa_don CTHD
JOIN mat_hang MH ON CTHD.ma_mh = MH.ma_mh
GROUP BY MH.ten_mh
ORDER BY doanh_thu DESC
LIMIT 1;


# câu 3:  Đếm số lượng mặt hàng thuộc nhóm "Gia vị"
SELECT COUNT(*) AS so_luong_mat_hang
FROM mat_hang MH
JOIN nhom_mat_hang NH ON MH.nhom_hang = NH.ma_nhom_mh
WHERE NH.ten_nhom_mh = 'Gia vị';
# câu 4:  Khách hàng có tổng giá trị mua hàng lớn nhất từ 01/06/2024 đến 15/06/2024
SELECT KH.ten_kh, KH.dia_chi, KH.so_dt, SUM(HD.tong_tien) AS tong_gia_tri
FROM khach_hang KH
JOIN hoa_don HD ON KH.ma_kh = HD.ma_kh
WHERE HD.ngay_mua BETWEEN '2024-06-01' AND '2024-06-15'
GROUP BY KH.ten_kh, KH.dia_chi, KH.so_dt
ORDER BY tong_gia_tri DESC
LIMIT 1;
