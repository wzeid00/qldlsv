
PRAGMA foreign_keys = ON;

--xóa bảng--

DROP TABLE IF EXISTS Diem;
DROP TABLE IF EXISTS SinhVien;
DROP TABLE IF EXISTS MonHoc;
DROP TABLE IF EXISTS Lop;
DROP TABLE IF EXISTS Khoa;

--tạo bảng khoa--

CREATE TABLE Khoa (
    MaKhoa TEXT PRIMARY KEY,
    TenKhoa TEXT NOT NULL
);

-- =====================================
-- 2. TAO BANG LOP
-- =====================================

CREATE TABLE Lop (
    MaLop TEXT PRIMARY KEY,
    TenLop TEXT NOT NULL,
    MaKhoa TEXT NOT NULL,
    FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa)
);

--bảng sinh viên--

CREATE TABLE SinhVien (
    MaSV TEXT PRIMARY KEY,
    HoTen TEXT NOT NULL,
    NgaySinh TEXT,
    GioiTinh TEXT,
    DiaChi TEXT,
    SoDienThoai TEXT,
    Email TEXT UNIQUE,
    MaLop TEXT NOT NULL,
    FOREIGN KEY (MaLop) REFERENCES Lop(MaLop)
);

-- =====================================
-- 4. TAO BANG MON HOC
-- =====================================

CREATE TABLE MonHoc (
    MaMH TEXT PRIMARY KEY,
    TenMH TEXT NOT NULL,
    SoTinChi INTEGER NOT NULL CHECK (SoTinChi > 0)
);

--bảng điểm--

CREATE TABLE Diem (
    MaSV TEXT NOT NULL,
    MaMH TEXT NOT NULL,
    Diem REAL NOT NULL CHECK (Diem >= 0 AND Diem <= 10),
    PRIMARY KEY (MaSV, MaMH),
    FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV),
    FOREIGN KEY (MaMH) REFERENCES MonHoc(MaMH)
);

--thêm dữ liệu--

INSERT INTO Khoa VALUES
('CNTT', 'Cong nghe thong tin'),
('QTKD', 'Quan tri kinh doanh');

--lớp--

INSERT INTO Lop VALUES
('L01', 'Lop CNTT 01', 'CNTT'),
('L02', 'Lop QTKD 01', 'QTKD');

--sinh viên--

INSERT INTO SinhVien VALUES
('SV01', 'Nguyen Van An', '2007-03-12', 'Nam', 'Ha Noi', '0912345678', 'an@gmail.com', 'L01'),
('SV02', 'Tran Thi Binh', '2007-08-20', 'Nu', 'Ha Noi', '0987654321', 'binh@gmail.com', 'L01'),
('SV03', 'Le Van Cuong', '2006-11-05', 'Nam', 'Bac Ninh', '0901122334', 'cuong@gmail.com', 'L02');

--môn học--

INSERT INTO MonHoc VALUES
('MH01', 'Co so du lieu', 3),
('MH02', 'Lap trinh Java', 4),
('MH03', 'Tin hoc dai cuong', 3);

--điểm--

INSERT INTO Diem VALUES
('SV01', 'MH01', 8.5),
('SV01', 'MH02', 9.0),
('SV02', 'MH01', 7.5),
('SV03', 'MH03', 8.0);

--hiển thij danh sách sinh viên--

SELECT * FROM SinhVien;

--thông tin sinh viên--

SELECT
    SinhVien.MaSV,
    SinhVien.HoTen,
    SinhVien.NgaySinh,
    SinhVien.GioiTinh,
    SinhVien.DiaChi,
    Lop.TenLop,
    Khoa.TenKhoa
FROM SinhVien
JOIN Lop ON SinhVien.MaLop = Lop.MaLop
JOIN Khoa ON Lop.MaKhoa = Khoa.MaKhoa;

--bảng điểm--

SELECT
    SinhVien.HoTen,
    MonHoc.TenMH,
    Diem.Diem
FROM Diem
JOIN SinhVien ON Diem.MaSV = SinhVien.MaSV
JOIN MonHoc ON Diem.MaMH = MonHoc.MaMH;

--tìm kirmd sinh viên--

SELECT * FROM SinhVien
WHERE MaSV = 'SV01';

--update tt sinh viên--

UPDATE SinhVien
SET DiaChi = 'Hai Phong'
WHERE MaSV = 'SV01';

--ktra--

SELECT * FROM SinhVien
WHERE MaSV = 'SV01';
