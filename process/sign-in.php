<?php
    // mengaktifkan session php
    session_start();
    
    // Create database connection using config file
    include_once("../config/config.php");

    // errror
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    
    // menangkap data yang dikirim dari form
    $email          = $_POST['email'];
    $password       = md5($_POST['password']);

    // Fetch all users data from database
    $result         =   "SELECT * FROM user WHERE email='$email' AND password='$password'";
    $signin         = mysqli_query($mysqli, $result);
    
    // menghitung jumlah data yang ditemukan
    $cek            = mysqli_num_rows($signin);
    
    if($cek > 0){
        $data   = mysqli_fetch_assoc($signin);

        if($data['role'] == "admin"){
            $_SESSION['email']  = $email;
            $_SESSION['role'] = "admin";
            header("location:../pages/dashboard/admin/dashboard.php");
        } else if($data['role'] == "pegawai"){
            $_SESSION['email']  = $email;
            $_SESSION['role'] = "pegawai";
            header("location:../pages/dashboard/pegawai/dashboard.php");
        } else if($data['role'] == "pemilik"){
            $_SESSION['email']  = $email;
            $_SESSION['role'] = "pemilik";
            header("location:../pages/dashboard/pemilik/suku-cadang-table.php");
        } else {
            header("location:../index.php?pesan=errorSignIn");
        }
    } else {
        header("location:../index.php?pesan=errorSignIn");
    }
?>