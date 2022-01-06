<?php
    include_once('../../config/config.php');

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if(isset($_POST['add-kendaraan-sign-up'])){
        // 2. Data kendaraan
        $stnk                   =  $_POST['no_stnk'];
        $tipe_kendaraan         =  $_POST['id_tipe'];
        $mesin                  =  $_POST['no_mesin'];
        $rangka                 =  $_POST['no_rangka'];
        $warna                  =  $_POST['warna'];
        $tahun                  =  $_POST['tahun'];

        // 5. Nyari latest id_pemilik kemudian insert into kendaraan biasa
        $query1                 =  "SELECT id_pemilik FROM pemilik
                                   ORDER BY id_pemilik DESC LIMIT 1";
        $execute1               =  mysqli_query($mysqli, $query1);
        $row                    =  mysqli_fetch_assoc($execute1);
        $latest_id_pemilik      =  $row['id_pemilik'];

        $sql_cek        = mysqli_query($mysqli,"SELECT * FROM kendaraan WHERE no_stnk='$stnk'");
        $r_cek          = mysqli_num_rows($sql_cek);

        if ($r_cek>0) {
            echo "<script>alert('Data Kendaraan Sudah Terdaftar! Jika Ada Masalah Silakan Hubungi Admin.')</script>
            <script>location='../../index.php'</script>";
        } else {
            $query2              =  "INSERT INTO kendaraan
                                       VALUES ('$stnk', '$latest_id_pemilik', '$tipe_kendaraan', '$mesin', '$rangka', '$tahun', '$warna')";
            $execute2            =  mysqli_query($mysqli, $query2);
        }

        // JANGAN LUPA D GANTI!!!
        if($execute2){
            header("location:../../index.php");
        }
    }
?>