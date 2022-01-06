<?php
    include_once('../../config/config.php');

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if(isset($_POST['checkout-tambah-alamat'])){
        // 1. Data diri pemilik
        $nama                   =  $_POST['nama_pemilik'];
        $alamat                 =  $_POST['alamat_pemilik'];
        $email                  =  $_POST['email'];
        $telp                   =  $_POST['telp_pemilik'];

        // 2. Data kendaraan
        $stnk                   =  $_POST['no_stnk'];
        // $tipe_kendaraan         =  $_POST['id_tipe'];
        // $mesin                  =  $_POST['no_mesin'];
        // $rangka                 =  $_POST['no_rangka'];
        // $warna                  =  $_POST['warna'];
        // $tahun                  =  $_POST['tahun'];

        // 3. Set id_nsc & id_pkb buat auto set d masing" tabel, tapi nanti d trigger, cuma buat set doang.
        $id_nsc                 =  '1';
        $id_pkb                 =  '1';

        //Cek formulir pemilik
        $sql                    = mysqli_query($mysqli, "SELECT * FROM pemilik WHERE email='$email' OR telp_pemilik='$telp'");
        $cek                    = mysqli_num_rows($sql);

        if($cek>0){ ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Email atau Telepon Telah Terdaftar!
            </div>
            <meta http-equiv="refresh" content="3;url=../../pages/dashboard/pemilik/checkout-tambah-alamat.php">
<?php   } else{
            // 4. Insert into biasa
            $query                  =  "INSERT INTO pemilik (nama_pemilik, email, alamat_pemilik, telp_pemilik)
                                    VALUES ('$nama', '$email', '$alamat', '$telp')";
            $execute                =  mysqli_query($mysqli, $query);

            // 6. Set trigger nsc d sini
            $query3                 =  "INSERT INTO nota_suku_cadang (no_nota_suku_cadang) VALUES ('$id_nsc')";
            $execute3               =  mysqli_query($mysqli, $query3);

            // 7. Nyari latest no_nota_suku_cadang kemudian insert into biasa (kek no. 5).
            $query4                 =  "SELECT no_nota_suku_cadang FROM nota_suku_cadang
                                    ORDER BY no_nota_suku_cadang DESC LIMIT 1";
            $execute4               =  mysqli_query($mysqli, $query4);
            $row_nsc                =  mysqli_fetch_assoc($execute4);
            $latest_id_nsc          =  $row_nsc['no_nota_suku_cadang'];
            foreach ($_SESSION['keranjang'] as $id_produk => $qty) {
                // 8. Nyari nama_suku_cadang & harga_satuan kemudian insert into biasa
                $query5             =  "SELECT * FROM suku_cadang WHERE id_suku_cadang='$id_produk'";
                $execute5           =  mysqli_query($mysqli, $query5);
                $row_sc             =  mysqli_fetch_assoc($execute5);
                $nama_sc            =  $row_sc['nama_suku_cadang'];
                $harga_sc           =  $row_sc['harga_satuan'];
                $query6             =  "INSERT INTO detail_nota_suku_cadang
                                    VALUES ('$latest_id_nsc', '$id_produk', '$nama_sc', '$harga_sc', $qty)";
                $execute6           =  mysqli_query($mysqli, $query6);
            }

            $resullt                =  "INSERT INTO pkb (no_stnk, no_nota_suku_cadang)
                                    VALUES ('$stnk', '$latest_id_nsc')";
            $add_pkb                =  mysqli_query($mysqli, $resullt);

            $query7                 =  "SELECT id_pkb FROM pkb
                                    ORDER BY id_pkb DESC LIMIT 1";
            $execute7               =  mysqli_query($mysqli, $query7);
            $row_id_pkb             =  mysqli_fetch_assoc($execute7);
            $latest_id_pkb          =  $row_id_pkb['id_pkb'];
            $kueri                  =  mysqli_query($mysqli,
                                        "CREATE OR REPLACE FUNCTION total(id_nsc VARCHAR(7))
                                        RETURNS INT
                                        BEGIN
                                            DECLARE hitung INT;
                                            SELECT SUM(dnsc.`banyak`*sc.`harga_satuan`) INTO hitung
                                            FROM Detail_Nota_Suku_Cadang dnsc JOIN Suku_Cadang sc ON dnsc.id_suku_cadang = sc.id_suku_cadang
                                            WHERE dnsc.no_nota_suku_cadang = id_nsc;
                                        RETURN hitung;
                                        END;");
            $hasil                  =  mysqli_query($mysqli, "SELECT total('$latest_id_nsc') AS 'Total'");
            $row_total              =  mysqli_fetch_assoc($hasil);
            $total                  =  $row_total['Total'];
            $resullt1               =  "INSERT INTO pembayaran (id_pkb, total_harga)
                                    VALUES ('$latest_id_pkb', '$total')";
            $add_byr                =  mysqli_query($mysqli, $resullt1);

            unset($_SESSION['keranjang']);

            // JANGAN LUPA D GANTI!!!
            if($add_byr){
                echo "<script>alert('Checkout Berhasil!. Silakan Melakukan Pembayaran!')</script>
                <script>location='../../pages/dashboard/pemilik/billing.php'</script>";
            }
        }

        // 5. Nyari latest id_pemilik kemudian insert into kendaraan biasa
        // $query1                 =  "SELECT id_pemilik FROM pemilik
        //                            ORDER BY id_pemilik DESC LIMIT 1";
        // $execute1               =  mysqli_query($mysqli, $query1);
        // $row                    =  mysqli_fetch_assoc($execute1);
        // $latest_id_pemilik      =  $row['id_pemilik'];
        // $query2                 =  "INSERT INTO kendaraan
        //                            VALUES ('$stnk', '$latest_id_pemilik', '$tipe_kendaraan', '$mesin', '$rangka', '$tahun', '$warna')";
        // $execute2               =  mysqli_query($mysqli, $query2);
    }
?>