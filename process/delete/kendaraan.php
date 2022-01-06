<?php
    include_once("../../config/config.php");

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if(isset($_GET['no_stnk'])){
        $result         =   "DELETE FROM kendaraan WHERE no_stnk='" . $_GET['no_stnk'] . "'";
        $delete         = mysqli_query($mysqli, $result);

        if($delete){
            header("location:../../pages/dashboard/pemilik/kendaraan-table.php");
        }
    }
?>