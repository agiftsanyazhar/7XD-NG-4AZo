-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 12, 2022 at 02:51 PM
-- Server version: 10.4.16-MariaDB
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bengkel_uas`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `total` (`id_nsc` VARCHAR(7)) RETURNS INT(11) BEGIN
                                        DECLARE hitung INT;
                                        SELECT SUM(dnsc.`banyak`*sc.`harga_satuan`) INTO hitung
                                        FROM detail_nota_suku_cadang dnsc JOIN suku_cadang sc ON dnsc.id_suku_cadang = sc.id_suku_cadang
                                        WHERE dnsc.no_nota_suku_cadang = id_nsc;
                                    RETURN hitung;
                                    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` varchar(7) NOT NULL,
  `nama_admin` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `nama_admin`, `email`, `password`) VALUES
('ADM-002', 'Administrator1', 'administrator1@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
('ADM-003', 'Administrator', 'administrator@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
('ADM-006', 'Administrator2', 'administrator2@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
('ADM-007', 'Administrator3', 'administrator3@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
('ADM-009', 'Aryo Pandu Dwi Anggoro', 'aryo.administrator@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
('ADM-010', 'Muhammad Raihan Pradana', 'raihan.administrator@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
('ADM-011', 'Afifah Aghnia Mumtaz', 'afifah.administrator@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
('ADM-014', 'Hamimma Talita Aulia', 'lia123.administrator@gmail.com', '25d55ad283aa400af464c76d713c07ad');

--
-- Triggers `admin`
--
DELIMITER $$
CREATE TRIGGER `before_insert_admin` BEFORE INSERT ON `admin` FOR EACH ROW BEGIN
	INSERT INTO seqbar_admin VALUES (NULL);
	
	SET new.id_admin = CONCAT('ADM-',LPAD(LAST_INSERT_ID(), 3, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `billing_vu`
-- (See below for the actual view)
--
CREATE TABLE `billing_vu` (
`id_pkb` varchar(6)
,`no_nota_suku_cadang` varchar(7)
,`nama_pemilik` varchar(100)
,`tgl_pesan` date
,`jam_pesan` time
,`status` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `detail_nota_suku_cadang`
--

CREATE TABLE `detail_nota_suku_cadang` (
  `no_nota_suku_cadang` varchar(7) NOT NULL,
  `id_suku_cadang` varchar(20) NOT NULL,
  `nama_suku_cadang` varchar(100) NOT NULL,
  `harga_satuan` int(11) NOT NULL,
  `banyak` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_nota_suku_cadang`
--

INSERT INTO `detail_nota_suku_cadang` (`no_nota_suku_cadang`, `id_suku_cadang`, `nama_suku_cadang`, `harga_satuan`, `banyak`) VALUES
('NSC-042', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-043', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-043', '50720-K16-900', 'ARM, R. PILLION STEP', 28000, 1),
('NSC-044', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-044', '50720-K16-900', 'ARM, R. PILLION STEP', 28000, 1),
('NSC-045', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-045', '50720-K16-900', 'ARM, R. PILLION STEP', 28000, 1),
('NSC-046', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-046', '50720-K16-900', 'ARM, R. PILLION STEP', 28000, 1),
('NSC-047', '50720-K16-900', 'ARM, R. PILLION STEP', 28000, 1),
('NSC-048', '17211-K15-900', 'ELEMENT COMP, AIR/C', 48000, 1),
('NSC-049', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-050', '50720-K16-900', 'ARM, R. PILLION STEP', 28000, 2),
('NSC-051', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-052', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-052', '50720-K16-900', 'ARM, R. PILLION STEP', 28000, 1),
('NSC-053', '50720-K16-900', 'ARM, R. PILLION STEP', 28000, 1),
('NSC-053', '88110-K25-900', 'MIRROR COMP R', 37000, 1),
('NSC-054', '3501A-K59-A10', 'KEY SET ASSY', 560000, 1),
('NSC-054', '88120-K25-900', 'MIRROR COMP L', 37000, 1),
('NSC-055', '80115-K59-A10', 'BASE LICENCE LIGHT', 10000, 1),
('NSC-056', '80115-K59-A10', 'BASE LICENCE LIGHT', 10000, 1),
('NSC-057', '50720-K16-900', 'ARM, R. PILLION STEP', 28000, 1),
('NSC-058', '50720-K16-900', 'ARM, R. PILLION STEP', 28000, 1),
('NSC-058', '53208-K59-A10PFW', 'COVER SPDMT (PL FD WH)', 107000, 1),
('NSC-059', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-060', '83520-K59-A10ZB', 'COVER R BODY SIDE', 33000, 1),
('NSC-061', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 2),
('NSC-062', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-063', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-064', '14430-KSP-910', 'ARM COMP VALVE ROCKER', 195000, 1),
('NSC-064', '42601-K59-A12', 'WHEEL COMP, REAR NH-303M', 600000, 2),
('NSC-065', '30410-KVB-N51', 'UNIT COMP, CDI', 575000, 1),
('NSC-065', '42601-K59-A12', 'WHEEL COMP, REAR NH-303M', 600000, 2);

--
-- Triggers `detail_nota_suku_cadang`
--
DELIMITER $$
CREATE TRIGGER `after_insert_dnsc` AFTER INSERT ON `detail_nota_suku_cadang` FOR EACH ROW BEGIN
	UPDATE Suku_Cadang
	SET stok = stok-new.banyak
	WHERE id_suku_cadang = new.id_suku_cadang;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `detail_pesanan_vu`
-- (See below for the actual view)
--
CREATE TABLE `detail_pesanan_vu` (
`id_pkb` varchar(6)
,`no_nota_suku_cadang` varchar(7)
,`nama_pemilik` varchar(100)
,`no_stnk` varchar(10)
,`id_suku_cadang` varchar(20)
,`nama_suku_cadang` varchar(100)
,`harga_satuan` int(11)
,`banyak` int(11)
,`total_harga` int(11)
,`tgl_pesan` date
,`jam_pesan` time
,`tgl_bayar` date
,`jam_bayar` time
,`status` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `jabatan`
--

CREATE TABLE `jabatan` (
  `id_jabatan` char(1) NOT NULL,
  `nama_jabatan` varchar(100) NOT NULL,
  `gaji_pokok` int(11) NOT NULL,
  `tunjangan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jabatan`
--

INSERT INTO `jabatan` (`id_jabatan`, `nama_jabatan`, `gaji_pokok`, `tunjangan`) VALUES
('1', 'Kepala Bengkel', 5000000, 200000),
('2', 'Instruktur Servis', 9000000, 350000),
('3', 'Service Advisor', 80000000, 600000),
('4', 'Koordinator THS', 70000000, 500000),
('5', 'Mekanik', 60000000, 300000);

-- --------------------------------------------------------

--
-- Table structure for table `kendaraan`
--

CREATE TABLE `kendaraan` (
  `no_stnk` varchar(10) NOT NULL,
  `id_pemilik` varchar(7) NOT NULL,
  `id_tipe` char(4) NOT NULL,
  `no_mesin` varchar(14) NOT NULL,
  `no_rangka` varchar(18) NOT NULL,
  `tahun` int(11) NOT NULL,
  `warna` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kendaraan`
--

INSERT INTO `kendaraan` (`no_stnk`, `id_pemilik`, `id_tipe`, `no_mesin`, `no_rangka`, `tahun`, `warna`) VALUES
('IJ-9238-AL', 'PEM-053', 'TK09', '9249JZSDLKJLAQ', 'HKNLAMC09302NLSACN', 2022, 'Pink'),
('KA-0824-LD', 'PEM-057', 'TK01', 'GKD4HFJS0H4K5J', 'FKD023J4023AKMDKQE', 2022, 'Merah'),
('KD-7923-CM', 'PEM-070', 'TK06', 'KZFBAKA9234.KN', 'KJBWFK24234LAMLMAD', 2020, 'Pink'),
('KZ-8723-KN', 'PEM-062', 'TK04', 'LAMXK98349SDKJ', '29839JKASDJLKSJDLL', 2022, 'Putih'),
('L-8239-ZKD', 'PEM-063', 'TK08', 'HOSKL9023NKSAN', '023009PQOROUOPKQQD', 2077, 'Hitam'),
('SP-9823-CM', 'PEM-062', 'TK02', '032JBDFJA904JB', '02KNSNVM023ONKNKSD', 2077, 'Ungu'),
('W-0329-LAK', 'PEM-070', 'TK10', 'GAFLAIUR02483L', '98374ZLKNFLNWLWFAA', 2020, 'Hitam'),
('W-7321-IF', 'PEM-053', 'TK04', 'GKD4HFJS0H4K5J', 'FKD023J4023AKMDKQE', 2022, 'Putih'),
('W-9283-PKA', 'PEM-061', 'TK04', 'IHFIH9SD934KKK', '7283HJSJDIJS999F89', 2022, 'Merah'),
('W-9349-PKD', 'PEM-058', 'TK03', 'SFSH2923090DFL', '398JKLAS9VLDMLMSCH', 2021, 'Hitam'),
('WW-0240-LS', 'PEM-063', 'TK05', '9224KNSNPQIKCN', 'DGAKUHF8298HJKDLNA', 2020, 'Hitam'),
('Y-0284-LAK', 'PEM-061', 'TK09', 'HSFUHUSIFHU023', '123KSJIKLADK302940', 2050, 'Putih');

-- --------------------------------------------------------

--
-- Table structure for table `nota_suku_cadang`
--

CREATE TABLE `nota_suku_cadang` (
  `no_nota_suku_cadang` varchar(7) NOT NULL,
  `tgl_nota_suku_cadang` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nota_suku_cadang`
--

INSERT INTO `nota_suku_cadang` (`no_nota_suku_cadang`, `tgl_nota_suku_cadang`) VALUES
('NSC-027', '2021-12-28'),
('NSC-028', '2021-12-28'),
('NSC-029', '2021-12-28'),
('NSC-030', '2021-12-28'),
('NSC-031', '2021-12-28'),
('NSC-032', '2021-12-28'),
('NSC-033', '2021-12-28'),
('NSC-034', '2021-12-28'),
('NSC-035', '2021-12-28'),
('NSC-036', '2021-12-28'),
('NSC-037', '2021-12-28'),
('NSC-038', '2021-12-28'),
('NSC-039', '2021-12-28'),
('NSC-040', '2021-12-28'),
('NSC-041', '2021-12-28'),
('NSC-042', '2022-01-05'),
('NSC-043', '2022-01-05'),
('NSC-044', '2022-01-06'),
('NSC-045', '2022-01-06'),
('NSC-046', '2022-01-06'),
('NSC-047', '2022-01-06'),
('NSC-048', '2022-01-06'),
('NSC-049', '2022-01-06'),
('NSC-050', '2022-01-06'),
('NSC-051', '2022-01-06'),
('NSC-052', '2022-01-07'),
('NSC-053', '2022-01-07'),
('NSC-054', '2022-01-07'),
('NSC-055', '2022-01-07'),
('NSC-056', '2022-01-08'),
('NSC-057', '2022-01-09'),
('NSC-058', '2022-01-10'),
('NSC-059', '2022-01-10'),
('NSC-060', '2022-01-10'),
('NSC-061', '2022-01-11'),
('NSC-062', '2022-01-11'),
('NSC-063', '2022-01-11'),
('NSC-064', '2022-01-12'),
('NSC-065', '2022-01-12');

--
-- Triggers `nota_suku_cadang`
--
DELIMITER $$
CREATE TRIGGER `before_insert_nsc` BEFORE INSERT ON `nota_suku_cadang` FOR EACH ROW BEGIN
	INSERT INTO seqbar_nsc VALUES (NULL);
	
	SET new.no_nota_suku_cadang = CONCAT('NSC-',LPAD(LAST_INSERT_ID(), 3, '0'));
	SET new.tgl_nota_suku_cadang = SYSDATE();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `id_pegawai` varchar(7) NOT NULL,
  `id_jabatan` char(1) NOT NULL,
  `nama_pegawai` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(32) NOT NULL,
  `alamat_pegawai` varchar(100) NOT NULL,
  `telp_pegawai` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`id_pegawai`, `id_jabatan`, `nama_pegawai`, `email`, `password`, `alamat_pegawai`, `telp_pegawai`) VALUES
('PEG-001', '5', 'Aryo Pandu Dwi Anggoro', 'pandu@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Sepanjang', '086283742832'),
('PEG-002', '5', 'Pascallis Henoch Herutomo', 'pascallis@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Bojonegoro', '084638273821'),
('PEG-003', '4', 'Hamimma Talita Aulia', 'hamimma@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Lida', '08310936789'),
('PEG-004', '3', 'Muhammad Raihan Pradana', 'raihan@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Taman', '08192488689'),
('PEG-005', '2', 'Afifah Aghnia Mumtaz', 'afifah@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Gubeng', '08130586789'),
('PEG-006', '1', 'Nadya Lovita Sari', 'nadya@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Krian', '08122408589'),
('PEG-010', '3', 'Pegawai', 'pegawai@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Krian', '084748392841');

--
-- Triggers `pegawai`
--
DELIMITER $$
CREATE TRIGGER `before_insert_pegawai` BEFORE INSERT ON `pegawai` FOR EACH ROW BEGIN
	INSERT INTO seqbar_pegawai VALUES (NULL);
	
	SET new.id_pegawai = CONCAT('PEG-',LPAD(LAST_INSERT_ID(), 3, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` varchar(15) NOT NULL,
  `id_pkb` varchar(6) NOT NULL,
  `tgl_bayar` date DEFAULT NULL,
  `jam_bayar` time DEFAULT NULL,
  `total_harga` int(11) NOT NULL,
  `bukti_pembayaran` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_pkb`, `tgl_bayar`, `jam_bayar`, `total_harga`, `bukti_pembayaran`) VALUES
('BYR-06012022026', 'PKB029', '2022-01-06', '20:24:24', 223000, 'Kamar.png'),
('BYR-06012022029', 'PKB032', '2022-01-06', '20:47:14', 195000, 'frame.png'),
('BYR-06012022030', 'PKB033', '2022-01-06', '20:51:14', 56000, 'Spark621 on Twitter.jpg'),
('BYR-06012022031', 'PKB034', '2022-01-06', '23:31:57', 195000, 'probs.c4d'),
('BYR-07012022032', 'PKB035', '2022-01-07', '16:52:15', 223000, 'R Anggit Herdianto 08520241005.pdf'),
('BYR-07012022033', 'PKB036', '2022-01-07', '17:29:57', 65000, '37771_My+Skripsi+(Rev1).pdf'),
('BYR-07012022034', 'PKB037', '2022-01-07', '17:35:18', 597000, NULL),
('BYR-07012022035', 'PKB038', '2022-01-07', '17:37:51', 10000, 'probs.c4d'),
('BYR-08012022036', 'PKB039', '2022-01-08', '08:12:51', 10000, NULL),
('BYR-09012022037', 'PKB040', '2022-01-09', '13:32:18', 28000, 'WhatsApp Image 2022-01-08 at 16.51.51.jpeg'),
('BYR-10012022038', 'PKB041', '2022-01-10', '09:49:15', 135000, NULL),
('BYR-10012022039', 'PKB042', '2022-01-10', '12:33:46', 195000, 'COVER FR. LWR ASSY.jpg'),
('BYR-10012022040', 'PKB043', '2022-01-10', '13:30:19', 33000, 'UAS MULTIMEDIA TEORI_152011513024.pdf'),
('BYR-11012022041', 'PKB044', '2022-01-11', '10:29:09', 390000, 'WhatsApp Image 2022-01-08 at 16.51.51.jpeg'),
('BYR-11012022042', 'PKB045', '2022-01-11', '14:38:31', 195000, NULL),
('BYR-11012022043', 'PKB046', '2022-01-11', '22:07:57', 195000, 'Chapter 11.0-Dasar Proteksi Radiasi.pdf'),
('BYR-12012022045', 'PKB048', '2022-01-12', '15:24:09', 1775000, 'WhatsApp Image 2022-01-08 at 16.51.51.jpeg');

--
-- Triggers `pembayaran`
--
DELIMITER $$
CREATE TRIGGER `before_insert_pembayaran` BEFORE INSERT ON `pembayaran` FOR EACH ROW BEGIN
	INSERT INTO seqbar_pembayaran VALUES (NULL);
	
	SET new.id_pembayaran	= CONCAT('BYR-',DATE_FORMAT(sysdate(), '%d%m%Y'), LPAD(LAST_INSERT_ID(), 3, '0'));
	SET new.tgl_bayar	= SYSDATE();
	SET new.jam_bayar	= CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pemilik`
--

CREATE TABLE `pemilik` (
  `id_pemilik` varchar(7) NOT NULL,
  `id_user` int(11) NOT NULL,
  `nama_pemilik` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(32) DEFAULT NULL,
  `alamat_pemilik` varchar(100) NOT NULL,
  `telp_pemilik` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pemilik`
--

INSERT INTO `pemilik` (`id_pemilik`, `id_user`, `nama_pemilik`, `email`, `password`, `alamat_pemilik`, `telp_pemilik`) VALUES
('PEM-053', 22, 'Agiftsany', 'agif@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Mojosantren Krian', '082332834701'),
('PEM-055', 0, 'Dosen', 'dosen@gmail.com', NULL, 'Mojosantren Krian', '083947293823'),
('PEM-056', 0, 'Mahasiswa', 'mahasiswa@gmail.com', NULL, 'Mojosantren Krian', '083947748823'),
('PEM-057', 24, 'Aryo Pandu', 'aryo@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Madiun', '087482938745'),
('PEM-058', 28, 'Pemilik', 'pemilik@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Krian', '083648273821'),
('PEM-060', 33, 'Santri', 'santri@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Mojosantren Krian', '083824928319'),
('PEM-061', 37, 'Mahasiswa', 'mahasiswa@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Mojosantren Krian', '084628362819'),
('PEM-062', 39, 'Pemilik', 'pemilik@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Krian', '08472938294'),
('PEM-063', 40, 'PWBF', 'pwbf@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Surabaya', '082749283012'),
('PEM-064', 0, 'Budi', 'idub@gmail.com', NULL, 'Surabaya', '084917483812'),
('PEM-065', 41, 'adhiba', 'adhiba@gmail.com', 'cdba1ff5b38f0203191e52979d770d54', 'ketintang barat', '085851039374'),
('PEM-066', 0, 'Multimedia', 'multimedia@gmail.com', NULL, 'Krian', '084729192831'),
('PEM-067', 0, 'Budi', 'budihartono@gmail.com', NULL, 'Jombang', '084920193842'),
('PEM-068', 42, 'PBD Praktikum', 'pbdpraktikum@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Surabaya', '087381930472'),
('PEM-070', 47, 'UAS PBD Praktikum', 'uas.pbd.praktikum@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'Surabaya', '084672938172');

--
-- Triggers `pemilik`
--
DELIMITER $$
CREATE TRIGGER `before_insert_pemilik` BEFORE INSERT ON `pemilik` FOR EACH ROW BEGIN
	INSERT INTO seqbar_pemilik VALUES (NULL);
	
	SET new.id_pemilik = CONCAT('PEM-',LPAD(LAST_INSERT_ID(), 3, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pkb`
--

CREATE TABLE `pkb` (
  `id_pkb` varchar(6) NOT NULL,
  `no_stnk` varchar(10) NOT NULL,
  `no_nota_suku_cadang` varchar(7) NOT NULL,
  `tgl_pesan` date NOT NULL,
  `jam_pesan` time NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pkb`
--

INSERT INTO `pkb` (`id_pkb`, `no_stnk`, `no_nota_suku_cadang`, `tgl_pesan`, `jam_pesan`, `status`) VALUES
('PKB029', 'W-7321-IF', 'NSC-046', '2022-01-06', '18:59:09', 1),
('PKB032', 'W-7321-IF', 'NSC-049', '2022-01-06', '20:45:10', 1),
('PKB033', 'W-7321-IF', 'NSC-050', '2022-01-06', '20:49:46', 1),
('PKB034', 'KA-0824-LD', 'NSC-051', '2022-01-06', '23:31:02', 1),
('PKB035', 'KZ-8723-KN', 'NSC-052', '2022-01-07', '16:51:57', 1),
('PKB036', 'L-8239-ZKD', 'NSC-053', '2022-01-07', '17:29:36', 1),
('PKB037', 'WW-0240-LS', 'NSC-054', '2022-01-07', '17:35:18', 0),
('PKB038', 'L-8239-ZKD', 'NSC-055', '2022-01-07', '17:37:17', 1),
('PKB039', 'KZ-8723-KN', 'NSC-056', '2022-01-08', '08:12:51', 0),
('PKB040', 'WW-0240-LS', 'NSC-057', '2022-01-09', '13:32:00', 1),
('PKB041', 'KZ-8723-KN', 'NSC-058', '2022-01-10', '09:49:15', 0),
('PKB042', 'L-8239-ZKD', 'NSC-059', '2022-01-10', '12:33:20', 1),
('PKB043', 'IJ-9238-AL', 'NSC-060', '2022-01-10', '13:30:01', 1),
('PKB044', 'IJ-9238-AL', 'NSC-061', '2022-01-11', '10:28:20', 1),
('PKB045', 'W-7321-IF', 'NSC-062', '2022-01-11', '14:38:31', 0),
('PKB046', 'IJ-9238-AL', 'NSC-063', '2022-01-11', '22:04:12', 1),
('PKB048', 'W-0329-LAK', 'NSC-065', '2022-01-12', '15:17:48', 1);

--
-- Triggers `pkb`
--
DELIMITER $$
CREATE TRIGGER `before_insert_pkb` BEFORE INSERT ON `pkb` FOR EACH ROW BEGIN
	INSERT INTO seqbar_pkb VALUES (NULL);
	
	SET new.id_pkb = CONCAT('PKB',LPAD(LAST_INSERT_ID(), 3, '0'));
	SET new.tgl_pesan = SYSDATE();
	SET new.jam_pesan = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `seqbar_admin`
--

CREATE TABLE `seqbar_admin` (
  `barcount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seqbar_admin`
--

INSERT INTO `seqbar_admin` (`barcount`) VALUES
(1),
(2),
(3),
(6),
(7),
(9),
(10),
(11),
(13),
(14);

-- --------------------------------------------------------

--
-- Table structure for table `seqbar_nsc`
--

CREATE TABLE `seqbar_nsc` (
  `barcount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seqbar_nsc`
--

INSERT INTO `seqbar_nsc` (`barcount`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48),
(49),
(50),
(51),
(52),
(53),
(54),
(55),
(56),
(57),
(58),
(59),
(60),
(61),
(62),
(63),
(64),
(65);

-- --------------------------------------------------------

--
-- Table structure for table `seqbar_pegawai`
--

CREATE TABLE `seqbar_pegawai` (
  `barcount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seqbar_pegawai`
--

INSERT INTO `seqbar_pegawai` (`barcount`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11);

-- --------------------------------------------------------

--
-- Table structure for table `seqbar_pembayaran`
--

CREATE TABLE `seqbar_pembayaran` (
  `barcount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seqbar_pembayaran`
--

INSERT INTO `seqbar_pembayaran` (`barcount`) VALUES
(1),
(2),
(3),
(5),
(6),
(7),
(8),
(9),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45);

-- --------------------------------------------------------

--
-- Table structure for table `seqbar_pemilik`
--

CREATE TABLE `seqbar_pemilik` (
  `barcount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seqbar_pemilik`
--

INSERT INTO `seqbar_pemilik` (`barcount`) VALUES
(1),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48),
(49),
(50),
(51),
(52),
(53),
(54),
(55),
(56),
(57),
(58),
(59),
(60),
(61),
(62),
(63),
(64),
(65),
(66),
(67),
(68),
(69),
(70);

-- --------------------------------------------------------

--
-- Table structure for table `seqbar_pkb`
--

CREATE TABLE `seqbar_pkb` (
  `barcount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `seqbar_pkb`
--

INSERT INTO `seqbar_pkb` (`barcount`) VALUES
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48);

-- --------------------------------------------------------

--
-- Table structure for table `suku_cadang`
--

CREATE TABLE `suku_cadang` (
  `id_suku_cadang` varchar(20) NOT NULL,
  `nama_suku_cadang` varchar(100) NOT NULL,
  `gambar_suku_cadang` text DEFAULT NULL,
  `stok` int(11) NOT NULL,
  `harga_satuan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `suku_cadang`
--

INSERT INTO `suku_cadang` (`id_suku_cadang`, `nama_suku_cadang`, `gambar_suku_cadang`, `stok`, `harga_satuan`) VALUES
('12191-K15-900', 'GASKET, CYLINDER', 'GASKET,CYLINDER.jpg', 107, 8000),
('14430-KSP-910', 'ARM COMP VALVE ROCKER', 'ARM COMP VALVE ROCKER.jpg', 204, 195000),
('17211-K15-900', 'ELEMENT COMP, AIR/C', 'ELEMENT COMP,AIR C.jpg', 30, 48000),
('18318-K25-600ZA', 'PROTECTOR, MUFFLER *TBLACK*', 'PROTECTOR, MUFFLER TBLACK.jpg', 86, 30000),
('18318-K25-900', 'PROTECTOR, MUFFLER', 'PROTECTOR, MUFFLER.jpg', 25, 33000),
('18318-K59-A10', 'PROTECTOR, MUFFLER', 'PROTECTOR, MUFFLER1.jpg', 14, 30000),
('2212A-K36-T00', 'ROLLER WEIGHT SET', 'ROLLER WEIGHT SET.jpg', 73, 47000),
('23100-K35-V01', 'BELT DRIVE', 'BELT DRIVE.jpg', 91, 120000),
('30410-KVB-N51', 'UNIT COMP, CDI', 'UNIT COMP,CDI.jpg', 13, 575000),
('30700-KWN-712', 'CAP ASSY NOISE SUP', 'CAP ASSY NOISE SUP.jpg', 85, 30000),
('31919-K25-602', 'SPARK PLUG U27EPR-N9 (DS)', 'SPARK PLUG U27EPR-N9 (DS).jpg', 100, 16400),
('33110-K25-901', 'HEADLIGHT UNIT', 'HEADLIGHT UNIT.jpg', 95, 125500),
('35010-K25-900', 'KEY SET', 'KEY SET.jpg', 12, 176000),
('3501A-K59-A10', 'KEY SET ASSY', 'KEY SET ASSY.jpg', 5, 560000),
('42601-K59-A12', 'WHEEL COMP, REAR NH-303M', 'WHEEL COMP,REAR NH-303M.jpg', 5, 600000),
('44601-K59-A11', 'WHEEL, FRONT NH-303M', 'WHEEL,FRONT NH-303M.jpg', 10, 450000),
('50720-K16-900', 'ARM, R. PILLION STEP', 'ARM, R. PILLION STEP.jpg', 54, 28000),
('53132-KSP-860ZD', 'HOLDER, HANDLE UNDER', 'HOLDER, HANDLE UNDER.jpg', 67, 21000),
('53206-K59-A10ZA', 'COVER HDL. RR.', 'COVER HDL. RR..jpg', 78, 31000),
('53208-K59-A10PFW', 'COVER SPDMT (PL FD WH)', 'COVER SPDMT (PL FD WH).jpg', 20, 107000),
('64303-K59-A10ZA', 'GARNISH, FR (Black)', 'GARNISH, FR (Black).jpg', 19, 30000),
('64501-K59-A10PFW', 'COVER R FR (PL FD WH)', 'COVER R FR (PL FD WH).jpg', 4, 215000),
('80115-K59-A10', 'BASE LICENCE LIGHT', 'BASE LICENCE LIGHT.jpg', 66, 10000),
('80151-K59-A10ZB', 'COVER CENTER', 'COVER CENTER.jpg', 41, 25000),
('81131-K59-A10ZG', 'COVER RACK (PL FD WH)', 'COVER RACK (PL FD WH).jpg', 3, 134000),
('83520-K59-A10ZB', 'COVER R BODY SIDE', 'COVER R BODY SIDE.jpg', 15, 33000),
('83620-K59-A10ZB', 'COVER L BODY SIDE', 'COVER L BODY SIDE.jpg', 13, 33000),
('88110-K25-900', 'MIRROR COMP R', 'MIRROR COMP R.jpg', 49, 37000),
('88120-K25-900', 'MIRROR COMP L', 'MIRROR COMP L.jpg', 49, 37000),
('98200-405-00', 'FUSE, MINI (5A)', 'FUSE, MINI(5A).jpg', 123, 1500);

-- --------------------------------------------------------

--
-- Table structure for table `tipe_kendaraan`
--

CREATE TABLE `tipe_kendaraan` (
  `id_tipe` char(4) NOT NULL,
  `nama_tipe` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tipe_kendaraan`
--

INSERT INTO `tipe_kendaraan` (`id_tipe`, `nama_tipe`) VALUES
('TK01', 'Scooter'),
('TK02', 'CUB'),
('TK03', 'Sport'),
('TK04', 'Naked'),
('TK05', 'Cruiser'),
('TK06', 'Sport Tourer'),
('TK07', 'Enduro'),
('TK08', 'Trail'),
('TK09', 'ATV'),
('TK10', 'Three Wheelers');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `id_jabatan` char(1) DEFAULT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(32) NOT NULL,
  `role` varchar(20) NOT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `telp` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `id_jabatan`, `nama`, `email`, `password`, `role`, `alamat`, `telp`) VALUES
(2, '1', 'Nadya Lovita Sari', 'nadya@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pegawai', 'Krian', '08122408589'),
(3, '2', 'Afifah Aghnia Mumtaz', 'afifah@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pegawai', 'Gubeng', '08130586789'),
(4, '3', 'Muhammad Raihan Pradana', 'raihan@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pegawai', 'Taman', '08192488689'),
(5, '4', 'Hamimma Talita Aulia', 'hamimma@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pegawai', 'Lida', '08310936789'),
(6, '5', 'Pascallis Henoch Herutomo', 'pascallis@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pegawai', 'Bojonegoro', '084638273821'),
(7, '5', 'Aryo Pandu Dwi Anggoro', 'pandu@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pegawai', 'Sepanjang', '086283742832'),
(13, NULL, 'Administrator', 'administrator@gmail.com', '5f4dcc3b5aa765d61d8327deb882cf99', 'admin', NULL, NULL),
(22, NULL, 'Agiftsany', 'agif@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pemilik', 'Mojosantren Krian', '082332834701'),
(24, NULL, 'Aryo Pandu', 'aryo@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pemilik', 'Madiun', '087482938745'),
(27, NULL, 'Administrator1', 'administrator1@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'admin', NULL, NULL),
(30, NULL, 'Aryo Pandu Dwi Anggoro', 'aryo.administrator@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'admin', NULL, NULL),
(38, '3', 'Pegawai', 'pegawai@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pegawai', 'Krian', '084748392841'),
(39, NULL, 'Pemilik', 'pemilik@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pemilik', 'Krian', '08472938294'),
(40, NULL, 'PWBF', 'pwbf@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pemilik', 'Surabaya', '082749283012'),
(41, NULL, 'adhiba', 'adhiba@gmail.com', 'cdba1ff5b38f0203191e52979d770d54', 'pemilik', 'ketintang barat', '085851039374'),
(47, NULL, 'UAS PBD Praktikum', 'uas.pbd.praktikum@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'pemilik', 'Surabaya', '084672938172'),
(48, NULL, 'Hamimma Talita Aulia', 'lia123.administrator@gmail.com', '25d55ad283aa400af464c76d713c07ad', 'admin', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure for view `billing_vu`
--
DROP TABLE IF EXISTS `billing_vu`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `billing_vu`  AS SELECT `pkb`.`id_pkb` AS `id_pkb`, `pkb`.`no_nota_suku_cadang` AS `no_nota_suku_cadang`, `pem`.`nama_pemilik` AS `nama_pemilik`, `pkb`.`tgl_pesan` AS `tgl_pesan`, `pkb`.`jam_pesan` AS `jam_pesan`, `pkb`.`status` AS `status` FROM ((`pkb` join `kendaraan` `kdr` on(`pkb`.`no_stnk` = `kdr`.`no_stnk`)) join `pemilik` `pem` on(`pem`.`id_pemilik` = `kdr`.`id_pemilik`)) ORDER BY `pkb`.`no_nota_suku_cadang` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `detail_pesanan_vu`
--
DROP TABLE IF EXISTS `detail_pesanan_vu`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `detail_pesanan_vu`  AS SELECT `pkb`.`id_pkb` AS `id_pkb`, `pkb`.`no_nota_suku_cadang` AS `no_nota_suku_cadang`, `pem`.`nama_pemilik` AS `nama_pemilik`, `kdr`.`no_stnk` AS `no_stnk`, `sc`.`id_suku_cadang` AS `id_suku_cadang`, `sc`.`nama_suku_cadang` AS `nama_suku_cadang`, `sc`.`harga_satuan` AS `harga_satuan`, `dnsc`.`banyak` AS `banyak`, `byr`.`total_harga` AS `total_harga`, `pkb`.`tgl_pesan` AS `tgl_pesan`, `pkb`.`jam_pesan` AS `jam_pesan`, `byr`.`tgl_bayar` AS `tgl_bayar`, `byr`.`jam_bayar` AS `jam_bayar`, `pkb`.`status` AS `status` FROM ((((((`pkb` join `kendaraan` `kdr` on(`pkb`.`no_stnk` = `kdr`.`no_stnk`)) join `pembayaran` `byr` on(`byr`.`id_pkb` = `pkb`.`id_pkb`)) join `pemilik` `pem` on(`pem`.`id_pemilik` = `kdr`.`id_pemilik`)) join `nota_suku_cadang` `nsc` on(`nsc`.`no_nota_suku_cadang` = `pkb`.`no_nota_suku_cadang`)) join `detail_nota_suku_cadang` `dnsc` on(`dnsc`.`no_nota_suku_cadang` = `nsc`.`no_nota_suku_cadang`)) join `suku_cadang` `sc` on(`sc`.`id_suku_cadang` = `dnsc`.`id_suku_cadang`)) ORDER BY `pkb`.`no_nota_suku_cadang` DESC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `detail_nota_suku_cadang`
--
ALTER TABLE `detail_nota_suku_cadang`
  ADD PRIMARY KEY (`no_nota_suku_cadang`,`id_suku_cadang`),
  ADD KEY `dnsc_idsc_fk` (`id_suku_cadang`);

--
-- Indexes for table `jabatan`
--
ALTER TABLE `jabatan`
  ADD PRIMARY KEY (`id_jabatan`);

--
-- Indexes for table `kendaraan`
--
ALTER TABLE `kendaraan`
  ADD PRIMARY KEY (`no_stnk`),
  ADD KEY `kndr_idpemilik_fk` (`id_pemilik`),
  ADD KEY `kndr_idtipe_fk` (`id_tipe`);

--
-- Indexes for table `nota_suku_cadang`
--
ALTER TABLE `nota_suku_cadang`
  ADD PRIMARY KEY (`no_nota_suku_cadang`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id_pegawai`),
  ADD UNIQUE KEY `email_telp` (`email`,`telp_pegawai`),
  ADD KEY `pgw_idjabatan_fk` (`id_jabatan`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `byr_idpkb_fk` (`id_pkb`);

--
-- Indexes for table `pemilik`
--
ALTER TABLE `pemilik`
  ADD PRIMARY KEY (`id_pemilik`),
  ADD UNIQUE KEY `email_telp` (`email`,`telp_pemilik`);

--
-- Indexes for table `pkb`
--
ALTER TABLE `pkb`
  ADD PRIMARY KEY (`id_pkb`),
  ADD KEY `pkb_nonotasukucadang_fk` (`no_nota_suku_cadang`),
  ADD KEY `pkb_nostnk_fk` (`no_stnk`);

--
-- Indexes for table `seqbar_admin`
--
ALTER TABLE `seqbar_admin`
  ADD PRIMARY KEY (`barcount`);

--
-- Indexes for table `seqbar_nsc`
--
ALTER TABLE `seqbar_nsc`
  ADD PRIMARY KEY (`barcount`);

--
-- Indexes for table `seqbar_pegawai`
--
ALTER TABLE `seqbar_pegawai`
  ADD PRIMARY KEY (`barcount`);

--
-- Indexes for table `seqbar_pembayaran`
--
ALTER TABLE `seqbar_pembayaran`
  ADD PRIMARY KEY (`barcount`);

--
-- Indexes for table `seqbar_pemilik`
--
ALTER TABLE `seqbar_pemilik`
  ADD PRIMARY KEY (`barcount`);

--
-- Indexes for table `seqbar_pkb`
--
ALTER TABLE `seqbar_pkb`
  ADD PRIMARY KEY (`barcount`);

--
-- Indexes for table `suku_cadang`
--
ALTER TABLE `suku_cadang`
  ADD PRIMARY KEY (`id_suku_cadang`);

--
-- Indexes for table `tipe_kendaraan`
--
ALTER TABLE `tipe_kendaraan`
  ADD PRIMARY KEY (`id_tipe`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `telp` (`telp`),
  ADD KEY `id_jabatan` (`id_jabatan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `seqbar_admin`
--
ALTER TABLE `seqbar_admin`
  MODIFY `barcount` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `seqbar_nsc`
--
ALTER TABLE `seqbar_nsc`
  MODIFY `barcount` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `seqbar_pegawai`
--
ALTER TABLE `seqbar_pegawai`
  MODIFY `barcount` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `seqbar_pembayaran`
--
ALTER TABLE `seqbar_pembayaran`
  MODIFY `barcount` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `seqbar_pemilik`
--
ALTER TABLE `seqbar_pemilik`
  MODIFY `barcount` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `seqbar_pkb`
--
ALTER TABLE `seqbar_pkb`
  MODIFY `barcount` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_nota_suku_cadang`
--
ALTER TABLE `detail_nota_suku_cadang`
  ADD CONSTRAINT `dnsc_idsc_fk` FOREIGN KEY (`id_suku_cadang`) REFERENCES `suku_cadang` (`id_suku_cadang`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `dnsc_notasukucadang_fk` FOREIGN KEY (`no_nota_suku_cadang`) REFERENCES `nota_suku_cadang` (`no_nota_suku_cadang`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `kendaraan`
--
ALTER TABLE `kendaraan`
  ADD CONSTRAINT `kndr_idpemilik_fk` FOREIGN KEY (`id_pemilik`) REFERENCES `pemilik` (`id_pemilik`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kndr_idtipe_fk` FOREIGN KEY (`id_tipe`) REFERENCES `tipe_kendaraan` (`id_tipe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD CONSTRAINT `pgw_idjabatan_fk` FOREIGN KEY (`id_jabatan`) REFERENCES `jabatan` (`id_jabatan`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `byr_idpkb_fk` FOREIGN KEY (`id_pkb`) REFERENCES `pkb` (`id_pkb`);

--
-- Constraints for table `pkb`
--
ALTER TABLE `pkb`
  ADD CONSTRAINT `pkb_idpembayaran_fk` FOREIGN KEY (`no_nota_suku_cadang`) REFERENCES `nota_suku_cadang` (`no_nota_suku_cadang`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pkb_nonotasukucadang_fk` FOREIGN KEY (`no_nota_suku_cadang`) REFERENCES `nota_suku_cadang` (`no_nota_suku_cadang`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pkb_nostnk_fk` FOREIGN KEY (`no_stnk`) REFERENCES `kendaraan` (`no_stnk`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `usr_idjabatan_fk` FOREIGN KEY (`id_jabatan`) REFERENCES `jabatan` (`id_jabatan`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
