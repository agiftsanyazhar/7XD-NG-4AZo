<?php
    // Create database connection using config file
    include_once("../../config/config.php");

    // errror
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    $user       = mysqli_query($mysqli, "SELECT * FROM pemilik WHERE email='". $_SESSION['email'] ."'");
    $cek        = mysqli_num_rows($user);

    if($cek>0){
        header("location:../../index.php?pesan=belumSignIn");
    }
?>