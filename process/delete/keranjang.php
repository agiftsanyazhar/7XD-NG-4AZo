<?php
    include_once("../../config/config.php");

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    $id         = $_GET['id_suku_cadang'];

    unset($_SESSION['keranjang'][$id]);

    echo "<script>location='../../pages/dashboard/pemilik/keranjang.php'</script>";
?>