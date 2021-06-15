DROP DATABASE BTL1;
CREATE DATABASE BTL1;

USE BTL1;

/**
 ** CREATE ALL TABLE
 **/
/* =======================================================TABlE 1======================================================= */
CREATE TABLE Giao_lo (ma_giao_lo CHAR(6), longitute REAL, latitude REAL, PRIMARY KEY (ma_giao_lo));
/* =======================================================TABLE 2======================================================= */
CREATE TABLE Doan_duong (
	ma_giao_lo_1	CHAR(6),
    ma_giao_lo_2	CHAR(6),
    chieu_dai		INT UNSIGNED,
    ma_con_duong	CHAR(6),
    stt				SMALLINT UNSIGNED,
    PRIMARY KEY (ma_giao_lo_1, ma_giao_lo_2)
);
/* =======================================================TABLE 3======================================================= */
CREATE TABLE Con_duong (ma_con_duong CHAR(6), ten_duong VARCHAR(20), PRIMARY KEY (ma_con_duong));
/* =======================================================TABLE 4======================================================= */
CREATE TABLE Tuyen_tau_xe (ma_tuyen CHAR(4), PRIMARY KEY (ma_tuyen));
/* =======================================================TABLE 5======================================================= */
CREATE TABLE Tuyen_xe_bus (
	no_bus				INT,
    ma_tuyen_tau_xe		CHAR(4),
    PRIMARY KEY (no_bus)
);
/* =======================================================TABLE 6======================================================= */
CREATE TABLE Tuyen_tau_dien (
	ma_tuyen_tau		CHAR,
    ten_tuyen_tau		VARCHAR(20)		NOT NULL	UNIQUE,
    don_gia				INT UNSIGNED,
    ma_tuyen_tau_xe		CHAR(4),
    PRIMARY KEY (ma_tuyen_tau)
);
/* =======================================================TABLE 7======================================================= */
CREATE TABLE Chuyen_tau_xe (ma_tuyen CHAR(4), stt INT UNSIGNED, PRIMARY KEY (ma_tuyen, stt));
/* =======================================================TABLE 8======================================================= */
CREATE TABLE Ga_tram (
	ma_ga_tram			CHAR(7),
    dia_chi				VARCHAR(30)		NOT NULL,
    ten					VARCHAR(30),
    ga_tram				BIT				NOT NULL,
    ma_giao_lo_1		CHAR(6),
    ma_giao_lo_2		CHAR(6),
    PRIMARY KEY (ma_ga_tram)
);
/* =======================================================TABLE 9======================================================= */
CREATE TABLE Chuyen_tau_xe_ghe_ga_tram (
	ma_tuyen		CHAR(4),
    stt_tuyen		INT UNSIGNED,
    ma_ga_tram		CHAR(7),
    stt				INT UNSIGNED,
    gio_ghe			TIME,	-- TODO: format HH:MI
    gio_di			TIME,	-- TODO: format HH:MI
    PRIMARY KEY (ma_tuyen, stt_tuyen, ma_ga_tram)
);
/* =======================================================TABLE 10======================================================= */
CREATE TABLE Ve (
	ma_ve			CHAR(15),
    loai_ve			SMALLINT,	-- TODO: 0 – vé lẻ, 1– vé tháng, 2 – vé một ngày.
    gia_ve			REAL,
    ngay_gio_mua	DATETIME,	-- TODO: format DD-MM-YYYY HH:MI:SS.
    ma_hanh_khach	CHAR(8),
    PRIMARY KEY (ma_ve)
);
/* =======================================================TABLE 11======================================================= */
CREATE TABLE Ve_le (
	ma_ve				CHAR(15),
    ma_tuyen			CHAR(4),
    ngay_su_dung		DATE,		-- TODO: format DD-MM-YYYY
    ma_ga_tram_len		CHAR(7),
    gio_len				TIME,	-- TODO: format HH:MI:SS
    ma_ga_tram_xuong	CHAR(7),
    gio_xuong			TIME,	-- TODO: format HH:MI:SS
    PRIMARY KEY (ma_ve)
);
/* =======================================================TABLE 12======================================================= */
CREATE TABLE Ve_thang (
	ma_ve				CHAR(15),
    ma_tuyen			CHAR(4),
	ma_ga_tram_1		CHAR(7),
    ma_ga_tram_2		CHAR(7),
    PRIMARY KEY (ma_ve)
);
/* =======================================================TABLE 13======================================================= */
CREATE TABLE Hoat_dong_ve_thang (
	ma_ve				CHAR(15),
    ngay_su_dung		DATE,			-- TODO: kiểu DATE có dạng DD-MM-YYYY
    gio_len				TIME,			-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên.
    gio_xuong			TIME,			-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên.
    ga_tram_len			CHAR(7),
    ga_tram_xuong		CHAR(7),
    PRIMARY KEY (ma_ve, ngay_su_dung, gio_len)
);
/* =======================================================TABLE 14======================================================= */
CREATE TABLE Ve_1_ngay (
	ma_ve				CHAR(15),
    ngay_su_dung		DATE, 			-- TODO: kiểu DATE có dạng DD-MM-YYYY
    PRIMARY KEY (ma_ve)
);
/* =======================================================TABLE 15======================================================= */
CREATE TABLE Hoat_dong_cua_ve_1_ngay (
	ma_ve				CHAR(15),
    stt					SMALLINT UNSIGNED,
    ma_tuyen			CHAR(4),
    ma_ga_tram_len		CHAR(7),
    ma_ga_tram_xuong	CHAR(7),
    gio_len				TIME,				-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên
    gio_xuong			TIME,				-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên
    PRIMARY KEY (ma_ve, stt)
);
/* =======================================================TABLE 16======================================================= */
CREATE TABLE Hanh_khach (
	ma_hanh_khach		CHAR(8),
    cccd				CHAR(9)		UNIQUE,
    nghe_nghiep			VARCHAR(20),
    dien_thoai			CHAR(10)	UNIQUE,
    gioi_tinh			ENUM('M', 'F'),
    email				VARCHAR(20),
    ngay_sinh			DATE,
    PRIMARY KEY (ma_hanh_khach)
);
/* =======================================================TABLE 17======================================================= */
CREATE TABLE The_tu (
	ma_the_tu			CHAR(8),
    ngay_mua			DATETIME,	-- TODO: DD-MM-YYYY HH:MI:SS
    ma_hanh_khach		CHAR(8),
    PRIMARY KEY (ma_the_tu)
);
/* =======================================================TABLE 18======================================================= */
CREATE TABLE Nhan_vien (
	ma_nhan_vien		CHAR(6),
    loai_cong_viec		VARCHAR(10),
    ngay_sinh			DATE,
    email				VARCHAR(20),
    gioi_tinh			ENUM('M', 'F'),
    dien_thoai_di_dong	VARCHAR(10),
    dien_thoai_noi_bo	VARCHAR(10),
    PRIMARY KEY (ma_nhan_vien)
);
/* =======================================================TABLE 19======================================================= */
CREATE TABLE Ga_tram_lam_viec (ma_nhan_vien CHAR(6), ma_ga_tram CHAR(7), PRIMARY KEY (ma_nhan_vien));
/* =======================================================TABLE 20======================================================= */
CREATE TABLE Bang_gia (don_gia_xe_bus INT UNSIGNED, gia_ve_1_ngay_trong_tuan INT UNSIGNED, gia_ve_1_ngay_cuoi_tuan INT UNSIGNED);
 
/**
 ** TRIGGER COUNTING AND CHECK TYPE INSERT
 **/
 SET SQL_SAFE_UPDATES = 0;
/* =======================================================TABlE 1======================================================= */
/*COUNT GL*/
CREATE TABLE Count_GL (count INT NOT NULL DEFAULT 0) ENGINE=MEMORY;
INSERT INTO Count_GL VALUES (1);
CREATE TABLE Giao_lo_2 (longitute REAL, latitude REAL) ENGINE=BLACKHOLE;
DELIMITER $$
CREATE TRIGGER auto_ma_giao_lo AFTER INSERT ON Giao_lo_2
FOR EACH ROW
BEGIN
	DECLARE cur INT;
    SELECT count INTO cur FROM Count_GL;
    UPDATE Count_GL SET count = count + 1;
    INSERT INTO Giao_lo VALUES (CONCAT("GL",cur), new.longitute, new.latitude);
END;
$$
DELIMITER ;
/* =======================================================TABLE 3======================================================= */
/*COUNT CD*/
CREATE TABLE Count_CD (count INT NOT NULL DEFAULT 0) ENGINE=MEMORY;
INSERT INTO Count_CD VALUES (1);
CREATE TABLE Con_duong_2 (ten_duong VARCHAR(20)) ENGINE=BLACKHOLE;
DELIMITER $$
CREATE TRIGGER auto_ma_con_duong AFTER INSERT ON Con_duong_2
FOR EACH ROW
BEGIN
	DECLARE cur INT;
    SELECT count INTO cur FROM Count_CD;
    UPDATE Count_CD SET count = count + 1;
    INSERT INTO Con_duong VALUES (CONCAT("CD",cur), new.ten_duong);
END;
$$
DELIMITER ;
/* =======================================================TABLE 4======================================================= */
/*CHECK MA TUYEN FORM Bxxx OR Txxx*/
DELIMITER $$
CREATE TRIGGER check_ma_tuyen_Tuyen_tau_xe BEFORE INSERT ON Tuyen_tau_xe
FOR EACH ROW
BEGIN
    IF (((SUBSTRING(New.ma_tuyen, 1, 1) != 'B') AND (SUBSTRING(New.ma_tuyen, 1, 1) != 'T')) OR
		((SUBSTRING(New.ma_tuyen, 2, 1) < '0') OR (SUBSTRING(New.ma_tuyen, 2, 1) > '9')) OR
		((SUBSTRING(New.ma_tuyen, 3, 1) < '0') OR (SUBSTRING(New.ma_tuyen, 3, 1) > '9')) OR
        ((SUBSTRING(New.ma_tuyen, 4, 1) < '0') OR (SUBSTRING(New.ma_tuyen, 4, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;
/* =======================================================TABLE 5======================================================= */
/*COUNT NO*/
CREATE TABLE Count_tuyen_xe (count INT NOT NULL DEFAULT 0) ENGINE=MEMORY;
INSERT INTO Count_tuyen_xe VALUES (1);

CREATE TABLE Tuyen_xe_bus_2 (ma_tuyen_tau_xe CHAR(4)) ENGINE=BLACKHOLE;
DELIMITER $$
CREATE TRIGGER auto_no_tuyen_xe_bus AFTER INSERT ON Tuyen_xe_bus_2
FOR EACH ROW
BEGIN
	DECLARE cur INT;
    SELECT count INTO cur FROM Count_tuyen_xe;
    UPDATE Count_tuyen_xe SET count = count + 1;
    INSERT INTO Tuyen_xe_bus VALUES (cur, new.ma_tuyen_tau_xe);
END;
$$
DELIMITER ;
/*CHECK MA TUYEN FORM Bxxx*/
DELIMITER $$
CREATE TRIGGER check_ma_tuyen_Tuyen_xe_bus BEFORE INSERT ON Tuyen_xe_bus_2
FOR EACH ROW
BEGIN
    IF ((SUBSTRING(New.ma_tuyen_tau_xe, 1, 1) != 'B') OR
		((SUBSTRING(New.ma_tuyen_tau_xe, 2, 1) < '0') OR (SUBSTRING(New.ma_tuyen_tau_xe, 2, 1) > '9')) OR
		((SUBSTRING(New.ma_tuyen_tau_xe, 3, 1) < '0') OR (SUBSTRING(New.ma_tuyen_tau_xe, 3, 1) > '9')) OR
        ((SUBSTRING(New.ma_tuyen_tau_xe, 4, 1) < '0') OR (SUBSTRING(New.ma_tuyen_tau_xe, 4, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;
/* =======================================================TABLE 6======================================================= */
/*CHECK MA TUYEN FORM Txxx*/
DELIMITER $$
CREATE TRIGGER check_ma_tuyen_Tuyen_tau_dien BEFORE INSERT ON Tuyen_tau_dien
FOR EACH ROW
BEGIN
    IF ((SUBSTRING(New.ma_tuyen_tau_xe, 1, 1) != 'T') OR
		((SUBSTRING(New.ma_tuyen_tau_xe, 2, 1) < '0') OR (SUBSTRING(New.ma_tuyen_tau_xe, 2, 1) > '9')) OR
		((SUBSTRING(New.ma_tuyen_tau_xe, 3, 1) < '0') OR (SUBSTRING(New.ma_tuyen_tau_xe, 3, 1) > '9')) OR
        ((SUBSTRING(New.ma_tuyen_tau_xe, 4, 1) < '0') OR (SUBSTRING(New.ma_tuyen_tau_xe, 4, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;
/* =======================================================TABLE 8======================================================= */
/*CHECK MA GA TRAM FROM BTxxxxx OR TTxxxxx*/
DELIMITER $$
CREATE TRIGGER check_ma_ga_tram_Ga_tram BEFORE INSERT ON Ga_tram
FOR EACH ROW
BEGIN
    IF (((SUBSTRING(New.ma_ga_tram, 1, 2) != "BT") AND (SUBSTRING(New.ma_ga_tram, 1, 2) != "TT")) OR
		((SUBSTRING(New.ma_ga_tram, 3, 1) < '0') OR (SUBSTRING(New.ma_ga_tram, 3, 1) > '9')) OR
		((SUBSTRING(New.ma_ga_tram, 4, 1) < '0') OR (SUBSTRING(New.ma_ga_tram, 4, 1) > '9')) OR
        ((SUBSTRING(New.ma_ga_tram, 5, 1) < '0') OR (SUBSTRING(New.ma_ga_tram, 5, 1) > '9')) OR
        ((SUBSTRING(New.ma_ga_tram, 6, 1) < '0') OR (SUBSTRING(New.ma_ga_tram, 6, 1) > '9')) OR
        ((SUBSTRING(New.ma_ga_tram, 7, 1) < '0') OR (SUBSTRING(New.ma_ga_tram, 7, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;
/* =======================================================TABLE 10======================================================= */
/*CHECK MA VE FROM V[O|M|D] [DDMMYYYY]xxxxx*/
DELIMITER $$
CREATE TRIGGER check_ma_ve_Ve BEFORE INSERT ON Ve
FOR EACH ROW
BEGIN
	DECLARE day_date INT;
    DECLARE month_date INT;
    DECLARE year_date INT;
    -- SET year_date = (SELECT CONVERT_TZ(SUBSTRING(New.ma_ve, 7, 4), INT));
    -- NEED CHECK DDMMYYYY
    IF (((SUBSTRING(New.ma_ve, 1, 2) != "VO") AND (SUBSTRING(New.ma_ve, 1, 2) != "VM") AND (SUBSTRING(New.ma_ve, 1, 2) != "VD")) OR
		((SUBSTRING(New.ma_ve, 11, 1) < '0') OR (SUBSTRING(New.ma_ve, 11, 1) > '3')) OR
		((SUBSTRING(New.ma_ve, 12, 1) < '0') OR (SUBSTRING(New.ma_ve, 12, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 13, 1) < '0') OR (SUBSTRING(New.ma_ve, 13, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 14, 1) < '0') OR (SUBSTRING(New.ma_ve, 14, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 15, 1) < '0') OR (SUBSTRING(New.ma_ve, 15, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;
/* =======================================================TABLE 11======================================================= */
/*CHECK MA VE FROM VO [DDMMYYYY]xxxxx*/
DELIMITER $$
CREATE TRIGGER check_ma_ve_Ve_le BEFORE INSERT ON Ve_le
FOR EACH ROW
BEGIN
	DECLARE day_date INT;
    DECLARE month_date INT;
    DECLARE year_date INT;
    -- SET year_date = (SELECT CONVERT_TZ(SUBSTRING(New.ma_ve, 7, 4), INT));
    -- NEED CHECK DDMMYYYY
    IF ((SUBSTRING(New.ma_ve, 1, 2) != "VO") OR
		((SUBSTRING(New.ma_ve, 11, 1) < '0') OR (SUBSTRING(New.ma_ve, 11, 1) > '3')) OR
		((SUBSTRING(New.ma_ve, 12, 1) < '0') OR (SUBSTRING(New.ma_ve, 12, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 13, 1) < '0') OR (SUBSTRING(New.ma_ve, 13, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 14, 1) < '0') OR (SUBSTRING(New.ma_ve, 14, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 15, 1) < '0') OR (SUBSTRING(New.ma_ve, 15, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;
/* =======================================================TABLE 12======================================================= */
/*CHECK MA VE FROM VM [DDMMYYYY]xxxxx*/
DELIMITER $$
CREATE TRIGGER check_ma_ve_Ve_thang BEFORE INSERT ON Ve_thang
FOR EACH ROW
BEGIN
	DECLARE day_date INT;
    DECLARE month_date INT;
    DECLARE year_date INT;
    -- SET year_date = (SELECT CONVERT_TZ(SUBSTRING(New.ma_ve, 7, 4), INT));
    -- NEED CHECK DDMMYYYY
    IF ((SUBSTRING(New.ma_ve, 1, 2) != "VM") OR
		((SUBSTRING(New.ma_ve, 11, 1) < '0') OR (SUBSTRING(New.ma_ve, 11, 1) > '3')) OR
		((SUBSTRING(New.ma_ve, 12, 1) < '0') OR (SUBSTRING(New.ma_ve, 12, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 13, 1) < '0') OR (SUBSTRING(New.ma_ve, 13, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 14, 1) < '0') OR (SUBSTRING(New.ma_ve, 14, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 15, 1) < '0') OR (SUBSTRING(New.ma_ve, 15, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;
/* =======================================================TABLE 14======================================================= */
/*CHECK MA VE FROM VD [DDMMYYYY]xxxxx*/
DELIMITER $$
CREATE TRIGGER check_ma_ve_Ve_1_ngay BEFORE INSERT ON Ve_1_ngay
FOR EACH ROW
BEGIN
	DECLARE day_date INT;
    DECLARE month_date INT;
    DECLARE year_date INT;
    -- SET year_date = (SELECT CONVERT_TZ(SUBSTRING(New.ma_ve, 7, 4), INT));
    -- NEED CHECK DDMMYYYY
    IF ((SUBSTRING(New.ma_ve, 1, 2) != "VD") OR
		((SUBSTRING(New.ma_ve, 11, 1) < '0') OR (SUBSTRING(New.ma_ve, 11, 1) > '3')) OR
		((SUBSTRING(New.ma_ve, 12, 1) < '0') OR (SUBSTRING(New.ma_ve, 12, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 13, 1) < '0') OR (SUBSTRING(New.ma_ve, 13, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 14, 1) < '0') OR (SUBSTRING(New.ma_ve, 14, 1) > '9')) OR
        ((SUBSTRING(New.ma_ve, 15, 1) < '0') OR (SUBSTRING(New.ma_ve, 15, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;
/* =======================================================TABLE 16======================================================= */
/*CHECK MA GA TRAM FROM KHxxxxxx*/
DELIMITER $$
CREATE TRIGGER check_ma_hanh_khach_Hanh_khach BEFORE INSERT ON Hanh_khach
FOR EACH ROW
BEGIN
    IF ((SUBSTRING(New.ma_hanh_khach, 1, 2) != "KH") OR
		((SUBSTRING(New.ma_hanh_khach, 3, 1) < '0') OR (SUBSTRING(New.ma_hanh_khach, 3, 1) > '9')) OR
		((SUBSTRING(New.ma_hanh_khach, 4, 1) < '0') OR (SUBSTRING(New.ma_hanh_khach, 4, 1) > '9')) OR
        ((SUBSTRING(New.ma_hanh_khach, 5, 1) < '0') OR (SUBSTRING(New.ma_hanh_khach, 5, 1) > '9')) OR
        ((SUBSTRING(New.ma_hanh_khach, 6, 1) < '0') OR (SUBSTRING(New.ma_hanh_khach, 6, 1) > '9')) OR
        ((SUBSTRING(New.ma_hanh_khach, 7, 1) < '0') OR (SUBSTRING(New.ma_hanh_khach, 7, 1) > '9')) OR
        ((SUBSTRING(New.ma_hanh_khach, 8, 1) < '0') OR (SUBSTRING(New.ma_hanh_khach, 8, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;
/* =======================================================TABLE 17======================================================= */
/*CHECK MA GA TRAM FROM TTxxxxxx*/
DELIMITER $$
CREATE TRIGGER check_ma_the_tu_The_tu BEFORE INSERT ON The_tu
FOR EACH ROW
BEGIN
    IF ((SUBSTRING(New.ma_the_tu, 1, 2) != "TT") OR
		((SUBSTRING(New.ma_the_tu, 3, 1) < '0') OR (SUBSTRING(New.ma_the_tu, 3, 1) > '9')) OR
		((SUBSTRING(New.ma_the_tu, 4, 1) < '0') OR (SUBSTRING(New.ma_the_tu, 4, 1) > '9')) OR
        ((SUBSTRING(New.ma_the_tu, 5, 1) < '0') OR (SUBSTRING(New.ma_the_tu, 5, 1) > '9')) OR
        ((SUBSTRING(New.ma_the_tu, 6, 1) < '0') OR (SUBSTRING(New.ma_the_tu, 6, 1) > '9')) OR
        ((SUBSTRING(New.ma_the_tu, 7, 1) < '0') OR (SUBSTRING(New.ma_the_tu, 7, 1) > '9')) OR
        ((SUBSTRING(New.ma_the_tu, 8, 1) < '0') OR (SUBSTRING(New.ma_the_tu, 8, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;
/* =======================================================TABLE 18======================================================= */
/* CHECK MA GA TRAM FROM NVxxxxx*/
DELIMITER $$
CREATE TRIGGER check_ma_nhan_vien_Nhan_vien BEFORE INSERT ON Nhan_vien
FOR EACH ROW
BEGIN
    IF ((SUBSTRING(New.ma_nhan_vien, 1, 2) != "NV") OR
		((SUBSTRING(New.ma_nhan_vien, 3, 1) < '0') OR (SUBSTRING(New.ma_nhan_vien, 3, 1) > '9')) OR
		((SUBSTRING(New.ma_nhan_vien, 4, 1) < '0') OR (SUBSTRING(New.ma_nhan_vien, 4, 1) > '9')) OR
        ((SUBSTRING(New.ma_nhan_vien, 5, 1) < '0') OR (SUBSTRING(New.ma_nhan_vien, 5, 1) > '9')) OR
        ((SUBSTRING(New.ma_nhan_vien, 6, 1) < '0') OR (SUBSTRING(New.ma_nhan_vien, 6, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/**
 ** FOREIGN KEY
 **/
 
/* =======================================================TABLE 2======================================================= */
ALTER TABLE Doan_duong
ADD CONSTRAINT fk_doanduong_mgl1_giaolo_mgl FOREIGN KEY (ma_giao_lo_1) REFERENCES Giao_lo(ma_giao_lo),
ADD	CONSTRAINT fk_doanduong_mgl2_giaolo_mgl FOREIGN KEY (ma_giao_lo_2) REFERENCES Giao_lo(ma_giao_lo),
ADD	CONSTRAINT fk_doanduong_mcd_conduong_mcd FOREIGN KEY (ma_con_duong) REFERENCES Con_duong(ma_con_duong);
/* =======================================================TABLE 5======================================================= */
ALTER TABLE Tuyen_xe_bus
ADD CONSTRAINT fk_tuyenxebus_mttx_tuyentauxe_mt FOREIGN KEY (ma_tuyen_tau_xe) REFERENCES Tuyen_tau_xe(ma_tuyen); -- TODO:  mã tuyến bắt đầu bằng “B”
/* =======================================================TABLE 6======================================================= */
ALTER TABLE Tuyen_tau_dien
ADD CONSTRAINT fk_tuyentaudien_mttx_tuyentauxe_mt FOREIGN KEY (ma_tuyen_tau_xe) REFERENCES Tuyen_tau_xe(ma_tuyen); -- TODO:  mã tuyến bắt đầu bằng “T”
/* =======================================================TABLE 7======================================================= */
ALTER TABLE Chuyen_tau_xe
ADD CONSTRAINT fk_chuyentauxe_mt_tuyentauxe_mt FOREIGN KEY (ma_tuyen) REFERENCES Tuyen_tau_xe(ma_tuyen);
/* =======================================================TABLE 8======================================================= */
ALTER TABLE Ga_tram
ADD CONSTRAINT fk_gatram_mgl_doanduong_mgl FOREIGN KEY (ma_giao_lo_1, ma_giao_lo_2) REFERENCES Doan_duong(ma_giao_lo_1, ma_giao_lo_2);
/* =======================================================TABLE 9======================================================= */
ALTER TABLE Chuyen_tau_xe_ghe_ga_tram
ADD CONSTRAINT fk_ghegatram_mtstt_chuyentauxe_mtstt FOREIGN KEY (ma_tuyen, stt) REFERENCES Chuyen_tau_xe(ma_tuyen, stt),
ADD CONSTRAINT fk_ghegatram_mgt_gatram_mgt FOREIGN KEY (ma_ga_tram) REFERENCES Ga_tram(ma_ga_tram);
/* =======================================================TABLE 10======================================================= */
ALTER TABLE Ve
ADD CONSTRAINT fk_ve_mhk_hanhkhach_mhk FOREIGN KEY (ma_hanh_khach) REFERENCES Hanh_khach(ma_hanh_khach);
/* =======================================================TABLE 11======================================================= */
ALTER TABLE Ve_le
ADD CONSTRAINT fk_vele_mv_ve_mv FOREIGN KEY (ma_ve) REFERENCES Ve(ma_ve), -- TODO: Những mã vé bắt đầu bằng “VO”
ADD CONSTRAINT fk_vele_mt_tuyentauxe_mt FOREIGN KEY (ma_tuyen) REFERENCES Tuyen_tau_xe(ma_tuyen),
ADD CONSTRAINT fk_vele_mgtl_gatram_mgt FOREIGN KEY (ma_ga_tram_len) REFERENCES Ga_tram(ma_ga_tram),
ADD CONSTRAINT fk_vele_mgtx_gatram_mgt FOREIGN KEY (ma_ga_tram_xuong) REFERENCES Ga_tram(ma_ga_tram);
/* =======================================================TABLE 12======================================================= */
ALTER TABLE Ve_thang
ADD CONSTRAINT fk_vethang_mv_ve_mv FOREIGN KEY (ma_ve) REFERENCES Ve(ma_ve), -- TODO: Những mã vé bắt đầu bằng “VM”
ADD CONSTRAINT fk_vethang_mt_tuyentauxe_mt FOREIGN KEY (ma_tuyen) REFERENCES Tuyen_tau_xe(ma_tuyen),
ADD CONSTRAINT fk_vethang_mgt1_gatram_mgt FOREIGN KEY (ma_ga_tram_1) REFERENCES Ga_tram(ma_ga_tram),
ADD CONSTRAINT fk_vethang_mgt2_gatram_mgt FOREIGN KEY (ma_ga_tram_2) REFERENCES Ga_tram(ma_ga_tram);
/* =======================================================TABLE 13======================================================= */
ALTER TABLE Hoat_dong_ve_thang
ADD CONSTRAINT fk_hdvethang_mv_vethang_mv FOREIGN KEY (ma_ve) REFERENCES Ve_thang(ma_ve),
ADD CONSTRAINT fk_hdvethang_gtl_gatram_mgt FOREIGN KEY (ga_tram_len) REFERENCES Ga_tram(ma_ga_tram),
ADD CONSTRAINT fk_hdvethang_gtx_gatram_mgt FOREIGN KEY (ga_tram_xuong) REFERENCES Ga_tram(ma_ga_tram);
/* =======================================================TABLE 14======================================================= */
ALTER TABLE Ve_1_ngay
ADD CONSTRAINT fk_ve1ngay_mv_ve_mv FOREIGN KEY (ma_ve) REFERENCES Ve(ma_ve); -- TODO: Những mã vé bắt đầu bằng “VD”
/* =======================================================TABLE 15======================================================= */
ALTER TABLE Hoat_dong_cua_ve_1_ngay
ADD CONSTRAINT fk_hdve1ngay_mv_ve1ngay_mv FOREIGN KEY (ma_ve) REFERENCES Ve_1_ngay(ma_ve),
ADD CONSTRAINT fk_hdve1ngay_mv_tuyentauxe_mt FOREIGN KEY (ma_tuyen) REFERENCES Tuyen_tau_xe(ma_tuyen),
ADD CONSTRAINT fk_hdve1ngay_mgtl_gatram_mgt FOREIGN KEY (ma_ga_tram_len) REFERENCES Ga_tram(ma_ga_tram),
ADD CONSTRAINT fk_hdve1ngay_mgtx_gatram_mgt FOREIGN KEY (ma_ga_tram_len) REFERENCES Ga_tram(ma_ga_tram);
/* =======================================================TABLE 17======================================================= */
ALTER TABLE The_tu
ADD CONSTRAINT fk_thetu_mhk_hanhkhach_mhk FOREIGN KEY (ma_hanh_khach) REFERENCES Hanh_khach(ma_hanh_khach);
/* =======================================================TABLE 19======================================================= */
ALTER TABLE Ga_tram_lam_viec
ADD CONSTRAINT fk_gatramlv_mnv_nhanvien_mnv FOREIGN KEY (ma_nhan_vien) REFERENCES Nhan_vien(ma_nhan_vien);
 


/**
***		INSERT DATA
**/

INSERT INTO Giao_lo_2 VALUES (1,2),(1,3),(2,1),(2,2),(3,3),(3,5),(4,2),(4,5);
INSERT INTO Doan_duong VALUES ("GL1","GL2",100,"CD1",1),("GL3","GL4",200,"CD2",1),("GL5","GL6",50,"CD3",1),("GL7","GL8",100,"CD4",1);
INSERT INTO Con_duong_2 VALUES ("BK"),("BDMS"),("Database"),("OOP");

INSERT INTO Hanh_khach VALUES
("KH000001", "000000000", "FE Dev", "0941648354", "M", "abc@gmail.com", "1991-09-13"),
("KH000002", "000000001", "CEO", "0943549264", "F", "xyz@gmail.com", "1992-09-13"),
("KH000003", "000000002", "Photographer", "0943562546", "F", "abc@hcmut.edu.vn", "1993-09-13"),
("KH000004", "000000003", "BE Dev", "0926548326", "M", "xyz@hcmut.edu.vn", "1994-09-13");
INSERT INTO The_tu VALUES
("TT000001", "2021-01-21", "KH000001"),
("TT000002", "2021-01-21", "KH000002"),
("TT000003", "2021-03-13", "KH000003"),
("TT000004", "2021-04-25", "KH000004");
INSERT INTO Nhan_vien VALUES
("NV0001", "Tiep tan", "1991-05-23", "nv1@gmail.com", "F", "0953167452", "0282123100"),
("NV0002", "Bao ve", "1992-02-23", "nv2@gmail.com", "M", "0961235648", "0282123101"),
("NV0003", "Tiep tan", "1993-12-13", "nv3@gmail.com", "F", "0921648264", "0282123102"),
("NV0004", "Tiep tan", "1994-09-30", "nv4@gmail.com", "F", "0985167952", "0282123103");

SELECT * FROM Giao_lo;
SELECT * FROM Doan_duong;
SELECT * FROM Con_duong;
SELECT * FROM Hanh_khach;
SELECT * FROM The_tu;
SELECT * FROM Nhan_vien;

/**
***		PHAN 2
**/

/**
***		2.1.1
**/

DELIMITER $$
CREATE TRIGGER check_tram_len_xuong_Hoat_dong_ve_thang_Ve_thang BEFORE INSERT ON Hoat_dong_ve_thang
FOR EACH ROW
BEGIN
	DECLARE len CHAR(7);
    DECLARE xuong CHAR(7);
    SET len = (SELECT ma_ga_tram_1 FROM Ve_thang V WHERE V.ma_ve = New.ma_ve);
    SET xuong = (SELECT ma_ga_tram_2 FROM Ve_thang V WHERE V.ma_ve = New.ma_ve);
    IF ((len != New.ga_tram_len) OR (xuong != New.ga_tram_xuong)) THEN
		SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/**
***		2.1.2
**/

DELIMITER $$
CREATE TRIGGER auto_update_price1 AFTER INSERT ON Ve
FOR EACH ROW
BEGIN
    IF New.loai_ve = 0 THEN
		INSERT INTO Ve_le VALUES ();
	ELSEIF New.loai_ve = 1 THEN 
		INSERT INTO Ve_thang VALUES ();
	ELSE 
		INSERT INTO Ve_ngayf VALUES ();
	END IF;
END;
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER auto_update_price3 AFTER INSERT ON Ve_le
FOR EACH ROW
BEGIN
	DECLARE gia1 INT UNSIGNED;
    DECLARE gia2 INT UNSIGNED;
    IF (SUBSTRING(New.ma_tuyen, 1, 1) = 'T') THEN 
		BEGIN
		SET gia1 = (SELECT dơn_gia FROM Tuyen_tau_dien WHERE ma_tuyen_tau=New.ma_tuyen);
        SELECT COUNT(ma_ga_tram) AS so_tram1 FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen;
        UPDATE Ve SET gia_ve = gia1*(so_tram1/2) where gia_ve=0;
        END;
	ELSE 
		BEGIN
		SET gia2 = (SELECT don_gia_xe_bus FROM Bang_gia );
        SELECT COUNT(ma_ga_tram) AS so_tram2 FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen;
        UPDATE Ve SET gia_ve = gia2*(so_tram2/2) where gia_ve=0;
        END;
	END IF;
END;
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER auto_update_price2 AFTER INSERT ON Ve_thang
FOR EACH ROW
BEGIN
	DECLARE gia1 INT UNSIGNED;
    DECLARE gia2 INT UNSIGNED;
    IF (SUBSTRING(New.ma_tuyen, 1, 1) = 'T') THEN 
		SET gia1 = (SELECT dơn_gia FROM Tuyen_tau_dien WHERE ma_tuyen_tau=New.ma_tuyen);
        SELECT COUNT(ma_ga_tram) AS so_tram1 FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen;
        UPDATE Ve SET gia_ve = gia1*(so_tram1/2)*20*2 where gia_ve=0;
	ELSEIF (SUBSTRING(New.ma_tuyen, 1, 1) = 'B') THEN 
		SET gia2 = (SELECT don_gia_xe_bus FROM Bang_gia );
        SELECT COUNT(ma_ga_tram) AS so_tram2 FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen;
        UPDATE Ve SET gia_ve = gia2*(so_tram2/2)*20*2 where gia_ve=0;
	END IF;
END;
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER auto_update_price4 AFTER INSERT ON Ve_1_ngay
FOR EACH ROW
BEGIN
	DECLARE gia1 INT UNSIGNED;
    DECLARE gia2 INT UNSIGNED;
    IF (SUBSTRING(New.ma_tuyen, 1, 1) = 'T') THEN 
		SET gia1 = (SELECT gia_ve_1_ngay_trong_tuan FROM Bang_gia );
        UPDATE Ve SET gia_ve = gia1 where gia_ve=0;
	ELSEIF (SUBSTRING(New.ma_tuyen, 1, 1) = 'B') THEN 
		SET gia2 = (SELECT gia_ve_1_ngay_trong_tuan FROM Bang_gia );
        UPDATE Ve SET gia_ve = gia2 where gia_ve=0;
	END IF;
END;
$$
DELIMITER ;

/**
***		2.2.1
**/

DELIMITER $$
CREATE PROCEDURE LoTrinhTuyenXeTau (IN ma_tuyen CHAR(4))
BEGIN
	DECLARE i INT;
    DECLARE str VARCHAR(1000);
    DECLARE ma_ga_tram_i CHAR(7);
    DECLARE ten_ga_tram_i VARCHAR(30);
    DECLARE max_i INT;
    
	CREATE TABLE temp
    SELECT stt, ma_ga_tram FROM Chuyen_tau_xe_ghe_ga_tram T
    WHERE T.ma_tuyen = ma_tuyen
    ORDER BY stt;
    
    SET i = 1;
    SET str = "";
    SET max_i = (SELECT COUNT(stt) FROM temp);
    
    loop_label:  LOOP
		IF  i > max_i THEN 
			LEAVE  loop_label;
		END IF;
		IF i != 1 THEN
			SET  str = CONCAT(str,',');
		END  IF;
        SET ma_ga_tram_i = (SELECT ma_ga_tram FROM temp WHERE stt = i);
        SET ten_ga_tram_i = (SELECT ten FROM Ga_tram WHERE ma_ga_tram = ma_ga_tram_i);
		SET  str = CONCAT(' ',str,ten_ga_tram_i);
		SET i = i + 1;
	END LOOP;
    DROP TABLE temp;
    SELECT str;
END;
$$
DELIMITER ;