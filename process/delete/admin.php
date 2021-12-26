<?php
    include_once("../../config/config.php");

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if(isset($_GET['id_user'])){
        $result         =   "DELETE FROM user WHERE id_user='" . $_GET['id_user'] . "' ";
        $delete            = mysqli_query($mysqli, $result);

        if($delete){
            header("location:../../pages/dashboard/admin/admin-table.php");
        }
    }
?>