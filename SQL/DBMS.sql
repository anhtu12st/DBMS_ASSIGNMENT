DROP DATABASE IF EXISTS `dbms`;
CREATE DATABASE `dbms`;
USE `dbms`;

/*TABlE 1*/
CREATE TABLE `Giao_lo` (
    `ma_giao_lo` CHAR(6), -- GL[x], x AUTO_INCREMENT
    `longitute` REAL, 
    `latitude` REAL, 
    
    PRIMARY KEY (`ma_giao_lo`)
);

/*TABLE 2*/
CREATE TABLE `Doan_duong` (
	`ma_giao_lo_1`	CHAR(6), -- FK to ma_giao_lo (Giao_lo)
    `ma_giao_lo_2`	CHAR(6), -- FK to ma_giao_lo (Giao_lo)
    `ma_con_duong`	CHAR(6), -- FK to ma_con_duong (Con_duong)
    `chieu_dai`		INT UNSIGNED,
    `stt`			SMALLINT UNSIGNED,

    PRIMARY KEY (`ma_giao_lo_1`, `ma_giao_lo_2`)
);

/*TABLE 3*/
CREATE TABLE `Con_duong` (
    `ma_con_duong` CHAR(6), -- CD[x], x AUTO_INCREMENT
    `ten_duong` VARCHAR(20), 
    
    PRIMARY KEY (`ma_con_duong`)
);

/*TABLE 4*/
CREATE TABLE `Tuyen_tau_xe` (
    `ma_tuyen` CHAR(4), -- [B|T] [0-9][0-9][0-9]
    
    PRIMARY KEY (`ma_tuyen`)
);

/*TABLE 5*/
CREATE TABLE `Tuyen_xe_bus` (
    `no` INT UNSIGNED AUTO_INCREMENT, 
    `ma_tuyen_tau_xe` CHAR(4), -- FK to ma_tuyen (Tuyen_tau_xe) 'B'
    
    PRIMARY KEY (`no`)
);

/*TABLE 6*/
CREATE TABLE `Tuyen_tau_dien` (
	`ma_tuyen_tau`		CHAR, -- A, B, C
    `ten_tuyen_tau`		VARCHAR(20)		NOT NULL	UNIQUE,
    `don_gia`			INT UNSIGNED,
    `ma_tuyen_tau_xe`	CHAR(4), -- FK to ma_tuyen (Tuyen_tau_xe) 'T'
    
    PRIMARY KEY (`ma_tuyen_tau`)
);

/*TABLE 7*/
CREATE TABLE `Chuyen_tau_xe` (
    `ma_tuyen` CHAR(4), -- FK to ma_tuyen (Tuyen_tau_xe)
    `stt`  INT UNSIGNED, 
    
    PRIMARY KEY (`ma_tuyen`, `stt`)
);

/*TABLE 8*/
CREATE TABLE `Ga_tram` (
	`ma_ga_tram`			CHAR(7),		-- BT00001, TT00001
    `dia_chi`				VARCHAR(30)		NOT NULL,
    `ten`					VARCHAR(30),
    `ga_tram`				BIT             NOT NULL,     -- 0: trạm xe bus, 1: ga tàu điện.
    `ma_giao_lo_1`		    CHAR(6),		-- | FK to (`ma_giao_lo_1`, `ma_giao_lo_2`)
    `ma_giao_lo_2`		    CHAR(6),		-- |		(`Doan_duong`)
    
    PRIMARY KEY (`ma_ga_tram`)
);

/*TABLE 9*/
CREATE TABLE `Chuyen_tau_xe_ghe_ga_tram` (
	`ma_tuyen`		CHAR(4),		-- | FK to (`ma_tuyen`, `stt`)
    `stt_tuyen`		INT UNSIGNED,	-- |		(`Chuyen_tau_xe`)
    `ma_ga_tram`	CHAR(7),		-- BT00001, TT00001
    `stt`			INT UNSIGNED,
    `gio_ghe`		TIME,	-- format HH:MI
    `gio_di`		TIME,	-- format HH:MI
    
    PRIMARY KEY (`ma_tuyen`, `stt_tuyen`, `ma_ga_tram`)
);

/*TABLE 10*/
CREATE TABLE `Ve` (
	`ma_ve`			CHAR(15),	-- V[O|M|D][DDMMYYYY][0-9][0-9][0-9][0-9][0-9]
    `loai_ve`		SMALLINT,	-- 0 – vé lẻ, 1– vé tháng, 2 – vé một ngày.
    `gia_ve`		REAL,
    `ngay_gio_mua`	DATETIME,	-- format DD-MM-YYYY HH:MI:SS.
    `ma_hanh_khach`	CHAR(8),	-- FK to ma_hanh_khach (Hanh_khach)
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 11*/
CREATE TABLE `Ve_le` (
	`ma_ve`				CHAR(15),	-- VO[DDMMYYYY][0-9][0-9][0-9][0-9][0-9]
    `ma_tuyen`			CHAR(4),
    `ngay_su_dung`		DATE,		-- format DD-MM-YYYY
    `ma_ga_tram_len`	CHAR(7),	-- FK to ma_ga_tram (Ga_tram)
    `ma_ga_tram_xuong`	CHAR(7),	-- FK to ma_ga_tram (Ga_tram)
    `gio_len`			TIME,	-- format HH:MI:SS
    `gio_xuong`			TIME,	-- format HH:MI:SS
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 12*/
CREATE TABLE `Ve_thang` (
	`ma_ve`				CHAR(15),	-- VM[DDMMYYYY][0-9][0-9][0-9][0-9][0-9]
    `ma_tuyen`			CHAR(4),	-- FK to ma_tuyen (Chuyen_tau_xe)
	`ma_ga_tram_1`		CHAR(7),	-- FK to ma_ga_tram (Ga_tram)
    `ma_ga_tram_2`		CHAR(7),	-- FK to ma_ga_tram (Ga_tram)
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 13*/
CREATE TABLE `Hoat_dong_ve_thang` (
	`ma_ve`				CHAR(15),	-- FK to ma_ve(Ve_thang)
    `ngay_su_dung`		DATE,		-- format DD-MM-YYYY
    `gio_len`			TIME,		-- format HH:MI:SS. gio_len < gio_xuong.
    `gio_xuong`			TIME,		-- format HH:MI:SS. gio_len < gio_xuong
    `ga_tram_len`		CHAR(7),	-- FK to ma_ga_tram (Ga_tram)
    `ga_tram_xuong`		CHAR(7),	-- FK to ma_ga_tram (Ga_tram)
    
    PRIMARY KEY (`ma_ve`, `ngay_su_dung`, `gio_len`)
);

/*TABLE 14*/
CREATE TABLE `Ve_1_ngay` (
	`ma_ve`				CHAR(15),	-- VD[DDMMYYYY][0-9][0-9][0-9][0-9][0-9]
    `ngay_su_dung`		DATE, 		-- format DD-MM-YYYY
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 15*/
CREATE TABLE `Hoat_dong_cua_ve_1_ngay` (
	`ma_ve`				CHAR(15) NOT NULL,	-- FK to ma_ve(Ve_1_ngay)
    `stt`				INT NOT NULL AUTO_INCREMENT,
    `ma_tuyen`			CHAR(4),	-- FK to ma_tuyen (Chuyen_tau_xe)
    `ma_ga_tram_len`	CHAR(7),	-- FK to ma_ga_tram (Ga_tram)
    `ma_ga_tram_xuong`	CHAR(7),	-- FK to ma_ga_tram (Ga_tram)
    `gio_len`			TIME,		-- format HH:MI:SS. gio_len < gio_xuong
    `gio_xuong`			TIME,		-- format HH:MI:SS. gio_len < gio_xuong
    
    PRIMARY KEY (`ma_ve`, `stt`)
) ENGINE=MyISAM;

/*TABLE 16*/
CREATE TABLE `Hanh_khach` (
	`ma_hanh_khach`		CHAR(8),	-- KH[0-9][0-9][0-9] [0-9][0-9][0-9]
    `cccd`				CHAR(9)		UNIQUE,
    `dien_thoai`		CHAR(10)	UNIQUE,
    `nghe_nghiep`		VARCHAR(20),
    `gioi_tinh`			ENUM('M', 'F'),
    `email`				VARCHAR(20),
    `ngay_sinh`			DATE,
    
    PRIMARY KEY (`ma_hanh_khach`)
);

/*TABLE 17*/
CREATE TABLE `The_tu` (
	`ma_the_tu`			CHAR(8),    -- TT[0-9][0-9][0-9][0-9][0-9][0-9]
    `ngay_mua`			DATETIME,	-- format DD-MM-YYYY HH:MI:SS
    `ma_hanh_khach`		CHAR(8),	-- FK to ma_hanh_khach(Hanh_khach)
    
    PRIMARY KEY (`ma_the_tu`)
);

/*TABLE 18*/
CREATE TABLE `Nhan_vien` (
	`ma_nhan_vien`		    CHAR(6),		-- NV0001, NV0002,…
    `loai_cong_viec`		VARCHAR(10),
    `ngay_sinh`			    DATE,
    `email`				    VARCHAR(20),
    `gioi_tinh`			    ENUM('M', 'F'),
    `dien_thoai_di_dong`    VARCHAR(10),
    `dien_thoai_noi_bo`	    VARCHAR(10),
    
    PRIMARY KEY (`ma_nhan_vien`)
);

/*TABLE 19*/
CREATE TABLE `Ga_tram_lam_viec` (
	`ma_nhan_vien`		CHAR(6),		-- FK to ma_nhan_vien(Nhan_vien)
    `ma_ga_tram`		CHAR(7),		-- FK to ma_ga_tram(Ga_tram)
    
    PRIMARY KEY (`ma_nhan_vien`)
);


/*TABLE 20*/
CREATE  TABLE `Bang_gia` (
    `don_gia_xe_bus`            INT NOT NULL,
    `gia_ve_1_ngay_trong_tuan`  INT NOT NULL,
    `gia_ve_1_ngay_cuoi_tuan`   INT NOT NULL
);

/**
***		CREATE CONDITIONS AND REFERENCES
**/

/*TABLE 2*/
ALTER TABLE `Doan_duong`
ADD CONSTRAINT `fk_doanduong_mgl1_giaolo_mgl` FOREIGN KEY (`ma_giao_lo_1`) REFERENCES `Giao_lo`(`ma_giao_lo`),
ADD	CONSTRAINT `fk_doanduong_mgl2_giaolo_mgl` FOREIGN KEY (`ma_giao_lo_2`) REFERENCES `Giao_lo`(`ma_giao_lo`),
ADD	CONSTRAINT `fk_doanduong_mcd_conduong_mcd` FOREIGN KEY (`ma_con_duong`) REFERENCES `Con_duong`(`ma_con_duong`);

/*TABLE 5*/
ALTER TABLE `Tuyen_xe_bus`
ADD CONSTRAINT `fk_tuyenxebus_mttx_tuyentauxe_mt` FOREIGN KEY (`ma_tuyen_tau_xe`) REFERENCES `Tuyen_tau_xe`(`ma_tuyen`); -- TODO:  mã tuyến bắt đầu bằng “B”

/*TABLE 6*/
ALTER TABLE `Tuyen_tau_dien`
ADD CONSTRAINT `fk_tuyentaudien_mttx_tuyentauxe_mt` FOREIGN KEY (`ma_tuyen_tau_xe`) REFERENCES `Tuyen_tau_xe`(`ma_tuyen`); -- TODO:  mã tuyến bắt đầu bằng “T”

/*TABLE 7*/
ALTER TABLE `Chuyen_tau_xe`
ADD CONSTRAINT `fk_chuyentauxe_mt_tuyentauxe_mt` FOREIGN KEY (`ma_tuyen`) REFERENCES `Tuyen_tau_xe`(`ma_tuyen`);

/*TABLE 8*/
ALTER TABLE `Ga_tram`
ADD CONSTRAINT `fk_gatram_mgl_doanduong_mgl` FOREIGN KEY (`ma_giao_lo_1`, `ma_giao_lo_2`) REFERENCES `Doan_duong`(`ma_giao_lo_1`, `ma_giao_lo_2`);

/*TABLE 9*/
ALTER TABLE `Chuyen_tau_xe_ghe_ga_tram`
ADD CONSTRAINT `fk_ghegatram_mtstt_chuyentauxe_mtstt` FOREIGN KEY (`ma_tuyen`, `stt`) REFERENCES `Chuyen_tau_xe`(`ma_tuyen`, `stt`),
ADD CONSTRAINT `fk_ghegatram_mgt_gatram_mgt` FOREIGN KEY (`ma_ga_tram`) REFERENCES `Ga_tram`(`ma_ga_tram`);

/*TABLE 10*/
ALTER TABLE `Ve`
ADD CONSTRAINT `fk_ve_mhk_hanhkhach_mhk` FOREIGN KEY (`ma_hanh_khach`) REFERENCES `Hanh_khach`(`ma_hanh_khach`);

/*TABLE 11 ERROR*/
ALTER TABLE `Ve_le`
ADD CONSTRAINT `fk_vele_mv_ve_mv` FOREIGN KEY (`ma_ve`) REFERENCES `Ve`(`ma_ve`), -- TODO: Những mã vé bắt đầu bằng “VO”
ADD CONSTRAINT `fk_vele_mt_tuyentauxe_mt` FOREIGN KEY (`ma_tuyen`) REFERENCES `Tuyen_tau_xe`(`ma_tuyen`),
ADD CONSTRAINT `fk_vele_mgtl_gatram_mgt` FOREIGN KEY (`ma_ga_tram_len`) REFERENCES `Ga_tram`(`ma_ga_tram`),
ADD CONSTRAINT `fk_vele_mgtx_gatram_mgt` FOREIGN KEY (`ma_ga_tram_xuong`) REFERENCES `Ga_tram`(`ma_ga_tram`);

/*TABLE 12*/
ALTER TABLE `Ve_thang`
ADD CONSTRAINT `fk_vethang_mv_ve_mv` FOREIGN KEY (`ma_ve`) REFERENCES `Ve`(`ma_ve`), -- TODO: Những mã vé bắt đầu bằng “VM”
ADD CONSTRAINT `fk_vethang_mt_tuyentauxe_mt` FOREIGN KEY (`ma_tuyen`) REFERENCES `Tuyen_tau_xe`(`ma_tuyen`),
ADD CONSTRAINT `fk_vethang_mgt1_gatram_mgt` FOREIGN KEY (`ma_ga_tram_1`) REFERENCES `Ga_tram`(`ma_ga_tram`),
ADD CONSTRAINT `fk_vethang_mgt2_gatram_mgt` FOREIGN KEY (`ma_ga_tram_2`) REFERENCES `Ga_tram`(`ma_ga_tram`);

/*TABLE 13*/
ALTER TABLE `Hoat_dong_ve_thang`
ADD CONSTRAINT `fk_hdvethang_mv_vethang_mv` FOREIGN KEY (`ma_ve`) REFERENCES `Ve_thang`(`ma_ve`),
ADD CONSTRAINT `fk_hdvethang_gtl_gatram_mgt` FOREIGN KEY (`ga_tram_len`) REFERENCES `Ga_tram`(`ma_ga_tram`),
ADD CONSTRAINT `fk_hdvethang_gtx_gatram_mgt` FOREIGN KEY (`ga_tram_xuong`) REFERENCES `Ga_tram`(`ma_ga_tram`);

/*TABLE 14*/
ALTER TABLE `Ve_1_ngay`
ADD CONSTRAINT `fk_ve1ngay_mv_ve_mv` FOREIGN KEY (`ma_ve`) REFERENCES `Ve`(`ma_ve`); -- TODO: Những mã vé bắt đầu bằng “VD”

/*TABLE 15*/
ALTER TABLE `Hoat_dong_cua_ve_1_ngay`
ADD CONSTRAINT `fk_hdve1ngay_mv_ve1ngay_mv` FOREIGN KEY (`ma_ve`) REFERENCES `Ve_1_ngay`(`ma_ve`),
ADD CONSTRAINT `fk_hdve1ngay_mv_tuyentauxe_mt` FOREIGN KEY (`ma_tuyen`) REFERENCES `Tuyen_tau_xe`(`ma_tuyen`),
ADD CONSTRAINT `fk_hdve1ngay_mgtl_gatram_mgt` FOREIGN KEY (`ma_ga_tram_len`) REFERENCES `Ga_tram`(`ma_ga_tram`),
ADD CONSTRAINT `fk_hdve1ngay_mgtx_gatram_mgt` FOREIGN KEY (`ma_ga_tram_len`) REFERENCES `Ga_tram`(`ma_ga_tram`);

/*TABLE 17*/
ALTER TABLE `The_tu`
ADD CONSTRAINT `fk_thetu_mhk_hanhkhach_mhk` FOREIGN KEY (`ma_hanh_khach`) REFERENCES `Hanh_khach`(`ma_hanh_khach`);

/*TABLE 19*/
ALTER TABLE `Ga_tram_lam_viec`
ADD CONSTRAINT `fk_gatramlv_mnv_nhanvien_mnv` FOREIGN KEY (`ma_nhan_vien`) REFERENCES `Nhan_vien`(`ma_nhan_vien`);


/**
***		CREATE TRIGGER
**/

/*TABLE 1*/
CREATE TABLE `Giao_lo_seq`(`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
DELIMITER $$
CREATE TRIGGER `tg_giao_lo_before_insert` BEFORE INSERT ON `Giao_lo`
FOR EACH ROW
BEGIN
  INSERT INTO `Giao_lo_seq` VALUES (NULL);
  SET NEW.`ma_giao_lo` = CONCAT('GL', LAST_INSERT_ID());
END$$
DELIMITER ;

/*TABLE 3*/
CREATE TABLE `Con_duong_seq`(`id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
DELIMITER $$
CREATE TRIGGER `tg_con_duong_before_insert` BEFORE INSERT ON `Con_duong`
FOR EACH ROW
BEGIN
  INSERT INTO `Con_duong_seq` VALUES (NULL);
  SET NEW.`ma_con_duong` = CONCAT('CD', LAST_INSERT_ID());
END$$
DELIMITER ;

/*TABLE 4*/
DELIMITER $$
CREATE TRIGGER `tg_tuyen_tau_xe_before_insert` BEFORE INSERT ON `Tuyen_tau_xe`
FOR EACH ROW
BEGIN
    IF (((SUBSTRING(NEW.`ma_tuyen`, 1, 1) != 'B') AND (SUBSTRING(NEW.`ma_tuyen`, 1, 1) != 'T')) OR
		((SUBSTRING(NEW.`ma_tuyen`, 2, 1) < '0') OR (SUBSTRING(NEW.`ma_tuyen`, 2, 1) > '9')) OR
		((SUBSTRING(NEW.`ma_tuyen`, 3, 1) < '0') OR (SUBSTRING(NEW.`ma_tuyen`, 3, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_tuyen`, 4, 1) < '0') OR (SUBSTRING(NEW.`ma_tuyen`, 4, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*TABLE 5*/
DELIMITER $$
CREATE TRIGGER `tg_tuyen_xe_bus_before_insert` BEFORE INSERT ON `Tuyen_xe_bus`
FOR EACH ROW
BEGIN
    IF ((SUBSTRING(NEW.`ma_tuyen_tau_xe`, 1, 1) != 'B') OR
		((SUBSTRING(NEW.`ma_tuyen_tau_xe`, 2, 1) < '0') OR (SUBSTRING(NEW.`ma_tuyen_tau_xe`, 2, 1) > '9')) OR
		((SUBSTRING(NEW.`ma_tuyen_tau_xe`, 3, 1) < '0') OR (SUBSTRING(NEW.`ma_tuyen_tau_xe`, 3, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_tuyen_tau_xe`, 4, 1) < '0') OR (SUBSTRING(NEW.`ma_tuyen_tau_xe`, 4, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*TABLE 6*/
DELIMITER $$
CREATE TRIGGER `tg_tuyen_tau_dien_before_insert` BEFORE INSERT ON `Tuyen_tau_dien`
FOR EACH ROW
BEGIN
    IF ((SUBSTRING(NEW.`ma_tuyen_tau_xe`, 1, 1) != 'T') OR
		((SUBSTRING(NEW.`ma_tuyen_tau_xe`, 2, 1) < '0') OR (SUBSTRING(NEW.`ma_tuyen_tau_xe`, 2, 1) > '9')) OR
		((SUBSTRING(NEW.`ma_tuyen_tau_xe`, 3, 1) < '0') OR (SUBSTRING(NEW.`ma_tuyen_tau_xe`, 3, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_tuyen_tau_xe`, 4, 1) < '0') OR (SUBSTRING(NEW.`ma_tuyen_tau_xe`, 4, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*TABLE 8*/
DELIMITER $$
CREATE TRIGGER `tg_ga_tram_before_insert` BEFORE INSERT ON `Ga_tram`
FOR EACH ROW
BEGIN
    IF (((SUBSTRING(NEW.`ma_ga_tram`, 1, 2) != 'BT') AND (SUBSTRING(NEW.`ma_ga_tram`, 1, 2) != 'TT')) OR
		((SUBSTRING(NEW.`ma_ga_tram`, 3, 1) < '0') OR (SUBSTRING(NEW.`ma_ga_tram`, 3, 1) > '9')) OR
		((SUBSTRING(NEW.`ma_ga_tram`, 4, 1) < '0') OR (SUBSTRING(NEW.`ma_ga_tram`, 4, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ga_tram`, 5, 1) < '0') OR (SUBSTRING(NEW.`ma_ga_tram`, 5, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ga_tram`, 6, 1) < '0') OR (SUBSTRING(NEW.`ma_ga_tram`, 6, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ga_tram`, 7, 1) < '0') OR (SUBSTRING(NEW.`ma_ga_tram`, 7, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
    IF (((SUBSTRING(NEW.`ma_ga_tram`, 1, 2) = 'BT') AND (NEW.`ga_tram`) != 0) OR
        ((SUBSTRING(NEW.`ma_ga_tram`, 1, 2) = 'TT') AND (NEW.`ga_tram`) != 1)) THEN
        SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*TABLE 10*/
DELIMITER $$
CREATE TRIGGER `tg_ve_before_insert` BEFORE INSERT ON `Ve`
FOR EACH ROW
BEGIN
    -- TODO: CHECK VALID DATETIME
    IF (((SUBSTRING(NEW.`ma_ve`, 1, 2) != "VO") AND (SUBSTRING(NEW.`ma_ve`, 1, 2) != "VM") AND (SUBSTRING(NEW.`ma_ve`, 1, 2) != "VD")) OR
        ((SUBSTRING(NEW.`ma_ve`, 11, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 11, 1) > '9')) OR
		((SUBSTRING(NEW.`ma_ve`, 12, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 12, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 13, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 13, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 14, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 14, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 15, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 15, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*TABLE 11*/
DELIMITER $$
CREATE TRIGGER `tg_ve_le_before_insert` BEFORE INSERT ON `Ve_le`
FOR EACH ROW
BEGIN
	-- TODO: CHECK VALID DATETIME, ma_tuyen, gio len xuong
    IF ((SUBSTRING(NEW.`ma_ve`, 1, 2) != "VO") OR
		((SUBSTRING(NEW.`ma_ve`, 11, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 11, 1) > '9')) OR
		((SUBSTRING(NEW.`ma_ve`, 12, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 12, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 13, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 13, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 14, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 14, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 15, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 15, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*TABLE 12*/
DELIMITER $$
CREATE TRIGGER `tg_ve_thang_before_insert` BEFORE INSERT ON `Ve_thang`
FOR EACH ROW
BEGIN
	-- TODO: CHECK VALID DATETIME, ma_tuyen
    IF ((SUBSTRING(NEW.`ma_ve`, 1, 2) != "VM") OR
		((SUBSTRING(NEW.`ma_ve`, 11, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 11, 1) > '9')) OR
		((SUBSTRING(NEW.`ma_ve`, 12, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 12, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 13, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 13, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 14, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 14, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 15, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 15, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*TABLE 14*/
DELIMITER $$
CREATE TRIGGER `tg_ve_1_ngay_before_insert` BEFORE INSERT ON `Ve_1_ngay`
FOR EACH ROW
BEGIN
	-- TODO: CHECK VALID DATETIME, ma_tuyen
    IF ((SUBSTRING(NEW.`ma_ve`, 1, 2) != "VD") OR
		((SUBSTRING(NEW.`ma_ve`, 11, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 11, 1) > '9')) OR
		((SUBSTRING(NEW.`ma_ve`, 12, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 12, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 13, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 13, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 14, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 14, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_ve`, 15, 1) < '0') OR (SUBSTRING(NEW.`ma_ve`, 15, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*TABLE 15*/
-- TODO: check gio len xuong

/*TABLE 16*/
DELIMITER $$
CREATE TRIGGER `tg_hanh_khach_before_insert` BEFORE INSERT ON `Hanh_khach`
FOR EACH ROW
BEGIN
    IF ((SUBSTRING(NEW.`ma_hanh_khach`, 1, 2) != "KH") OR
		((SUBSTRING(NEW.`ma_hanh_khach`, 3, 1) < '0') OR (SUBSTRING(NEW.`ma_hanh_khach`, 3, 1) > '9')) OR
		((SUBSTRING(NEW.`ma_hanh_khach`, 4, 1) < '0') OR (SUBSTRING(NEW.`ma_hanh_khach`, 4, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_hanh_khach`, 5, 1) < '0') OR (SUBSTRING(NEW.`ma_hanh_khach`, 5, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_hanh_khach`, 6, 1) < '0') OR (SUBSTRING(NEW.`ma_hanh_khach`, 6, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_hanh_khach`, 7, 1) < '0') OR (SUBSTRING(NEW.`ma_hanh_khach`, 7, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_hanh_khach`, 8, 1) < '0') OR (SUBSTRING(NEW.`ma_hanh_khach`, 8, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*TABLE 17*/
DELIMITER $$
CREATE TRIGGER `tg_the_tu_before_insert` BEFORE INSERT ON `The_tu`
FOR EACH ROW
BEGIN
    IF ((SUBSTRING(NEW.`ma_the_tu`, 1, 2) != "TT") OR
		((SUBSTRING(NEW.`ma_the_tu`, 3, 1) < '0') OR (SUBSTRING(NEW.`ma_the_tu`, 3, 1) > '9')) OR
		((SUBSTRING(NEW.`ma_the_tu`, 4, 1) < '0') OR (SUBSTRING(NEW.`ma_the_tu`, 4, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_the_tu`, 5, 1) < '0') OR (SUBSTRING(NEW.`ma_the_tu`, 5, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_the_tu`, 6, 1) < '0') OR (SUBSTRING(NEW.`ma_the_tu`, 6, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_the_tu`, 7, 1) < '0') OR (SUBSTRING(NEW.`ma_the_tu`, 7, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_the_tu`, 8, 1) < '0') OR (SUBSTRING(NEW.`ma_the_tu`, 8, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*TABLE 18*/
DELIMITER $$
CREATE TRIGGER `tg_nhan_vien_before_insert` BEFORE INSERT ON `Nhan_vien`
FOR EACH ROW
BEGIN
    IF ((SUBSTRING(NEW.`ma_nhan_vien`, 1, 2) != "NV") OR
		((SUBSTRING(NEW.`ma_nhan_vien`, 3, 1) < '0') OR (SUBSTRING(NEW.`ma_nhan_vien`, 3, 1) > '9')) OR
		((SUBSTRING(NEW.`ma_nhan_vien`, 4, 1) < '0') OR (SUBSTRING(NEW.`ma_nhan_vien`, 4, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_nhan_vien`, 5, 1) < '0') OR (SUBSTRING(NEW.`ma_nhan_vien`, 5, 1) > '9')) OR
        ((SUBSTRING(NEW.`ma_nhan_vien`, 6, 1) < '0') OR (SUBSTRING(NEW.`ma_nhan_vien`, 6, 1) > '9'))) THEN
			SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*
** PHAN 2
*/

/*
** 2.1.1
*/

DELIMITER $$
CREATE TRIGGER `check_tram_len_xuong_Hoat_dong_ve_thang_Ve_thang` BEFORE INSERT ON `Hoat_dong_ve_thang`
FOR EACH ROW
BEGIN
	DECLARE `tram_1` CHAR(7);
    DECLARE `tram_2` CHAR(7);
    SET `tram_1` = (SELECT `ma_ga_tram_1` FROM `Ve_thang` `V` WHERE `V`.`ma_ve` = New.`ma_ve`);
    SET `tram_2` = (SELECT `ma_ga_tram_2` FROM `Ve_thang` `V` WHERE `V`.`ma_ve` = New.`ma_ve`);
	IF (((`tram_1` = New.`ga_tram_len` AND `tram_2` = New.`ga_tram_xuong`) OR
		 (`tram_2` = New.`ga_tram_len` AND `tram_1` = New.`ga_tram_xuong`)) != TRUE) THEN
		SIGNAL SQLSTATE '45000';
    END IF;
END;
$$
DELIMITER ;

/*
** 2.1.2
*/

DROP TRIGGER IF EXISTS auto_update_price1;
DELIMITER $$
CREATE TRIGGER auto_update_price1 AFTER INSERT ON Ve_le
FOR EACH ROW
BEGIN
	DECLARE gia INT UNSIGNED;
    DECLARE stt1 INT UNSIGNED;
    DECLARE stt2 INT UNSIGNED;
    IF (SUBSTRING(New.ma_tuyen, 1, 1) = 'T') THEN 
		BEGIN
			SET gia = (SELECT don_gia FROM Tuyen_tau_dien WHERE ma_tuyen_tau_xe=New.ma_tuyen);
			SET stt1 = (SELECT stt FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen AND ma_ga_tram=New.ma_ga_tram_len );
			SET stt2 = (SELECT stt FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen AND ma_ga_tram=New.ma_ga_tram_xuong );
			UPDATE Ve SET gia_ve = ROUND((gia*(stt2-stt1+1)/2)) where ma_ve=New.ma_ve;
        END;
	ELSE 
		BEGIN
			SET gia = (SELECT don_gia_xe_bus FROM Bang_gia );
			SET stt1 = (SELECT stt FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen AND ma_ga_tram=New.ma_ga_tram_len );
			SET stt2 = (SELECT stt FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen AND ma_ga_tram=New.ma_ga_tram_xuong );
			UPDATE Ve SET gia_ve = ROUND((gia*(stt2-stt1+1)/2)) where ma_ve=New.ma_ve;
        END;
	END IF;
END;
$$
DELIMITER ;
DROP TRIGGER IF EXISTS auto_update_price2;
DELIMITER $$
CREATE TRIGGER auto_update_price2 AFTER INSERT ON Ve_thang
FOR EACH ROW
BEGIN
	DECLARE gia INT UNSIGNED;
    DECLARE stt1 INT UNSIGNED;
    DECLARE stt2 INT UNSIGNED;
    IF (SUBSTRING(New.ma_tuyen, 1, 1) = 'T') THEN 
		BEGIN
			SET gia = (SELECT don_gia FROM Tuyen_tau_dien WHERE ma_tuyen_tau_xe=New.ma_tuyen);
			SET stt1 = (SELECT stt FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen AND ma_ga_tram=New.ma_ga_tram_1 );
			SET stt2 = (SELECT stt FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen AND ma_ga_tram=New.ma_ga_tram_2 );
			UPDATE Ve SET gia_ve = ROUND((gia*(stt2-stt1+1)/2)*20*2) where ma_ve=New.ma_ve;
        END;
	ELSEIF (SUBSTRING(New.ma_tuyen, 1, 1) = 'B') THEN 
		BEGIN
			SET gia = (SELECT don_gia_xe_bus FROM Bang_gia );
			SET stt1 = (SELECT stt FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen AND ma_ga_tram=New.ma_ga_tram_1 );
			SET stt2 = (SELECT stt FROM Chuyen_tau_xe_ghe_ga_tram WHERE ma_tuyen=New.ma_tuyen AND ma_ga_tram=New.ma_ga_tram_2 );
			UPDATE Ve SET gia_ve = ROUND((gia*(stt2-stt1+1)/2)*20*2) where ma_ve=New.ma_ve;
        END;
	END IF;
END;
$$
DELIMITER ;
DROP TRIGGER IF EXISTS auto_update_price3;
DELIMITER $$
CREATE TRIGGER auto_update_price3 AFTER INSERT ON Ve_1_ngay
FOR EACH ROW
BEGIN
	DECLARE gia INT UNSIGNED;
    DECLARE ngay INT UNSIGNED;
	SET ngay= DAYOFWEEK(New.ngay_su_dung);
    IF (ngay=1) THEN
		SET gia = (SELECT gia_ve_1_ngay_cuoi_tuan FROM Bang_gia );
	ELSE
		SET gia = (SELECT gia_ve_1_ngay_trong_tuan FROM Bang_gia );
	END IF;
	UPDATE Ve SET gia_ve = gia where ma_ve=New.ma_ve;
END;
$$
DELIMITER ;

/*
** 2.2.1
*/

DELIMITER $$
CREATE PROCEDURE LoTrinhTuyenXeTau (IN `ma_tuyen` CHAR(4))
BEGIN
	DECLARE `i` INT;
    DECLARE `str` VARCHAR(1000);
    DECLARE `ma_ga_tram_i` CHAR(7);
    DECLARE `ten_ga_tram_i` VARCHAR(30);
    DECLARE `max_i` INT;
    
	CREATE TABLE `temp`
    SELECT `stt`, `ma_ga_tram` FROM `Chuyen_tau_xe_ghe_ga_tram` `T`
    WHERE `T`.`ma_tuyen` = `ma_tuyen`
    ORDER BY `stt`;
    
    SET `i` = 1;
    SET `str` = "";
    SET `max_i` = (SELECT COUNT(`stt`) FROM `temp`);
    
    loop_label:  LOOP
		IF  `i` > `max_i` THEN 
			LEAVE  loop_label;
		END IF;
		IF `i` != 1 THEN
			SET  `str` = CONCAT(`str`,', ');
		END  IF;
        SET `ma_ga_tram_i` = (SELECT `ma_ga_tram` FROM `temp` WHERE `stt` = `i`);
        SET `ten_ga_tram_i` = (SELECT `ten` FROM `Ga_tram` WHERE `ma_ga_tram` = `ma_ga_tram_i`);
		SET  `str` = CONCAT(`str`,`ten_ga_tram_i`);
		SET i = i + 1;
	END LOOP;
    DROP TABLE `temp`;
    SELECT `str`;
END;
$$
DELIMITER ;

/*
** 2.2.2
*/
DELIMITER $$
CREATE PROCEDURE `ThongKeLuotNguoi` (`ma_tuyen` CHAR(4), `tu_ngay` DATE, `toi_ngay` DATE)
BEGIN
    DECLARE `cur_date` DATE;
    CREATE TABLE `temp` (`ngay_su_dung` DATE PRIMARY KEY, `tong_luot` INT);
    SET `cur_date` = `tu_ngay`;
    WHILE `cur_date` <= `toi_ngay` DO
        INSERT INTO `temp` VALUE (`cur_date`, 0);
        SET `cur_date` = DATE_ADD(`cur_date`,INTERVAL 1 day);
    END WHILE;

    INSERT INTO `temp`
    SELECT * 
    FROM (
        SELECT `ngay_su_dung`, count(`ma_ve`) AS `tong_luot`
        FROM (
            SELECT `v1`.`ma_ve`, `v1`.`ngay_su_dung` 
            FROM `Ve_1_ngay` AS `v1` 
            JOIN `Hoat_dong_cua_ve_1_ngay` AS `v2` 
            ON `v1`.`ma_ve` = `v2`.`ma_ve` 
            WHERE `v2`.`ma_tuyen` = `ma_tuyen` AND `ngay_su_dung` BETWEEN `tu_ngay` AND `toi_ngay`
            UNION ALL
            SELECT `ma_ve`, `ngay_su_dung`
            FROM `Ve_le` AS `vl`
            WHERE `vl`.`ma_tuyen` = `ma_tuyen` AND  `ngay_su_dung` BETWEEN `tu_ngay` AND `toi_ngay`
            UNION ALL
            SELECT `v3`.`ma_ve`, `v4`.`ngay_su_dung` 
            FROM `Ve_thang` AS `v3` 
            JOIN `Hoat_dong_ve_thang` AS `v4` 
            ON `v3`.`ma_ve` = `v4`.`ma_ve` 
            WHERE `v3`.`ma_tuyen` = `ma_tuyen` AND `v4`.`ngay_su_dung` BETWEEN `tu_ngay` AND `toi_ngay`
        ) AS `a`
        GROUP BY `ngay_su_dung`
    ) as `b`
    ON DUPLICATE KEY UPDATE `temp`.`tong_luot`=`b`.`tong_luot`;

    SELECT * FROM `temp`;
    DROP TABLE `temp`;
END;
$$
DELIMITER ;


/*
-- 2 cach giai quyet van de voi trigger can thong nhat lai chi dung 1 cach
-- truong hop stt cua chuyen_tau_xe_ghe_tram_ga 1-2-3 cua 1 chuyen se ra sao neu tau chay nguoc lai 3-2-1 tren tuyen do
*/

/**
***		INSERT DATA
**/


/*TABLE 20*/
INSERT INTO `Bang_gia` (`don_gia_xe_bus`,`gia_ve_1_ngay_trong_tuan`,`gia_ve_1_ngay_cuoi_tuan`)
    VALUES (5000,30000,40000) ON DUPLICATE KEY 
    UPDATE 	`don_gia_xe_bus` = 5000,
			`gia_ve_1_ngay_trong_tuan` = 30000,
			`gia_ve_1_ngay_cuoi_tuan` = 40000;

/*TABLE 1*/
INSERT INTO `Giao_lo`(`longitute`,`latitude`) VALUES
(0,0),(2,2),(2,0),(3,3),(3,5),(4,2),(4,5),(5,5);

/*TABLE 3*/
INSERT INTO `Con_duong`(`ten_duong`) VALUES
('Duong doi'),('Duong vao tim em'),('Duong di hoc'),('Duong ve nha');

/*TABLE 2*/
INSERT INTO `Doan_duong` VALUES
('GL1','GL2','CD1',10,1),('GL2','GL4','CD1',10,2),
('GL1','GL8','CD2',1000,1),('GL1','GL3','CD3',100,1),
('GL3','GL5','CD3',100,2),('GL5','GL7','CD3',100,3),
('GL7','GL2','CD4',5,1),('GL2','GL1','CD4',5,2);

/*TABLE 4*/
INSERT INTO `Tuyen_tau_xe` VALUES
('B001'),('B002'),('B003'),('B004'),
('T001'),('T002'),('T003'),('T004');

/*TABLE 5*/
INSERT INTO `Tuyen_xe_bus`(`ma_tuyen_tau_xe`) VALUES
('B001'),('B002'),('B003'),('B004');

/*TABLE 6*/
INSERT INTO `Tuyen_tau_dien` VALUES
('A','Tau A',10000,'T001'),('B','Tau B',15000,'T002'), 
('C','Tau C',20000,'T003'),('D','Tau D',25000,'T004');

/*TABLE 7*/
INSERT INTO `Chuyen_tau_xe` VALUES
('B001',1),('B001',2),('B002',1),('B002',2), 
('B003',1),('B003',2),('B004',1),('B004',2),                            
('T001',1),('T001',2),('T002',1),('T002',2), 
('T003',1),('T003',2),('T004',1),('T004',2);

/*TABLE 8*/
INSERT INTO `Ga_tram` VALUES
('BT00001','Dia chi 1','Tram BT 1',0,'GL1','GL2'),
('BT00002','Dia chi 2','Tram BT 2',0,'GL2','GL4'),
('TT00001','Dia chi 3','Tram TT 1',1,'GL1','GL3'), 
('TT00002','Dia chi 4','Tram TT 2',1,'GL3','GL5');

/*TABLE 9*/
INSERT INTO `Chuyen_tau_xe_ghe_ga_tram` VALUES
('B001', 1, 'BT00001', 1, '10:10:00', '10:20:00'),
('B001', 1, 'BT00002', 2, '10:30:00', '10:40:00'),
('T001', 1, 'TT00001', 1, '10:10:00', '10:20:00'),
('T001', 1, 'TT00002', 2, '10:30:00', '10:40:00');

/*TABLE 16*/
INSERT INTO `Hanh_khach` VALUES
('KH000001','111111111','1231231231','teacher','F','teacher1@gmail.com','1990-01-01'),
('KH000002','222222222','0123123123','hihi','M','hihi2@gmail.com','1992-02-02'),
('KH000003','333333333','0123112123','hiihi','F','hiihi2@gmail.com','1992-02-02'),
('KH000004','444444444','0122123123','hiiihi','M','hiiiihi2@gmail.com','1992-02-02');

/*TABLE 10*/
INSERT INTO `Ve` VALUES
('VO1805202100001',0,0,'2021-05-18 10:00:00','KH000001'),
('VO1805202100002',0,0,'2021-05-18 10:00:00','KH000002'),
('VO2005202100001',0,0,'2021-05-20 10:00:00','KH000003'),
('VO2005202100002',0,0,'2021-05-20 10:00:00','KH000004'),

('VM1805202100001',1,0,'2021-05-18 10:00:00','KH000001'),
('VM1805202100002',1,0,'2021-05-18 10:00:00','KH000002'),
('VM2005202100001',1,0,'2021-05-20 10:00:00','KH000003'),
('VM2005202100002',1,0,'2021-05-20 10:00:00','KH000004'),

('VD1805202100001',2,0,'2021-05-18 10:00:00','KH000001'),
('VD1805202100002',2,0,'2021-05-18 10:00:00','KH000002'),
('VD2005202100001',2,0,'2021-05-20 10:00:00','KH000003'),
('VD2005202100002',2,0,'2021-05-20 10:00:00','KH000004');

/*TABLE 11*/
INSERT INTO `Ve_le` VALUES
('VO1805202100001','B001','2021-05-18','BT00001','BT00002','10:10:00','10:30:00'),
('VO1805202100002','T001','2021-05-18','TT00001','TT00002','10:10:00','10:30:00'),
('VO2005202100001','B001','2021-05-20','BT00001','BT00002','10:10:00','10:30:00'),
('VO2005202100002','T001','2021-05-20','TT00001','TT00002','10:10:00','10:30:00');
                
/*TABLE 12*/
INSERT INTO `Ve_thang` VALUES
('VM1805202100001','B001','BT00001','BT00002'),
('VM1805202100002','T001','TT00001','TT00002'),
('VM2005202100001','B001','BT00001','BT00002'),
('VM2005202100002','T001','TT00001','TT00002');

/*TABLE 13*/
INSERT INTO `Hoat_dong_ve_thang` VALUES
('VM1805202100001','2021-05-18','10:10:00','10:30:00','BT00001','BT00002'),
('VM1805202100002','2021-05-18','10:10:00','10:30:00','TT00001','TT00002'),
('VM2005202100001','2021-05-20','10:10:00','10:30:00','BT00002','BT00001'),
('VM2005202100002','2021-05-20','10:10:00','10:30:00','TT00002','TT00001');

/*TABLE 14*/
INSERT INTO `Ve_1_ngay` VALUES
('VD1805202100001','2021-05-18'),('VD1805202100002','2021-05-18'),
('VD2005202100001','2021-05-20'),('VD2005202100002','2021-05-20');

/*TABLE 15*/
INSERT INTO `Hoat_dong_cua_ve_1_ngay`(`ma_ve`,`ma_tuyen`,`ma_ga_tram_len`,`ma_ga_tram_xuong`,`gio_len`,`gio_xuong`) VALUES
('VD1805202100001','B001','BT00001','BT00002','10:10:00','10:30:00'),
('VD1805202100001','B001','BT00002','BT00001','10:30:00','10:50:00'),
('VD1805202100002','T001','TT00001','TT00002','10:10:00','10:30:00'),
('VD1805202100002','T001','TT00002','TT00001','10:30:00','10:50:00'),

('VD2005202100001','B001','BT00001','BT00002','10:10:00','10:30:00'),
('VD2005202100001','B001','BT00002','BT00001','10:30:00','10:50:00'),
('VD2005202100002','T001','TT00001','TT00002','10:10:00','10:30:00'),
('VD2005202100002','T001','TT00002','TT00001','10:30:00','10:50:00');

/*TABLE 18*/
INSERT INTO `Nhan_vien` VALUES
('NV0001','Giam sat','1993-03-03','nv1@gmail.com','F','0123412341','0123412342'),
('NV0002','Giam sat','1993-04-04','nv2@gmail.com','M','0123412343','0223412344'),
('NV0003','Giam sat','1993-04-04','nv2@gmail.com','F','0123112343','0123412344'),
('NV0004','Giam sat','1993-04-04','nv2@gmail.com','M','0123412243','0133412344');

/*TABLE 17*/
INSERT INTO `The_tu` VALUES
('TT000001','2021-05-18','KH000001'),('TT000002','2021-05-18','KH000002'),
('TT000003','2021-05-20','KH000002'),('TT000004','2021-05-20','KH000002');

/*TABLE 19*/
INSERT INTO `Ga_tram_lam_viec` VALUES
('NV0001','BT00001'),('NV0002','TT00001'),
('NV0003','BT00002'),('NV0004','TT00002');


