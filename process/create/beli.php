<?php
    include_once("../../config/config.php");

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    $id         = $_GET['id_suku_cadang'];

    if(isset($_SESSION['keranjang'][$id])){
        $_SESSION['keranjang'][$id]+=1;
    } else {
        $_SESSION['keranjang'][$id] = 1;
    }

    echo "<script>alert('Produk telah ditambahkan ke keranjang belanja')</script>
        <script>location='../../pages/dashboard/pemilik/suku-cadang-table.php'</script>";
?>