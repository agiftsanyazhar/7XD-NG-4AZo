<?php
    // mengaktifkan session php
    session_start();
    
    // Create database connection using config file
    include_once("../config/config.php");
    
    // menangkap data yang dikirim dari form
    $email          = $_POST['email'];
    $password       = $_POST['password'];

    // Fetch all users data from database
    $result         =   "SELECT * FROM admin
                        WHERE email='$email' AND password='$password'";
    $admins         = mysqli_query($mysqli, $result);
    
    // menghitung jumlah data yang ditemukan
    $cek            = mysqli_num_rows($admins);
    
    if($cek > 0){
        $_SESSION['email']  = $email;
        $_SESSION['status'] = "signin";
        header("location:../pages/dashboard/admin/dashboard.php");
    } else {
        header("location:../sign-in.php?pesan=errorSignIn");
    }
?>