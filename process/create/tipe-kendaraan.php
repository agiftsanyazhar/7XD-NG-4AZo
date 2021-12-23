<?php
  // Create database connection using config file
  include_once("../../config/config.php");

  session_start();
  if($_SESSION['role'] == ""){
    header("location:../../sign-in.php?pesan=belumSignIn");
  }

  
  if(isset($_POST['add-tipe-kendaraan'])){
    // menangkap data yang dikirim dari form
    $nama           = filter_input(INPUT_POST, 'nama_tipe', FILTER_SANITIZE_STRING);

    // menyiapkan query insert
    $result         =   "INSERT INTO tipe_kendaraan (nama_tipe) VALUES ('$nama')";
    $add            = mysqli_query($mysqli, $result);

    if($add){
        header("location:../../pages/dashboard/admin/tipe-kendaraan-table.php");
    }
  }
?>