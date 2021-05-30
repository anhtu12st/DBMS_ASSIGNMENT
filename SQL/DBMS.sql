CREATE DATABASE  IF NOT EXISTS `sql6413136`;
USE `sql6413136`;

/*TABlE 1*/
CREATE TABLE `Giao_lo` (
	`ma_giao_lo`	CHAR(6),	-- TODO: change to display GL[ma_giao_lo]
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
    /*TODO: add FK ma_giao_lo_1-2 ma_con_duong*/
);

/*TABLE 3*/
CREATE TABLE `Con_duong` (
	`ma_con_duong`	CHAR(6),		-- TODO: CD[số nguyên tự động tăng]. CD1, CD2,…
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
    `ma_tuyen_tau_xe`	CHAR(4),	-- TODO: Mã tuyến tàu/xe: khoá ngoại tham khảo đến Tuyến tàu/xe (Mã tuyến)
    
    PRIMARY KEY (`no`)
);

/*TABLE 6*/
CREATE TABLE `Tuyen_tau_dien` (
	`ma_tuyen_tau`		CHAR,
    `ten_tuyen_tau`		VARCHAR(20)		NOT NULL	UNIQUE,
    `ma_tuyen_tau_xe`	CHAR(4), 	-- TODO: khoá ngoại tham khảo đến Tuyến tàu/xe (Mã tuyến).(Những mã tuyến bắt đầu bằng “T”)
    
    PRIMARY KEY (`ma_tuyen_tau`)
);

/*TABLE 7*/
CREATE TABLE `Chuyen_tau_xe` (
	`ma_tuyen`			CHAR(4),
    /*TODO: FK reference to Tuyen_tau_xe(Ma_tuyen)*/
    `stt`				INT UNSIGNED,
    
    PRIMARY KEY (`ma_tuyen`, `stt`)
);

/*TABLE 8*/
CREATE TABLE `Ga_tram` (
	`ma_ga_tram`			CHAR(7),		-- TODO: BT00001, TT00001
    /*TODO: [BT|TT] [0-9][0-9][0-9][0-9][0-9]. vd: BT00001, TT00001.*/
    `dia_chi`				VARCHAR(30)		NOT NULL,
    `ga_tram`				BIT				NOT NULL, -- 0: trạm xe bus, 1: ga tàu điện.
    `ma_giao_lo_1`		    CHAR(6),
    `ma_giao_lo_2`		    CHAR(6),
    /*TODO: Mã giao lộ 1, mã giao lộ 2: khoá ngoại tham khảo đến Đoạn đường*/
    
    PRIMARY KEY (`ma_ga_tram`)
);

/*TABLE 9*/
CREATE TABLE `Chuyen_tau_xe_ghe_ga_tram` (
	`ma_tuyen`		CHAR(4),		-- TODO: khoá ngoại tham khảo đến Chuyến tàu/xe (Mã tuyến, STT)
    `stt_tuyen`		INT UNSIGNED,
    `ma_ga_tram`	CHAR(7),		-- TODO: BT00001, TT00001 - khoá ngoại tham khảo đến Ga/trạm (Mã ga/trạm)
    `stt`			INT UNSIGNED,
    `gio_ghe`		TIME,	-- TODO: format HH:MI
    `gio_di`		TIME,	-- TODO: format HH:MI
    
    PRIMARY KEY (`ma_tuyen`, `stt_tuyen`, `ma_ga_tram`)
);

/*TABLE 10*/
CREATE TABLE `Ve` (
	`ma_ve`			CHAR(15),
    `loai_ve`		SMALLINT,	-- TODO: 0 – vé lẻ, 1– vé tháng, 2 – vé một ngày.
    `gia_ve`		REAL,
    `ngay_gio_mua`	DATETIME,	-- TODO: format DD-MM-YYYY HH:MI:SS.
    `ma_hanh_khach`	CHAR(8),
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 11*/
CREATE TABLE `Ve_le` (
	`ma_ve`				CHAR(15),	-- TODO: khoá ngoại tham khảo đến Vé (mã vé)
    `ma_tuyen`			CHAR(4),	-- TODO: khoá ngoại tham khảo đến Tuyến tàu/xe (Mã tuyến).
    `ngay_su_dung`		DATE,		-- TODO: format DD-MM-YYYY
    `ma_ga_tram_len`	CHAR(7),		-- TODO: BT00001, TT00001 - khoá ngoại tham khảo đến Ga/trạm (Mã ga/trạm)
    `ma_ga_tram_xuong`	CHAR(7),		-- TODO: BT00001, TT00001 - khoá ngoại tham khảo đến Ga/trạm (Mã ga/trạm)
    `gio_len`			TIME,	-- TODO: format HH:MI:SS
    `gio_xuong`			TIME,	-- TODO: format HH:MI:SS
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 12*/
CREATE TABLE `Ve_thang` (
	`ma_ve`				CHAR(15),		-- TODO: khoá ngoại tham khảo đến Vé (mã vé)
    `ma_tuyen`			CHAR(4),		-- TODO: khoá ngoại tham khảo đến Tuyến tàu/xe (Mã tuyến).
	`ma_ga_tram_1`		CHAR(7),		-- TODO: BT00001, TT00001 - khoá ngoại tham khảo đến Ga/trạm (Mã ga/trạm)
    `ma_ga_tram_2`		CHAR(7),		-- TODO: BT00001, TT00001 - khoá ngoại tham khảo đến Ga/trạm (Mã ga/trạm)
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 13*/
CREATE TABLE `Hoat_dong_ve_thang` (
	`ma_ve`				CHAR(15),		-- TODO: khoá ngoại tham khảo đến Vé tháng (mã vé).
    `ngay_su_dung`		DATE,			-- TODO: kiểu DATE có dạng DD-MM-YYYY
    `gio_len`			TIME,			-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên.
    `gio_xuong`			TIME,			-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên.
    `ga_tram_len`		CHAR(7),		-- TODO: BT00001, TT00001 - khoá ngoại tham khảo đến Ga/trạm (Mã ga/trạm)
    `ga_tram_xuong`		CHAR(7),		-- TODO: BT00001, TT00001 - khoá ngoại tham khảo đến Ga/trạm (Mã ga/trạm)
    
    PRIMARY KEY (`ma_ve`, `ngay_su_dung`, `gio_len`)
);

/*TABLE 14*/
CREATE TABLE `Ve_1_ngay` (
	`ma_ve`				CHAR(15),		-- TODO: khoá ngoại tham khảo đến Vé (mã vé). (Những mã vé bắt đầu bằng “VD”)
    `ngay_su_dung`		DATE, 			-- TODO: kiểu DATE có dạng DD-MM-YYYY
    
    PRIMARY KEY (`ma_ve`)
);

/*TABLE 15*/
CREATE TABLE `Hoat_dong_cua_ve_1_ngay` (
	`ma_ve`				CHAR(15),			-- TODO: khoá ngoại tham khảo đến Vé 1 ngày (mã vé).
    `stt`				SMALLINT UNSIGNED,
    `ma_tuyen`			CHAR(4),			-- TODO: khoá ngoại tham khảo đến Tuyến tàu/xe (Mã tuyến).
    `ma_ga_tram_len`	CHAR(7),			-- TODO: BT00001, TT00001 - khoá ngoại tham khảo đến Ga/trạm (Mã ga/trạm)
    `ma_ga_tram_xuong`	CHAR(7),			-- TODO: BT00001, TT00001 - khoá ngoại tham khảo đến Ga/trạm (Mã ga/trạm)
    `gio_len`			TIME,				-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên
    `gio_xuong`			TIME,				-- TODO: kiểu TIME có dạng HH:MI:SS. Giờ xuống phải trễ hơn giờ lên
    
    PRIMARY KEY (`ma_ve`, `stt`)
);

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
	`ma_the_tu`			CHAR(8),
    `ngay_mua`			DATETIME,	-- TODO: DD-MM-YYYY HH:MI:SS
    `ma_hanh_khach`		CHAR(8),	-- TODO: khoá ngoại tham khảo đến Hành khách (Mã hành khách)
    
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


/*TABLE 20*/ -- DON'T KNOW WTF IS IT
/*
CREATE TABLE Bang_gia (
- Bảng giá (đơn giá xe bus, giá vé 1 ngày trong tuần, giá vé 1 ngày cuối tuần)
	▪ Bảng này được thêm vào để phục vụ việc tính toán phía sau. Chỉ bao gồm 1 record để quy định
	một số đơn giá/giá vé cố định hiện tại. Ví du: 1 record của bảng chứa các giá trị cho 3 cột lần lượt
	là: 5.000, 30.000, 40.000 có nghĩa đơn giá cho xe bus là 5.000, giá vé 1 ngày trong tuần là 30.000,
	giá vé 1 ngày cuối tuần/ ngày nghỉ là 40.000.
);
*/

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

