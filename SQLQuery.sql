--01.Lấy ra tất cả nhân viên của cơ sở “CS001”

SELECT MaNV AS 'Mã nhân viên', MaCS AS 'Mã cơ sở', HoTen AS 'Họ Tên', NgaySinh AS 'Ngày sinh', SĐT,ChucVu AS 'Chức vụ', TrinhDo AS 'Trình độ', Luong AS 'Lương' 
FROM NhanVien
WHERE MaCS = 'CS0001'

--02.Lấy ra tất cả giảng viên đang công tác tại cơ sở “CS001”, lương trên 10tr.

SELECT MaNV AS 'Mã nhân viên', MaCS AS 'Mã cơ sở', HoTen AS 'Họ Tên', NgaySinh AS 'Ngày sinh', SĐT,ChucVu AS 'Chức vụ', TrinhDo AS 'Trình độ', Luong AS 'Lương' 
FROM NhanVien
WHERE MaCS = 'CS0001' AND Luong > 10000000 AND ChucVu = N'Giáo viên'

--03. Lấy ra tất cả học viên của lớp “LH001”

SELECT HocVien.MaHV AS 'Mã học viên',HoTen AS 'Họ Tên'
FROM HocVien JOIN HopDong ON HocVien.MaHV=HopDong.MaHV
JOIN ChiTietHD ON HopDong.MaHD=ChiTietHD.MaHD
JOIN LopHoc ON ChiTietHD.MaLH=LopHoc.MaLH
WHERE LopHoc.MaLH = 'LH001'

--04. Lấy ra tất cả giáo trình của khoá “6.5+ IELTS”

SELECT GiaoTrinh.MaGT AS 'Mã giáo trình', GiaoTrinh.TieuDe AS 'Tiêu đề',  GiaoTrinh.MaKH AS 'Mã khóa học', TenKH AS 'Tên khóa học'
FROM GiaoTrinh JOIN KhoaHoc ON GiaoTrinh.MaKH=KhoaHoc.MaKH
WHERE TenKH = N'6.5+ IELTS'

--05.Lấy ra tổng doanh thu của tháng 5/2023

SELECT SUM(SoTien - ISNULL(KhuyenMai,0)) AS 'Tổng doanh thu tháng 5/2023'
FROM ChiTietHD JOIN HopDong ON ChiTietHD.MaHD=HopDong.MaHD
WHERE MONTH(ThoiGian) = 5 AND YEAR(ThoiGian) = 2023

--06. Lấy ra tất cả học viên đăng ký ít nhất 1 lớp trong tháng 5/2023

SELECT HocVien.MaHV AS 'Mã học viên',HoTen AS 'Họ Tên'
FROM HocVien JOIN HopDong ON HocVien.MaHV=HopDong.MaHV
WHERE MONTH(ThoiGian) = 6 AND YEAR(ThoiGian) = 2023
GROUP BY HocVien.MaHV,HocVien.HoTen

--07.Lấy ra thông tin tất cả hợp đồng (MaHD, MaNV, MaHV, ThoiGian, TongTien) trong tháng 5/2024

SELECT HopDong.MaHD AS 'Mã hợp đồng', MaNV AS 'Mã nhân viên', MaHV AS 'Mã học viên', ThoiGian AS 'Thời gian',SUM(SoTien - ISNULL(KhuyenMai,0)) AS 'Tổng tiền'
FROM HopDong JOIN ChiTietHD ON HopDong.MaHD=ChiTietHD.MaHD
WHERE MONTH(ThoiGian) = 5 AND YEAR(ThoiGian) = 2023
GROUP BY HopDong.MaHD, MaNV, MaHV, ThoiGian

--08.Lấy ra các lớp học có trên 10 học viên

SELECT LopHoc.MaLH AS 'Mã lớp học', TenLH AS 'Tên lớp học', COUNT(*) AS 'Số học viên'
FROM LopHoc JOIN ChiTietHD ON LopHoc.MaLH=ChiTietHD.MaLH
JOIN HopDong ON ChiTietHD.MaHD=HopDong.MaHD
JOIN HocVien ON HopDong.MaHV=HocVien.MaHV
GROUP BY LopHoc.MaLH, TenLH
HAVING COUNT(*) > 10

--9.Lấy ra giáo viên đứng nhiều lớp nhất.

SELECT TOP 1 NhanVien.MaNV AS 'Mã nhân viên',HoTen AS 'Họ tên', COUNT(*) AS 'Số lớp'
FROM NhanVien JOIN LopHoc ON NhanVien.MaNV=LopHoc.MaNV
GROUP BY NhanVien.MaNV,HoTen
ORDER BY COUNT(*) DESC

--10.Lấy ra nhân viên ký được nhiều hợp đồng nhất

SELECT TOP 1 NhanVien.MaNV AS 'Mã nhân viên',HoTen AS 'Họ tên', COUNT(*) AS 'Số hợp đồng'
FROM NhanVien JOIN HopDong ON NhanVien.MaNV=HopDong.MaNV
GROUP BY NhanVien.MaNV,HoTen
ORDER BY COUNT(*) DESC

--11.Cơ sở có doanh thu lớn nhất.

SELECT TOP 1 CoSo.MaCS AS 'Mã cơ sở', SUM(SoTien - ISNULL(KhuyenMai, 0)) AS 'DoanhThu'
FROM HopDong JOIN ChiTietHD ON HopDong.MaHD = ChiTietHD.MaHD
JOIN NhanVien ON HopDong.MaNV=NhanVien.MaNV
JOIN CoSo ON NhanVien.MaCS=CoSo.MaCS
GROUP BY CoSo.MaCS
ORDER BY SUM(SoTien - ISNULL(KhuyenMai, 0)) DESC

--12. Lấy ra nhân viên có doanh số cao nhất.

SELECT TOP 1 NhanVien.MaNV AS 'Mã Nhân viên', HoTen AS 'Họ tên', SUM(SoTien - KhuyenMai) AS 'Doanh số'
FROM NhanVien JOIN HopDong ON NhanVien.MaNV=HopDong.MaNv
JOIN ChiTietHD ON HopDong.MaHD=ChiTietHD.MaHD
GROUP BY NhanVien.MaNV, HoTen
ORDER BY SUM(SoTien - KhuyenMai) DESC

--13.Lấy ra thông tin tất cả các khoá học sắp xếp theo thứ tự giảm dần số lượng học viên đã đăng ký

SELECT KhoaHoc.MaKH AS 'Mã khóa học', TenKH AS 'Tên khóa học', COUNT(*) AS 'Số học viên'
FROM KhoaHoc JOIN LopHoc ON KhoaHoc.MaKH=LopHoc.MaKH
JOIN ChiTietHD ON LopHoc.MaLH=ChiTietHD.MaLH
JOIN HopDong ON ChiTietHD.MaHD=HopDong.MaHD
JOIN HocVien ON HopDong.MaHV=HocVien.MaHV
GROUP BY KhoaHoc.MaKH, TenKH
ORDER BY COUNT(*) DESC

--14.Lấy ra khóa học đông học viên nhất

SELECT TOP 1 KhoaHoc.MaKH AS 'Mã khóa học', TenKH AS 'Tên khóa học', COUNT(*) AS 'Số học viên'
FROM KhoaHoc JOIN LopHoc ON KhoaHoc.MaKH=LopHoc.MaKH
JOIN ChiTietHD ON LopHoc.MaLH=ChiTietHD.MaLH
JOIN HopDong ON ChiTietHD.MaHD=HopDong.MaHD
JOIN HocVien ON HopDong.MaHV=HocVien.MaHV
GROUP BY KhoaHoc.MaKH, TenKH
ORDER BY COUNT(*) DESC

--15.Lấy ra thông tin tất cả hợp đồng (MaHD, MaNV, MaHV, ThoiGian, TongTien) trong tháng 5/2024 sắp xếp theo thứ tự giảm dần tổng tiền

SELECT HopDong.MaHD AS 'Mã hợp đồng', MaNV AS 'Mã nhân viên', MaHV AS 'Mã học viên', ThoiGian AS 'Thời gian',SUM(SoTien - ISNULL(KhuyenMai,0)) AS 'Tổng tiền'
FROM HopDong JOIN ChiTietHD ON HopDong.MaHD=ChiTietHD.MaHD
WHERE MONTH(ThoiGian) = 5 AND YEAR(ThoiGian) = 2023
GROUP BY HopDong.MaHD, MaNV, MaHV, ThoiGian
ORDER BY SUM(SoTien - ISNULL(KhuyenMai,0)) DESC

--16. Khen thưởng các nhân viên kí được trên 20 hợp đồng.

SELECT HopDong.MaNV AS 'Mã nhân viên',HoTen AS 'Tên nhân viên',COUNT(HopDong.MaHD) AS 'Số hợp đồng',
    CASE 
        WHEN COUNT(HopDong.MaHD) > 20 THEN N'Đủ điều kiện'
        ELSE N'Không đủ điều kiện' 
    END AS 'Khen Thưởng'
FROM HopDong JOIN NhanVien ON NhanVien.MaNV=HopDong.MaNV
GROUP BY HopDong.MaNV, HoTen
--HAVING COUNT(HopDong.MaHD) > 20

--17.Lấy ra nhân viên chưa ký được hợp đồng nào trong tháng 5/2023
SELECT MaNV AS 'Mã nhân viên', MaCS AS 'Mã cơ sở', HoTen AS 'Họ Tên', NgaySinh AS 'Ngày sinh', SĐT,ChucVu AS 'Chức vụ', TrinhDo AS 'Trình độ', Luong AS 'Lương' FROM NhanVien
WHERE MaNV NOT IN (SELECT MaNV 
FROM HopDong 
WHERE YEAR(ThoiGian) = 2023 AND MONTH(ThoiGian) = 5) AND ChucVu = N'Nhân viên văn phòng'

--18.Lấy ra khóa học theo doanh thu giảm dần

SELECT KhoaHoc.MaKH AS 'Mã khóa học', TenKH AS 'Tên khóa học', SUM(ChiTietHD.SoTien) AS N'Doanh Thu'
FROM KhoaHoc JOIN LopHoc ON KhoaHoc.MaKH=LopHoc.MaKH
JOIN ChiTietHD ON LopHoc.MaLH=ChiTietHD.MaLH
JOIN HopDong ON ChiTietHD.MaHD=HopDong.MaHD
GROUP BY KhoaHoc.MaKH, TenKH
ORDER BY SUM(ChiTietHD.SoTien) DESC

--19. Cho học sinh có mã HV001 đăng ký 3 lớp LH011, LH012, LH013 do nhân viên NV002 ký
INSERT INTO HopDong (MaHD, MaHV, MaNV, HinhThucThanhToan, ThoiGian) VALUES ('HD121', 'HV001', 'NV002', N'Chuyển khoản', GETDATE());
INSERT INTO ChiTietHD(MaHD, MaLH)
VALUES ('HD121', 'LH011')

--20. Tăng 500000vnđ lương cho nhân viên ký được nhiều hợp đồng nhất tháng 5/2023
UPDATE NhanVien
SET Luong = Luong - 500000
WHERE MaNV = (SELECT TOP 1 NhanVien.MaNV
FROM NhanVien JOIN HopDong ON NhanVien.MaNV=HopDong.MaNv
JOIN ChiTietHD ON HopDong.MaHD=ChiTietHD.MaHD
GROUP BY NhanVien.MaNV
ORDER BY SUM(SoTien - KhuyenMai) DESC)

SELECT * FROM NhanVien WHERE MaNV = (SELECT TOP 1 NhanVien.MaNV
FROM NhanVien JOIN HopDong ON NhanVien.MaNV=HopDong.MaNv
JOIN ChiTietHD ON HopDong.MaHD=ChiTietHD.MaHD
GROUP BY NhanVien.MaNV
ORDER BY SUM(SoTien - KhuyenMai) DESC)


--21. Chuyển công tác nhân viên có mã NV002 sang cơ sở 2
UPDATE NhanVien
SET MaCS = 'CS0002'
WHERE MaNV = 'NV002'

SELECT * FROM NhanVien WHERE MaNV = 'NV002'

--22. Đuổi việc nhân viên chưa ký được hợp đồng nào
DELETE NhanVien 
WHERE MaNV = (SELECT MaNV FROM NhanVien
WHERE MaNV NOT IN (SELECT MaNV 
FROM HopDong) AND ChucVu = N'Nhân viên văn phòng')

INSERT INTO [dbo].[NhanVien] ([MaNV],[MaCS],[HoTen],[NgaySinh],[SĐT],[ChucVu],[TrinhDo],[Luong]) VALUES ('NV124','CS0001',N'Hoàng Thị Dung','1988-03-03','0918791234',N'Nhân viên văn phòng',NULL,7000000)

-- Tìm phòng học được sử dụng nhiều nhất
SELECT MaPH AS 'Mã phòng học', MaCS AS 'Mã cơ sở', TenPH AS 'Tên phòng học'
FROM PhongHoc
WHERE MaPH = (SELECT TOP 1 MaPH
FROM TietHoc
GROUP BY MaPH
ORDER BY COUNT(MaTH) DESC)

--Lấy ra giáo viên đứng nhiều lớp nhất.

SELECT TOP 1 NhanVien.MaNV AS 'Mã nhân viên',HoTen AS 'Họ tên', COUNT(MaTH) AS 'Số tiết'
FROM NhanVien JOIN LopHoc ON NhanVien.MaNV=LopHoc.MaNV
JOIN TietHoc ON LopHoc.MaLH=TietHoc.MaLH
GROUP BY NhanVien.MaNV,HoTen
ORDER BY COUNT(MaTH) DESC