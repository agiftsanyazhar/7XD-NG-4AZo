<?php
    include_once('../../config/config.php');

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if(isset($_POST['checkout'])){
        // 1. Data diri pemilik
        $nama                   = $_POST['nama'];
        $alamat                 = $_POST['alamat'];
        $email                  = $_POST['email'];
        $telp                   = $_POST['telp'];

        // 2. Data kendaraan
        $stnk                   = $_POST['no_stnk'];
        $tipe_kendaraan         = $_POST['id_tipe'];
        $mesin                  = $_POST['no_mesin'];
        $rangka                 = $_POST['no_rangka'];
        $warna                  = $_POST['warna'];
        $tahun                  = $_POST['tahun'];

        // 3. Set id_nsc & id_pkb buat auto set d masing" tabel, tapi nanti d trigger, cuma buat set doang.
        $id_nsc                 = '1';
        $id_pkb                 = '1';

        // 4. Insert into biasa
        $query                  = "INSERT INTO pemilik (nama_pemilik, email, alamat_pemilik, telp_pemilik)
                                  VALUES ('$nama', '$email', '$alamat', '$telp')";
        $execute                = mysqli_query($mysqli, $query);

        // 5. Nyari latest id_pemilik kemudian insert into kendaraan biasa
        $query1                 = "SELECT id_pemilik FROM pemilik
                                  ORDER BY id_pemilik DESC LIMIT 1";
        $execute1               = mysqli_query($mysqli, $query1);
        $row                    = mysqli_fetch_assoc($execute1);
        $latest_id_pemilik      = $row['id_pemilik'];
        $query2                 = "INSERT INTO kendaraan
                                  VALUES ('$stnk', '$latest_id_pemilik', '$tipe_kendaraan', '$mesin', '$rangka', '$tahun', '$warna')";
        $execute2               = mysqli_query($mysqli, $query2);

        // 6. Set trigger nsc d sini
        $query3                 = "INSERT INTO nota_suku_cadang (no_nota_suku_cadang) VALUES ('$id_nsc')";
        $execute3               = mysqli_query($mysqli, $query3);

        // 7. Nyari latest no_nota_suku_cadang kemudian insert into biasa (kek no. 5).
        $query4                 = "SELECT no_nota_suku_cadang FROM nota_suku_cadang
                                  ORDER BY no_nota_suku_cadang DESC LIMIT 1";
        $execute4               = mysqli_query($mysqli, $query4);
        $row_nsc                = mysqli_fetch_assoc($execute4);
        $latest_id_nsc          = $row_nsc['no_nota_suku_cadang'];

        foreach ($_SESSION['keranjang'] as $id_produk => $qty) {
            // 8. Insert into biasa
            $query5                 = "INSERT INTO detail_nota_suku_cadang VALUES ('$latest_id_nsc', '$id_produk', $qty)";
            $execute5               = mysqli_query($mysqli, $query5);
        }

        unset($_SESSION['keranjang']);

        // JANGAN LUPA D GANTI!!!
        if($execute5){
            echo "<script>alert('Checkout Berhasil. Silakan melunasi pembayaran!')</script>
            <script>location='../../pages/dashboard/pemilik/billing.php'</script>";
        }
    }
?>