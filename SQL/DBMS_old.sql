CREATE DATABASE  IF NOT EXISTS `dbms`;
USE `dbms`;

/*TABlE 1*/
CREATE TABLE `Giao_lo` (
	`ma_giao_lo`	CHAR(6),
    `longitute`		REAL,
    `latitude`		REAL,

    PRIMARY KEY (`ma_giao_lo`)
);

/*TABLE 2*/
CREATE TABLE `Doan_duong` (
	`ma_giao_lo_1`	CHAR(6),
    `ma_giao_lo_2`	CHAR(6),
    `ma_con_duong`	CHAR(6),
    `chieu_dai`		INT UNSIGNED,
    `stt`			SMALLINT UNSIGNED,

    PRIMARY KEY (`ma_giao_lo_1`, `ma_giao_lo_2`)
);

/*TABLE 3*/
CREATE TABLE `Con_duong` (
	`ma_con_duong`	CHAR(6),
    `ten_duong`		VARCHAR(20),

    PRIMARY KEY (`ma_con_duong`)
);

/*TABLE 4*/
CREATE TABLE `Tuyen_tau_xe` (
	`ma_tuyen`		CHAR(4),	-- TODO: B001, T001
    
    PRIMARY KEY (`ma_tuyen`)
);

/*TABLE 5*/
CREATE TABLE `Tuyen_xe_bus` (
	`no`			    INT UNSIGNED AUTO_INCREMENT,
    `ma_tuyen_tau_xe`	CHAR(4),
    
    PRIMARY KEY (`no`)
);

/*TABLE 6*/
CREATE TABLE `Tuyen_tau_dien` (
	`ma_tuyen_tau`		CHAR,
    `ten_tuyen_tau`		VARCHAR(20)		NOT NULL	UNIQUE,
    `don_gia`			INT UNSIGNED,
    `ma_tuyen_tau_xe`	CHAR(4),
    
    PRIMARY KEY (`ma_tuyen_tau`)
);

/*TABLE 7*/
CREATE TABLE `Chuyen_tau_xe` (
	`ma_tuyen`			CHAR(4),
    `stt`				INT UNSIGNED,
    
    PRIMARY KEY (`ma_tuyen`, `stt`)
);

/*TABLE 8*/
CREATE TABLE `Ga_tram` (
	`ma_ga_tram`			CHAR(7),		-- TODO: BT00001, TT00001
    `dia_chi`				VARCHAR(30)		NOT NULL,
    `ten`					VARCHAR(30),
    `ga_tram`				BIT             NOT NULL,     -- 0: trạm xe bus, 1: ga tàu điện.
    `ma_giao_lo_1`		    CHAR(6),
    `ma_giao_lo_2`		    CHAR(6),
    
    PRIMARY KEY (`ma_ga_tram`)
);

/*TABLE 9*/
CREATE TABLE `Chuyen_tau_xe_ghe_ga_tram` (
	`ma_tuyen`		CHAR(4),
    `stt_tuyen`		INT UNSIGNED,
    `ma_ga_tram`	CHAR(7),		-- TODO: BT00001, TT00001
    `stt`			INT UNSIGNED,
    `gio_ghe`		TIME,	-- TODO: format HH:MI
    `gio_di`		TIME,	-- TODO: format HH:MI
    
    PRIMARY KEY (`ma_tuyen`, `stt_tuyen`, `ma_ga_tram`)
);

/*TABLE 10*/
CREATE TABLE `Ve` (
	`ma_ve`			CHAR(15),
    `loai_ve`		ENUM('0','1','2'),	-- TODO: 0 – vé lẻ, 1– vé tháng, 2 – vé một ngày.
    `gia_ve`		REAL,
    `ngay_gio_mua`	DATETIME,	-- TODO: format DD-MM-YYYY HH:MI:SS.
    `ma_hanh_khach`	CHAR(8),
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 11*/
CREATE TABLE `Ve_le` (
	`ma_ve`				CHAR(15),
    `ma_tuyen`			CHAR(4),
    `ngay_su_dung`		DATE,		-- TODO: format DD-MM-YYYY
    `ma_ga_tram_len`	CHAR(7),		-- TODO: BT00001, TT00001
    `ma_ga_tram_xuong`	CHAR(7),		-- TODO: BT00001, TT00001
    `gio_len`			TIME,	-- TODO: format HH:MI:SS
    `gio_xuong`			TIME,	-- TODO: format HH:MI:SS
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 12*/
CREATE TABLE `Ve_thang` (
	`ma_ve`				CHAR(15),
    `ma_tuyen`			CHAR(4),
	`ma_ga_tram_1`		CHAR(7),		-- TODO: BT00001, TT00001
    `ma_ga_tram_2`		CHAR(7),		-- TODO: BT00001, TT00001
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 13*/
CREATE TABLE `Hoat_dong_ve_thang` (
	`ma_ve`				CHAR(15),
    `ngay_su_dung`		DATE,			-- TODO: kiểu DATE có dạng DD-MM-YYYY
    `gio_len`			TIME,			-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên.
    `gio_xuong`			TIME,			-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên.
    `ga_tram_len`		CHAR(7),		-- TODO: BT00001, TT00001
    `ga_tram_xuong`		CHAR(7),		-- TODO: BT00001, TT00001
    
    PRIMARY KEY (`ma_ve`, `ngay_su_dung`, `gio_len`)
);

/*TABLE 14*/
CREATE TABLE `Ve_1_ngay` (
	`ma_ve`				CHAR(15),
    `ngay_su_dung`		DATE, 			-- TODO: kiểu DATE có dạng DD-MM-YYYY
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 15*/
CREATE TABLE `Hoat_dong_cua_ve_1_ngay` (
	`ma_ve`				CHAR(15) NOT NULL,
    `stt`				INT NOT NULL AUTO_INCREMENT,
    `ma_tuyen`			CHAR(4),
    `ma_ga_tram_len`	CHAR(7),			-- TODO: BT00001, TT00001
    `ma_ga_tram_xuong`	CHAR(7),			-- TODO: BT00001, TT00001
    `gio_len`			TIME,				-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên
    `gio_xuong`			TIME,				-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên
    
    PRIMARY KEY (`ma_ve`, `stt`)
) ENGINE=MyISAM;

/*TABLE 16*/
CREATE TABLE `Hanh_khach` (
	`ma_hanh_khach`		CHAR(8),	-- TODO: KH[0-9][0-9][0-9] [0-9][0-9][0-9]. Ví dụ: KH000001 KH000002,…
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
	`ma_the_tu`			CHAR(8),    -- TODO: TT[0-9][0-9][0-9][0-9][0-9][0-9].Ví dụ: TT000001,TT000002
    `ngay_mua`			DATETIME,	-- TODO: DD-MM-YYYY HH:MI:SS
    `ma_hanh_khach`		CHAR(8),
    
    PRIMARY KEY (`ma_the_tu`)
);

/*TABLE 18*/
CREATE TABLE `Nhan_vien` (
	`ma_nhan_vien`		    CHAR(6),		-- TODO: NV0001, NV0002,…
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
	`ma_nhan_vien`		CHAR(6),		-- TODO: NV0001, NV0002,…
    `ma_ga_tram`		CHAR(7),		-- TODO: BT00001, TT00001
    
    PRIMARY KEY (`ma_nhan_vien`)
);


/*TABLE 20*/
CREATE  TABLE `Bang_gia` (
    `don_gia_xe_bus`            INT UNSIGNED NOT NULL,
    `gia_ve_1_ngay_trong_tuan`  INT UNSIGNED NOT NULL,
    `gia_ve_1_ngay_cuoi_tuan`   INT UNSIGNED NOT NULL,
    `integrity_keeper`          ENUM('') NOT NULL,

    PRIMARY KEY (`integrity_keeper`)
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
CREATE TABLE `Giao_lo_seq`
(
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);
DELIMITER $$
CREATE TRIGGER `tg_giao_lo_before_insert` BEFORE INSERT ON `Giao_lo`
FOR EACH ROW
BEGIN
  INSERT INTO `Giao_lo_seq` VALUES (NULL);
  SET NEW.`ma_giao_lo` = CONCAT('GL', LAST_INSERT_ID());
END$$
-- CREATE TRIGGER `tg_giao_lo_before_delete` BEFORE DELETE ON `Giao_lo`
-- FOR EACH ROW
-- BEGIN
--   DELETE FROM `` WHERE `id`=SUBSTR(NEW.`ma_giao_lo`, 2)
-- END$$
DELIMITER ;

/*TABLE 3*/
CREATE TABLE `Con_duong_seq`
(
  `id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);
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
/*
*   2.1.2
*/


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

/*TABLE 13*/
/*
*   2.1.1
*/
DELIMITER $$
CREATE TRIGGER `tg_hoat_dong_ve_thang_before_insert` BEFORE INSERT ON `Hoat_dong_ve_thang`
FOR EACH ROW
BEGIN
    DECLARE `tram_1` CHAR(7);
    DECLARE `tram_2` CHAR(7);
    -- SELECT `tram_1` = `ma_ga_tram_1`, `tram_2` = `ma_ga_tram_2` FROM `Ve_thang` AS `V` WHERE   `V`.`ma_ve` = NEW.`ma_ve`;
    SET `tram_1` = (SELECT `ma_ga_tram_1` FROM `Ve_thang` AS `V` WHERE `V`.`ma_ve` = NEW.`ma_ve`);
    SET `tram_2` = (SELECT `ma_ga_tram_2` FROM `Ve_thang` AS `V` WHERE `V`.`ma_ve` = NEW.`ma_ve`);
    IF ((`tram_1` = NEW.`ga_tram_len` AND `tram_2` = NEW.`ga_tram_len`) OR
        (`tram_2` = NEW.`ga_tram_len` AND `tram_1` = NEW.`ga_tram_len`)) THEN 
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


/**
***		INSERT DATA
**/

/*TABLE 20*/
INSERT INTO `Bang_gia` (`don_gia_xe_bus`,`gia_ve_1_ngay_trong_tuan`,`gia_ve_1_ngay_cuoi_tuan`)
    VALUES (5000,30000,40000) ON DUPLICATE KEY 
    UPDATE `don_gia_xe_bus`=5000,`gia_ve_1_ngay_trong_tuan`=30000,`gia_ve_1_ngay_cuoi_tuan`=40000;

/*TABLE 1*/
INSERT INTO `Giao_lo` (`longitute`, `latitude`) VALUES (0,0),(2,2),(2,0),(3,3),(3,5),(4,2),(4,5),(5,5);

/*TABLE 3*/
INSERT INTO `Con_duong` (`ten_duong`) VALUES ('Duong doi'), ('Duong vao tim em'), ('Duong di hoc'), ('Duong ve nha');

/*TABLE 2*/
INSERT INTO `Doan_duong` VALUES ('GL1', 'GL2', 'CD1', 10, 1), ('GL2', 'GL4', 'CD1', 10, 2);
INSERT INTO `Doan_duong` VALUES ('GL1', 'GL8', 'CD2', 1000, 1);
INSERT INTO `Doan_duong` VALUES ('GL1', 'GL3', 'CD3', 100, 1), ('GL3', 'GL5', 'CD3', 100, 2), ('GL5', 'GL7', 'CD3', 100, 3);
INSERT INTO `Doan_duong` VALUES ('GL7', 'GL2', 'CD1', 5, 1), ('GL2', 'GL1', 'CD1', 5, 2);

/*TABLE 4*/
INSERT INTO `Tuyen_tau_xe` VALUES ('B001'),('B002'),('B003'),('T001'),('T002'),('T003');

/*TABLE 5*/
INSERT INTO `Tuyen_xe_bus` (`ma_tuyen_tau_xe`) VALUES ('B001'),('B002'),('B003');

/*TABLE 6*/
INSERT INTO `Tuyen_tau_dien` VALUES ('A', 'Tau A', 10, 'T001'), ('B', 'Tau B', 15, 'T002'), ('C', 'Tau C', 20, 'T003');

/*TABLE 7*/
INSERT INTO `Chuyen_tau_xe` VALUES  ('B001', 1), ('B001', 2), ('B002', 1), ('B002', 2), ('B003', 1), ('B003', 2),
                                    ('T001', 1), ('T001', 2), ('T002', 1), ('T002', 2), ('T003', 1), ('T003', 2);

/*TABLE 8*/
INSERT INTO `Ga_tram` VALUES ('BT00001', 'Dia chi 1', 'Tram BT 1', 0, 'GL1', 'GL2'), ('BT00002', 'Dia chi 2', 'Tram BT 2', 0, 'GL2', 'GL4'),
                             ('TT00001', 'Dia chi 3', 'Tram TT 1', 1, 'GL1', 'GL3'), ('TT00002', 'Dia chi 4', 'Tram TT 2', 1, 'GL3', 'GL5');

/*TABLE 9*/
INSERT INTO `Chuyen_tau_xe_ghe_ga_tram` VALUES  ('B001', 1, 'BT00001', 1, '10:10:00', '10:20:00'),
                                                ('B001', 1, 'BT00002', 2, '10:30:00', '10:40:00'),
                                                ('T001', 1, 'TT00001', 1, '10:10:00', '10:20:00'),
                                                ('T001', 1, 'TT00002', 2, '10:30:00', '10:40:00');

/*TABLE 16*/
INSERT INTO `Hanh_khach` VALUES ('KH000001', '111111111', '1231231231', 'teacher', 'F', 'teacher1@gmail.com', '1990-01-01'),
                                ('KH000002', '222222222', '0123123123', 'hihi', 'M', 'hihi2@gmail.com', '1992-02-02');

/*TABLE 10*/
INSERT INTO `Ve` VALUES ('VO1805202100001', '0', 10, '2021-05-18 10:00:00', 'KH000001'),
                        ('VO1805202100002', '0', 10, '2021-05-18 10:00:00', 'KH000002'),
                        ('VM1805202100001', '1', 250, '2021-05-18 10:00:00', 'KH000001'),
                        ('VM1805202100002', '1', 250, '2021-05-18 10:00:00', 'KH000002'),
                        ('VD1805202100001', '2', 30, '2021-05-18 10:00:00', 'KH000001'),
                        ('VD1805202100002', '2', 30, '2021-05-18 10:00:00', 'KH000002');

/*TABLE 11*/
INSERT INTO `Ve_le` VALUES  ('VO1805202100001', 'B001', '2021-05-18', 'BT00001', 'BT00002', '10:10:00', '10:30:00'),
                            ('VO1805202100002', 'T001', '2021-05-18', 'TT00001', 'TT00002', '10:10:00', '10:30:00');
                
/*TABLE 12*/
INSERT INTO `Ve_thang` VALUES   ('VM1805202100001', 'B001', 'BT00001', 'BT00002'),
                                ('VM1805202100002', 'T001', 'TT00001', 'TT00002');

/*TABLE 13*/
INSERT INTO `Hoat_dong_ve_thang` VALUES ('VM1805202100001', '2021-05-18', '10:10:00', '10:30:00', 'BT00001', 'BT00002'),
                                        ('VM1805202100002', '2021-05-18', '10:10:00', '10:30:00', 'TT00001', 'TT00002');

/*TABLE 14*/
INSERT INTO `Ve_1_ngay` VALUES   ('VD1805202100001', '2021-05-18'),
                                ('VD1805202100002', '2021-05-18');

/*TABLE 15*/
INSERT INTO `Hoat_dong_cua_ve_1_ngay` (`ma_ve`, `ma_tuyen`, `ma_ga_tram_len`, `ma_ga_tram_xuong`, `gio_len`, `gio_xuong`) 
VALUES  ('VD1805202100001', 'B001', 'BT00001', 'BT00002', '10:10:00', '10:30:00'),
        ('VD1805202100001', 'B001', 'BT00002', 'BT00001', '10:30:00', '10:50:00'),
        ('VD1805202100002', 'T001', 'TT00001', 'TT00002', '10:10:00', '10:30:00'),
        ('VD1805202100002', 'T001', 'TT00002', 'TT00001', '10:30:00', '10:50:00');

/*TABLE 17*/
INSERT INTO `The_tu` VALUES ('TT000001', '2021-05-18', 'KH000001'),
                            ('TT000002', '2021-05-18', 'KH000002');

/*TABLE 18*/
INSERT INTO `Nhan_vien` VALUES ('NV0001', 'Giam sat', '1993-03-03', 'nv1@gmail.com', 'F', '0123412341', '0123412342'),
                                ('NV0002', 'Giam sat', '1993-04-04', 'nv2@gmail.com', 'M', '0123412343', '0123412344');

/*TABLE 19*/
INSERT INTO `Ga_tram_lam_viec` VALUES   ('NV0001', 'BT00001'),
                                        ('NV0002', 'TT00001');

/*
*   2.2.2
*/
DELIMITER $$
CREATE PROCEDURE `ThongKeLuotNguoi` (`ma_tuyen` VARCHAR(4), `tu_ngay` DATE, `toi_ngay` DATE)
BEGIN

END; 
$$
DELIMITER ;

select count(a.ma_ve), a.ngay_su_dung
from (
    select v1.ma_ve, v1.ngay_su_dung 
    from Ve_1_ngay as v1 
    join Hoat_dong_cua_ve_1_ngay as v2 
    on v1.ma_ve = v2.ma_ve 
    where v2.ma_tuyen = @ma_tuyen and ngay_su_dung between @date1 and @date2
    union all
    select ma_ve, ngay_su_dung
    from Ve_le
    where ma_tuyen = @ma_tuyen and  ngay_su_dung between @date1 and @date2
    union all
    select v1.ma_ve, v2.ngay_su_dung 
    from Ve_thang as v1 
    join Hoat_dong_ve_thang as v2 
    on v1.ma_ve = v2.ma_ve 
    where v1.ma_tuyen = @ma_tuyen and v2.ngay_su_dung between @date1 and @date2
) as a
group by a.ngay_su_sung;
/*
-- 2 cach giai quyet van de voi trigger can thong nhat lai chi dung 1 cach
*/