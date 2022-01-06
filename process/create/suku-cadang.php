<?php
    include_once("../../config/config.php");

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if(isset($_POST['add-suku-cadang'])){
        $id             = $_POST['id_suku_cadang'];
        $nama           = $_POST['nama_suku_cadang'];
        $harga          = $_POST['harga_satuan'];
        $stok           = $_POST['stok'];

        $gambar         = $_FILES['gambar_suku_cadang']['name'];
        $lokasi         = $_FILES['gambar_suku_cadang']['tmp_name'];
        move_uploaded_file($lokasi, '../../assets/suku-cadang/'.$gambar);

        $result         =   "INSERT INTO suku_cadang VALUES ('$id', '$nama', '$gambar', $stok, $harga)";
        $add            =   mysqli_query($mysqli, $result);

        if($add){
            header("location:../../pages/dashboard/admin/suku-cadang-table.php");
        }
    }
?>