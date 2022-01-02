<?php
    include_once('../../config/config.php');

    mysqli_report(MYSQLI_REPORT_STRICT | MYSQLI_REPORT_ERROR);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if(isset($_POST['bayar'])){
        $id             = $_GET['id_pkb'];
        $gambar         = $_FILES['bukti_pembayaran']['name'];
        $lokasi         = $_FILES['bukti_pembayaran']['tmp_name'];
        move_uploaded_file($lokasi, '../../assets/bukti-pembayaran/'.$gambar);

        // $result         = "INSERT INTO pembayaran (tgl_bayar, jam_bayar, bukti_pembayaran)
        //                   VALUES (SYSDATE(), CURRENT_TIMESTAMP, '$gambar')";
        $result         = "UPDATE pembayaran
                          SET tgl_bayar=SYSDATE(), jam_bayar=CURRENT_TIMESTAMP, bukti_pembayaran='$gambar'
                          WHERE id_pkb='$id'";
        $update         = mysqli_query($mysqli, $result);

        if($update){
            header("location:../../pages/dashboard/pemilik/billing.php");
        }
    }
?>