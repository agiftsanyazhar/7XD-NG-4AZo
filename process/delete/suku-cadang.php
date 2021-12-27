<?php
    include_once("../../config/config.php");

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if(isset($_GET['id_suku_cadang'])){
        $result         =   "DELETE FROM suku_cadang WHERE id_suku_cadang='" . $_GET['id_suku_cadang'] . "'";
        $delete         = mysqli_query($mysqli, $result);

        if($delete){
            header("location:../../pages/dashboard/admin/suku-cadang-table.php");
        }
    }
?>