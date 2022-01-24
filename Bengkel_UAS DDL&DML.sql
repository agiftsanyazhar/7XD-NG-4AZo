/* ==================================================
 * ================= Create Database ================
 * ==================================================
 */
CREATE DATABASE Bengkel_UAS;

/* ==================================================
 * ================= Create Table ===================
 * ==================================================
 */
CREATE TABLE Tipe_Kendaraan(
id_tipe CHAR(4),
nama_tipe VARCHAR(100) NOT NULL,
CONSTRAINT tk_idtipe_pk PRIMARY KEY (id_tipe)
);

CREATE TABLE Admin(
id_admin VARCHAR(7) NOT NULL,
nama_admin VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
PASSWORD VARCHAR(32) NOT NULL,
CONSTRAINT pmlk_idpemilik_pk PRIMARY KEY (id_admin)
);

CREATE TABLE Pemilik(
id_pemilik VARCHAR(7) NOT NULL,
id_user INT NOT NULL,
nama_pemilik VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
PASSWORD VARCHAR(32),
alamat_pemilik VARCHAR(100) NOT NULL,
telp_pemilik VARCHAR(15) UNIQUE NOT NULL,
CONSTRAINT pmlk_idpemilik_pk PRIMARY KEY (id_pemilik)
);

CREATE TABLE Jabatan(
id_jabatan CHAR(1),
nama_jabatan VARCHAR(100) NOT NULL,
gaji_pokok INT NOT NULL,
tunjangan INT NOT NULL,
CONSTRAINT jbt_idjabatan_pk PRIMARY KEY (id_jabatan)
);

CREATE TABLE Suku_Cadang(
id_suku_cadang VARCHAR(20),
nama_suku_cadang VARCHAR(100) NOT NULL,
gambar_suku_cadang TEXT,
stok INT NOT NULL,
harga_satuan INT NOT NULL,
CONSTRAINT sc_idsukucadang_pk PRIMARY KEY (id_suku_cadang)
);

CREATE TABLE Nota_Suku_Cadang(
no_nota_suku_cadang VARCHAR(7),
tgl_nota_suku_cadang DATE NOT NULL,
CONSTRAINT nsc_nonotasukucadang_pk PRIMARY KEY (no_nota_suku_cadang)
);

CREATE TABLE USER(
id_user INT NOT NULL AUTO_INCREMENT,
id_jabatan CHAR(1) NOT NULL,
nama VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
PASSWORD VARCHAR(32) NOT NULL,
role VARCHAR(20) NOT NULL,
alamat VARCHAR(100),
telp VARCHAR(15) UNIQUE,
CONSTRAINT usr_iduser_pk PRIMARY KEY (id_user),
CONSTRAINT usr_idjabatan_fk FOREIGN KEY (id_jabatan)
	REFERENCES Jabatan(id_jabatan)
);

CREATE TABLE Kendaraan(
no_stnk VARCHAR(10),
id_pemilik VARCHAR(7) NOT NULL,
id_tipe CHAR(4) NOT NULL,
no_mesin VARCHAR(14) NOT NULL,
no_rangka VARCHAR(18) NOT NULL,
tahun INT NOT NULL,
warna VARCHAR(10) NOT NULL,
CONSTRAINT kndr_nostnk_pk PRIMARY KEY (no_stnk),
CONSTRAINT kndr_idpemilik_fk FOREIGN KEY (id_pemilik)
	REFERENCES Pemilik(id_pemilik),
CONSTRAINT kndr_idtipe_fk FOREIGN KEY (id_tipe)
	REFERENCES Tipe_Kendaraan(id_tipe)
);

CREATE TABLE Pegawai(
id_pegawai VARCHAR(7) NOT NULL,
id_jabatan CHAR(1) NOT NULL,
nama_pegawai VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
PASSWORD VARCHAR(32) NOT NULL,
alamat_pegawai VARCHAR(100) NOT NULL,
telp_pegawai VARCHAR(15) UNIQUE NOT NULL,
CONSTRAINT pgw_idpegawai_pk PRIMARY KEY (id_pegawai),
CONSTRAINT pgw_idjabatan_fk FOREIGN KEY (id_jabatan)
	REFERENCES Jabatan(id_jabatan)
);

CREATE TABLE PKB(
id_pkb VARCHAR(6),
no_stnk VARCHAR(10) NOT NULL,
id_pegawai VARCHAR(7) NOT NULL,
no_nota_suku_cadang VARCHAR(7) NOT NULL,
tgl_pesan DATE NOT NULL,
jam_pesan TIME NOT NULL,
STATUS BOOL,
CONSTRAINT pkb_idpkb_pk PRIMARY KEY (id_pkb),
CONSTRAINT pkb_nostnk_fk FOREIGN KEY (no_stnk)
	REFERENCES Kendaraan(no_stnk),
CONSTRAINT pkb_idpegawai_fk FOREIGN KEY (id_pegawai)
	REFERENCES Pegawai(id_pegawai),
CONSTRAINT pkb_nonotasukucadang_fk FOREIGN KEY (no_nota_suku_cadang)
	REFERENCES Nota_Suku_Cadang(no_nota_suku_cadang),
CONSTRAINT pkb_idpembayaran_fk FOREIGN KEY (no_nota_suku_cadang)
	REFERENCES Nota_Suku_Cadang(no_nota_suku_cadang)
);

CREATE TABLE Detail_Nota_Suku_Cadang(
no_nota_suku_cadang VARCHAR(7),
id_suku_cadang VARCHAR(20),
nama_suku_cadang VARCHAR(100) NOT NULL,
harga_satuan INT NOT NULL,
banyak INT NOT NULL,
CONSTRAINT dncs_nonotascidsc_pk PRIMARY KEY (no_nota_suku_cadang,id_suku_cadang),
CONSTRAINT dnsc_notasukucadang_fk FOREIGN KEY(no_nota_suku_cadang)
	REFERENCES Nota_Suku_Cadang(no_nota_suku_cadang),
CONSTRAINT dnsc_idsc_fk FOREIGN KEY (id_suku_cadang)
	REFERENCES Suku_Cadang(id_suku_cadang)
);

CREATE TABLE Pembayaran(
id_pembayaran VARCHAR(15),
id_pkb VARCHAR(6) NOT NULL,
tgl_bayar DATE,
jam_bayar TIME,
total_harga INT NOT NULL,
bukti_pembayaran TEXT,
CONSTRAINT byr_idpembayaran_pk PRIMARY KEY (id_pembayaran),
CONSTRAINT byr_idpkb_fk FOREIGN KEY (id_pkb)
	REFERENCES PKB(id_pkb)
);

INSERT INTO Tipe_Kendaraan VALUES ('3021', 'MPV');
UPDATE Tipe_Kendaraan
SET Nama_Tipe='SUV'
WHERE ID_Tipe='3021';
DELETE FROM Pemilik
WHERE ID_Pemilik='3021';

INSERT INTO Pemilik VALUES ('152011', 'Luthfiyah Nur Arofah', 'luthfiyah@gmail.com', '12345678', 'Ki. Dr. Junjunan No. 80, Sibolga 87726, Papua', '087840910959');
INSERT INTO Pemilik VALUES ('152012', 'Muhammad Faishal Hafizh Mumtaz Galip', 'luthfiyah@gmail.com', '12345678', 'Gg. Suryo Pranoto No. 977, Padangsidempuan 52465, Malut', '086384623152');
INSERT INTO Pemilik VALUES ('152013', 'Novira Damayanti Rahma', 'luthfiyah@gmail.com', '12345678', 'Gg. Basoka Raya No. 491, Pangkal Pinang 61103, Sulsel', '081399883709');
INSERT INTO Pemilik VALUES ('152014', 'Adhiba Alya Firdaus', 'luthfiyah@gmail.com', '12345678', 'Dk. Bakti No. 614, Manado 55588, Kalsel', '081278071103');
INSERT INTO Pemilik VALUES ('152015', 'Ilham Dwi Kurniawan', 'luthfiyah@gmail.com', '12345678', 'Gg. Pasteur No. 925, Pagar Alam 60909, Sulbar', '083423256005');
UPDATE Pemilik
SET Telp_Pemilik='08123456789'
WHERE ID_Pemilik='152011';
DELETE FROM Pemilik
WHERE ID_Pemilik='152011';

DELETE FROM admin
WHERE ID_admin='A-0001';


/* ==================================================
 * ================= Create Seqbar ==================
 * ==================================================
 */
CREATE TABLE seqbar_admin
(
barcount INT NOT NULL AUTO_INCREMENT,
CONSTRAINT seqbar_barcount_pk PRIMARY KEY (barcount)
); 
 
CREATE TABLE seqbar_pegawai
(
barcount INT NOT NULL AUTO_INCREMENT,
CONSTRAINT seqbar_barcount_pk PRIMARY KEY (barcount)
);

CREATE TABLE seqbar_pemilik
(
barcount INT NOT NULL AUTO_INCREMENT,
CONSTRAINT seqbar_barcount_pk PRIMARY KEY (barcount)
);

/*
CREATE TABLE seqbar_user
(
barcount INT NOT NULL AUTO_INCREMENT,
CONSTRAINT seqbar_barcount_pk PRIMARY KEY (barcount)
);
*/

CREATE TABLE seqbar_nsc
(
barcount INT NOT NULL AUTO_INCREMENT,
CONSTRAINT seqbar_barcount_pk PRIMARY KEY (barcount)
);

/*
CREATE TABLE seqbar_dnsc
(
barcount INT NOT NULL AUTO_INCREMENT,
CONSTRAINT seqbar_barcount_pk PRIMARY KEY (barcount)
);
*/

CREATE TABLE seqbar_pkb
(
barcount INT NOT NULL AUTO_INCREMENT,
CONSTRAINT seqbar_barcount_pk PRIMARY KEY (barcount)
);

CREATE TABLE seqbar_pembayaran
(
barcount INT NOT NULL AUTO_INCREMENT,
CONSTRAINT seqbar_barcount_pk PRIMARY KEY (barcount)
);

/* ==================================================
 * ================= Create Trigger =================
 * ==================================================
 */
DELIMITER $$
CREATE OR REPLACE TRIGGER before_insert_admin
BEFORE INSERT ON Admin
FOR EACH ROW
BEGIN
	INSERT INTO seqbar_admin VALUES (NULL);
	
	SET new.id_admin = CONCAT('ADM-',LPAD(LAST_INSERT_ID(), 3, '0'));
END $$
DELIMITER ; 
 
DELIMITER $$
CREATE OR REPLACE TRIGGER before_insert_pegawai
BEFORE INSERT ON Pegawai
FOR EACH ROW
BEGIN
	INSERT INTO seqbar_pegawai VALUES (NULL);
	
	SET new.id_pegawai = CONCAT('PEG-',LPAD(LAST_INSERT_ID(), 3, '0'));
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE TRIGGER before_insert_pemilik
BEFORE INSERT ON Pemilik
FOR EACH ROW
BEGIN
	INSERT INTO seqbar_pemilik VALUES (NULL);
	
	SET new.id_pemilik = CONCAT('PEM-',LPAD(LAST_INSERT_ID(), 3, '0'));
END $$
DELIMITER ;

/*
DELIMITER $$
CREATE OR REPLACE TRIGGER before_insert_user
BEFORE INSERT ON user
FOR EACH ROW
BEGIN
	INSERT INTO seqbar_user VALUES (NULL);
	
	SET new.id_user = CONCAT('PEM-',LPAD(LAST_INSERT_ID(), 3, '0'));
END $$
DELIMITER ;
*/

/*
DELIMITER $$
CREATE OR REPLACE TRIGGER before_insert_user
BEFORE INSERT ON User
FOR EACH ROW
BEGIN
	declare temp_role varchar(20);
	
	INSERT INTO seqbar_user VALUES (NULL);
	
	SELECT role INTO temp_role
	FROM user
	WHERE id_user = new.id_user;
	
	IF (temp_role = 'admin') THEN
		SET new.id_user = CONCAT('ADM-',LPAD(LAST_INSERT_ID(), 3, '0'));
		insert into admin (id_admin, nama_admin, email, password) values (new.id_user, new.nama, new.email, new.password);
	ELSEif (temp_role = 'pegawai') then
		SET new.id_user = CONCAT('PEG-',LPAD(LAST_INSERT_ID(), 3, '0'));
		INSERT INTO pegawai (id_pegawai, id_jabatan, nama_pegawai, email, PASSWORD, alamat_pegawai, telp_pegawai) VALUES (new.id_user, new.id_jabatan, new.nama, new.email, new.password, new.alamat, new.telp);
	ELSEif (temp_role = 'pemilik') then
		SET new.id_user = CONCAT('PEM-',LPAD(LAST_INSERT_ID(), 3, '0'));
		INSERT INTO pemilik VALUES (new.id_user, new.nama, new.email, new.password, new.alamat, new.telp);
	END IF;
	
END $$
DELIMITER ;
*/

DELIMITER $$
CREATE OR REPLACE TRIGGER before_insert_nsc
BEFORE INSERT ON Nota_Suku_Cadang
FOR EACH ROW
BEGIN
	INSERT INTO seqbar_nsc VALUES (NULL);
	
	SET new.no_nota_suku_cadang = CONCAT('NSC-',LPAD(LAST_INSERT_ID(), 3, '0'));
	SET new.tgl_nota_suku_cadang = SYSDATE();
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE TRIGGER after_insert_dnsc
AFTER INSERT ON Detail_Nota_Suku_Cadang
FOR EACH ROW
BEGIN
	UPDATE Suku_Cadang
	SET stok = stok-new.banyak
	WHERE id_suku_cadang = new.id_suku_cadang;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE TRIGGER before_insert_pkb
BEFORE INSERT ON PKB
FOR EACH ROW
BEGIN
	INSERT INTO seqbar_pkb VALUES (NULL);
	
	SET new.tgl_pesan = SYSDATE();
	SET new.jam_pesan = CURRENT_TIMESTAMP;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE TRIGGER before_insert_pembayaran
BEFORE INSERT ON Pembayaran
FOR EACH ROW
BEGIN
	INSERT INTO seqbar_pembayaran VALUES (NULL);
	
	SET new.id_pembayaran	= CONCAT('BYR-',DATE_FORMAT(SYSDATE(), '%d%m%Y'), LPAD(LAST_INSERT_ID(), 3, '0'));
	SET new.tgl_bayar	= SYSDATE();
	SET new.jam_bayar	= CURRENT_TIMESTAMP;
END $$
DELIMITER ;

/* ==================================================
 * ================= Create Function ================
 * ==================================================
 */
DELIMITER $$
CREATE OR REPLACE FUNCTION total(id_nsc VARCHAR(7))
RETURNS INT
BEGIN
	DECLARE hitung INT;
	SELECT SUM(dnsc.`banyak`*sc.`harga_satuan`) INTO hitung
	FROM Detail_Nota_Suku_Cadang dnsc JOIN Suku_Cadang sc ON dnsc.id_suku_cadang = sc.id_suku_cadang
	WHERE dnsc.no_nota_suku_cadang = id_nsc;
RETURN hitung;
END $$
DELIMITER ;

SELECT total('NSC-035');

/* ==================================================
 * ================= Create View ====================
 * ==================================================
 */ 
CREATE OR REPLACE VIEW billing_vu AS
	SELECT pkb.`id_pkb`, pkb.`no_nota_suku_cadang`, pem.nama_pemilik, pkb.`tgl_pesan`, pkb.`jam_pesan`, pkb.`status`
	FROM pkb pkb JOIN Kendaraan kdr
		     ON pkb.`no_stnk` = kdr.no_stnk
		     JOIN Pemilik pem
		     ON pem.id_pemilik = kdr.id_pemilik
	ORDER BY no_nota_suku_cadang DESC;

SELECT * FROM billing;

CREATE OR REPLACE VIEW detail_pesanan_vu AS
	SELECT pkb.`id_pkb`, pkb.`no_nota_suku_cadang`, pem.nama_pemilik, kdr.no_stnk, sc.id_suku_cadang, sc.nama_suku_cadang, sc.harga_satuan, dnsc.banyak, byr.total_harga, pkb.`tgl_pesan`, pkb.`jam_pesan`, byr.tgl_bayar, byr.jam_bayar, pkb.`status`
	FROM pkb pkb JOIN Kendaraan kdr
		     ON pkb.`no_stnk` = kdr.no_stnk
		     JOIN Pembayaran byr
		     ON byr.id_pkb = pkb.`id_pkb`
		     JOIN Pemilik pem
		     ON pem.id_pemilik = kdr.id_pemilik
		     JOIN Nota_Suku_Cadang nsc
		     ON nsc.no_nota_suku_cadang = pkb.`no_nota_suku_cadang`
		     JOIN Detail_Nota_Suku_Cadang dnsc
		     ON dnsc.no_nota_suku_cadang = nsc.no_nota_suku_cadang
		     JOIN Suku_Cadang sc
		     ON sc.id_suku_cadang = dnsc.id_suku_cadang
	ORDER BY no_nota_suku_cadang DESC;

SELECT * FROM detail_pesanan;

/* ==================================================
 * =================== Inject =======================
 * ==================================================
 */
INSERT INTO USER VALUES ('1', NULL, 'Administrator', 'administrator@gmail.com', 'password', 'admin', NULL, NULL);
INSERT INTO Admin
SELECT id_user, nama, email, PASSWORD FROM USER
ORDER BY id_user DESC LIMIT 1;

INSERT INTO Jabatan VALUES ('1', 'Kepala Bengkel', 10000000, 3000000);
INSERT INTO Jabatan VALUES ('2', 'Instruktur Servis', 9000000, 1500000);
INSERT INTO Jabatan VALUES ('3', 'Service Advisor', 80000000, 600000);
INSERT INTO Jabatan VALUES ('4', 'Koordinator THS', 70000000, 500000);
INSERT INTO Jabatan VALUES ('5', 'Mekanik', 60000000, 300000);

INSERT INTO USER VALUES ('2', '1', 'Nadya Lovita Sari', 'nadya@gmail.com', '12345678', 'pegawai', 'Krian', '08123454589');
INSERT INTO USER VALUES ('3', '2', 'Afifah Aghnia Mumtaz', 'afifah@gmail.com', '12345678', 'pegawai', 'Gubeng', '08123136789');
INSERT INTO USER VALUES ('4', '3', 'Muhammad Raihan Pradana', 'raihan@gmail.com', '12345678', 'pegawai', 'Taman', '08123458689');
INSERT INTO USER VALUES ('5', '4', 'Hamimma Talita Aulia', 'hamimma@gmail.com', '12345678', 'pegawai', 'Lida', '08123236789');
INSERT INTO USER VALUES ('6', '5', 'Pascallis Henoch Herutomo', 'pascallis@gmail.com', '12345678', 'pegawai', 'Bojonegoro', '084638273821');
INSERT INTO USER VALUES ('7', '5', 'Aryo Pandu Dwi Anggoro', 'pandu@gmail.com', '12345678', 'pegawai', 'Sepanjang', '086283742832');
INSERT INTO Pegawai
SELECT id_user, id_jabatan, nama, email, PASSWORD, alamat, telp FROM USER
ORDER BY id_user DESC LIMIT 6;
 
INSERT INTO Tipe_Kendaraan VALUES ('TK01', 'Scooter');
INSERT INTO Tipe_Kendaraan VALUES ('TK02', 'CUB');
INSERT INTO Tipe_Kendaraan VALUES ('TK03', 'Sport');
INSERT INTO Tipe_Kendaraan VALUES ('TK04', 'Naked');
INSERT INTO Tipe_Kendaraan VALUES ('TK05', 'Cruiser');
INSERT INTO Tipe_Kendaraan VALUES ('TK06', 'Sport Tourer');
INSERT INTO Tipe_Kendaraan VALUES ('TK07', 'Enduro');
INSERT INTO Tipe_Kendaraan VALUES ('TK08', 'Trail');
INSERT INTO Tipe_Kendaraan VALUES ('TK09', 'ATV');
INSERT INTO Tipe_Kendaraan VALUES ('TK10', 'Three Wheelers');

INSERT INTO Suku_Cadang VALUES ('14430-KSP-910','ARM COMP VALVE ROCKER', NULL, 43, 195000);
INSERT INTO Suku_Cadang VALUES ('18318-K25-900','PROTECTOR, MUFFLER', NULL, 25, 33000);
INSERT INTO Suku_Cadang VALUES ('33110-K25-901','HEADLIGHT UNIT', NULL, 95, 125500);
INSERT INTO Suku_Cadang VALUES ('88120-K25-900','MIRROR COMP L', NULL, 50, 37000);
INSERT INTO Suku_Cadang VALUES ('88110-K25-900','MIRROR COMP R', NULL, 50, 37000);
INSERT INTO Suku_Cadang VALUES ('30410-KVB-N51','UNIT COMP,CDI', NULL, 3, 575000);
INSERT INTO Suku_Cadang VALUES ('35010-K25-900','KEY SET', NULL, 13, 176000);
INSERT INTO Suku_Cadang VALUES ('12191-K15-900','GASKET,CYLINDER', NULL, 107, 8000);
INSERT INTO Suku_Cadang VALUES ('50720-K16-900','ARM, R. PILLION STEP', NULL, 72, 28000);
INSERT INTO Suku_Cadang VALUES ('17211-K15-900','ELEMENT COMP,AIR/C', NULL, 31, 48000);

INSERT INTO Nota_Suku_Cadang VALUES ('NSC-001', '2021-12-18');

INSERT INTO Detail_Nota_Suku_Cadang VALUES ('NSC-001', '14430-KSP-910', 3);

INSERT INTO Kendaraan VALUES ('GG-2639-KA', 'PEM-001', 'TK01', 'MH823H48DSJD8S', 'DJAL92039483', 2021, 'Hitam');

INSERT INTO PKB VALUES ('PKB001', 'GG-2639-KA', 'NSC-001', SYSDATE(), CURRENT_TIMESTAMP, 0);

INSERT INTO Pembayaran VALUES ('BYR-231221', 'PKB002', SYSDATE(), CURRENT_TIMESTAMP, 50000, 'testing');

/* ==================================================
 * ======== Insert Web Manual & Testing =============
 * ==================================================
 */
INSERT INTO Pemilik VALUES ('PEM-001', 'Luthfiyah Nur Arofah', 'luthfiyah@gmail.com', '12345678', 'Ki. Dr. Junjunan No. 80, Sibolga 87726, Papua', '087840910959');
INSERT INTO Pemilik VALUES ('PEM-002', 'Muhammad Faishal Hafizh Mumtaz Galip', 'faishal@gmail.com', '12345678', 'Gg. Suryo Pranoto No. 977, Padangsidempuan 52465, Malut', '086384623152');
INSERT INTO Pemilik VALUES ('PEM-003', 'Novira Damayanti Rahma', 'novira@gmail.com', '12345678', 'Gg. Basoka Raya No. 491, Pangkal Pinang 61103, Sulsel', '089391473115');
INSERT INTO Pemilik VALUES ('PEM-004', 'Adhiba Alya Firdaus', 'adhiba@gmail.com', '12345678', 'Dk. Bakti No. 614, Manado 55588, Kalsel', '081399883709');
INSERT INTO Pemilik VALUES ('PEM-005', 'Ilham Dwi Kurniawan', 'ilham@gmail.com', '12345678', 'Gg. Pasteur No. 925, Pagar Alam 60909, Sulbar', '083423256005');
INSERT INTO Pemilik VALUES ('PEM-006', 'Finndy Noverita Syafitri', 'finndy@gmail.com', '12345678', 'Gg. Pasteur No. 925, Pagar Alam 60909, Sulbar', '083423256005');
INSERT INTO Pemilik VALUES ('PEM-007', 'Rizky Akbar Ramadhan', 'akbar@gmail.com', '12345678', 'Gg. Pasteur No. 925, Pagar Alam 60909, Sulbar', '083423256005');
INSERT INTO Pemilik VALUES ('PEM-008', 'Putri Anindyah Azis', 'anindyah@gmail.com', '12345678', 'Gg. Pasteur No. 925, Pagar Alam 60909, Sulbar', '083423256005');
INSERT INTO Pemilik VALUES ('PEM-009', 'Arviolla Rohman Fatikhah', 'arviolla@gmail.com', '12345678', 'Gg. Pasteur No. 925, Pagar Alam 60909, Sulbar', '083423256005');
INSERT INTO Pemilik VALUES ('PEM-010', 'Muhammad Nabil Alif', 'nabil@gmail.com', '12345678', 'Gg. Pasteur No. 925, Pagar Alam 60909, Sulbar', '083423256005');
INSERT INTO Pemilik VALUES ('PEM-011', 'Fariz Rahman', 'fariz@gmail.com', '12345678', 'Gg. Pasteur No. 925, Pagar Alam 60909, Sulbar', '083423256005');

INSERT INTO Pegawai VALUES ('PEG-001', '1', 'Agiftsany Azhar', 'agif@gmail.com', '12345678', 'Krian', '08123456789');
INSERT INTO Pegawai VALUES ('PEG-002', '2', 'Khodijah Aulia Rahma', 'khodijah@gmail.com', '12345678', 'Gubeng', '08123456789');
INSERT INTO Pegawai VALUES ('PEG-003', '3', 'Bayu Kharismulloh', 'bayu@gmail.com', '12345678', 'Taman', '08123456789');
INSERT INTO Pegawai VALUES ('PEG-004', '4', 'Dea Oktavia', 'dea@gmail.com', '12345678', 'Lida', '08123456789');
INSERT INTO Pegawai VALUES ('PEG-005', '5', 'Muhammad Faisal Maulana Putra', 'faisal@gmail.com', '12345678', 'Bojonegoro', '08123456789');
INSERT INTO Pegawai VALUES ('PEG-006', '5', 'Zulfa Lutfiah', 'zulfa@gmail.com', '12345678', 'Sepanjang', '08123456789');
INSERT INTO Pegawai VALUES ('PEG-007', '5', 'Farah Salsabila Mumtaz', 'Farah@gmail.com', '12345678', 'Gubeng', '08123456789');
INSERT INTO Pegawai VALUES ('PEG-008', '5', 'Muhammad Iqbal Krisna Maulana', 'iqbal@gmail.com', '12345678', 'Taman', '08123456789');
INSERT INTO Pegawai VALUES ('PEG-009', '5', 'Bintang Achmad Mudzakie', 'bintang@gmail.com', '12345678', 'Lida', '08123456789');
INSERT INTO Pegawai VALUES ('PEG-010', '5', 'Herrys Aghista Rachman', 'herrys@gmail.com', '12345678', 'Bojonegoro', '08123456789');

INSERT INTO Nota_Suku_Cadang VALUES ('NSC-002', '2021-12-17');
INSERT INTO Nota_Suku_Cadang VALUES ('NSC-003', '2021-12-16');
INSERT INTO Nota_Suku_Cadang VALUES ('NSC-004', '2021-12-15');
INSERT INTO Nota_Suku_Cadang VALUES ('NSC-005', '2021-12-14');
INSERT INTO Nota_Suku_Cadang VALUES ('NSC-006', '2021-12-13');
INSERT INTO Nota_Suku_Cadang VALUES ('NSC-007', '2021-12-12');
INSERT INTO Nota_Suku_Cadang VALUES ('NSC-008', '2021-12-11');
INSERT INTO Nota_Suku_Cadang VALUES ('NSC-009', '2021-12-10');
INSERT INTO Nota_Suku_Cadang VALUES ('NSC-010', '2021-12-09');

SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;

SELECT id_user FROM USER
ORDER BY id_user DESC LIMIT 1;

SELECT id_pemilik FROM Pemilik
ORDER BY id_pemilik DESC LIMIT 1;

INSERT INTO Pemilik (id_user, nama_pemilik, email, PASSWORD, alamat_pemilik, telp_pemilik)
SELECT id_user, nama, email, PASSWORD, alamat, telp
FROM USER
ORDER BY id_user DESC LIMIT 1;

SELECT p.id_pegawai, j.nama_jabatan, p.nama_pegawai, p.email, p.password, p.alamat_pegawai, p.telp_pegawai
FROM pegawai p JOIN jabatan j ON p.id_jabatan = j.id_jabatan;

SELECT no_nota_suku_cadang FROM nota_suku_cadang
ORDER BY no_nota_suku_cadang DESC LIMIT 1;

UPDATE Pembayaran
SET tgl_bayar=SYSDATE(), jam_bayar=CURRENT_TIMESTAMP
WHERE id_pembayaran='BYR-00000000';

UPDATE Pembayaran
SET total_harga=30000
WHERE id_pembayaran='BYR-00000000';

SELECT pkb.`id_pkb`, pkb.`no_nota_suku_cadang`, pem.nama_pemilik, pkb.`tgl_pesan`, pkb.`jam_pesan`, pkb.`status`
FROM pkb pkb JOIN Kendaraan kdr
	     ON pkb.`no_stnk` = kdr.no_stnk
	     JOIN Pemilik pem
	     ON pem.id_pemilik = kdr.id_pemilik;

SELECT pkb.`id_pkb`, pkb.`no_nota_suku_cadang`, pem.nama_pemilik, kdr.no_stnk, pkb.`tgl_pesan`, pkb.`jam_pesan`, byr.tgl_bayar, byr.jam_bayar, pkb.`status`
FROM pkb pkb JOIN Kendaraan kdr
	     ON pkb.`no_stnk` = kdr.no_stnk
	     JOIN Pembayaran byr
	     ON byr.id_pkb = pkb.`id_pkb`
	     JOIN Pemilik pem
	     ON pem.id_pemilik = kdr.id_pemilik;

UPDATE Pembayaran
SET bukti_pembayaran='gambar'
WHERE id_pkb='PKB024';

UPDATE Pembayaran
SET bukti_pembayaran='gambar'
WHERE id_pkb='PKB023';

UPDATE PKB
SET STATUS=1
WHERE id_pkb='PKB026';

SELECT *
FROM pemilik p JOIN kendaraan k ON p.id_pemilik = k.id_pemilik
WHERE p.id_pemilik='PEM-045';

SELECT * FROM USER u
JOIN pemilik p ON p.id_user = u.id_user
JOIN kendaraan k ON k.id_pemilik = p.id_pemilik
JOIN tipe_kendaraan tk ON tk.id_tipe = k.id_tipe
WHERE u.id_user =19;

SELECT * FROM USER WHERE id_user='26';

SELECT SUM(total_harga) AS Total FROM pembayaran
WHERE tgl_bayar=CURDATE();

SELECT id_pemilik FROM pemilik p
JOIN USER u ON p.id_user=u.id_user;

SELECT k.no_stnk FROM pemilik p
JOIN USER u ON p.id_user = u.id_user
JOIN kendaraan k ON k.id_pemilik = p.id_pemilik
WHERE u.id_user=22;

SELECT PASSWORD
FROM pemilik
ORDER BY PASSWORD;