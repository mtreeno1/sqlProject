
# câu 1: Danh sách khách hàng mua hàng thuộc nhóm "Hàng điện tử" trong khoảng 01/05/2015 đến 30/05/2015
SELECT DISTINCT KH.TenKH, KH.DiaChi
FROM KhachHang KH
JOIN MuaHang MH ON KH.MaKH = MH.MaKH
JOIN MatHang MHANG ON MH.MaMH = MHANG.MaMH
JOIN NhómMặtHàng NH ON MHANG.NhomHang = NH.MaNhomMH
WHERE NH.TenNhomMH = 'Hàng điện tử'
AND MH.NgayMua BETWEEN '2015-05-01' AND '2015-05-30';

# câu 2: Tìm mặt hàng bán chạy nhất (doanh thu lớn nhất)
SELECT MH.TenMH, SUM(MHANG.SoLuong * MH.DonGia) AS DoanhThu
FROM MatHang MH
JOIN MuaHang MHANG ON MH.MaMH = MHANG.MaMH
GROUP BY MH.TenMH
ORDER BY DoanhThu DESC
LIMIT 1;

# câu 3: Đếm số lượng mặt hàng thuộc nhóm "Hàng gia dụng"
SELECT COUNT(*) AS SoLuongMatHang
FROM MatHang MH
JOIN NhómMặtHàng NH ON MH.NhomHang = NH.MaNhomMH
WHERE NH.TenNhomMH = 'Hàng gia dụng';

# câu 4:  Khách hàng có tổng giá trị mua hàng lớn nhất trong khoảng 01/01/2015 đến 25/10/2015
SELECT KH.TenKH, KH.DiaChi, KH.SoDT, SUM(MHANG.SoLuong * MH.DonGia) AS TongGiaTriMua
FROM KhachHang KH
JOIN MuaHang MHANG ON KH.MaKH = MHANG.MaKH
JOIN MatHang MH ON MHANG.MaMH = MH.MaMH
WHERE MHANG.NgayMua BETWEEN '2015-01-01' AND '2015-10-25'
GROUP BY KH.TenKH, KH.DiaChi, KH.SoDT
ORDER BY TongGiaTriMua DESC
LIMIT 1;
