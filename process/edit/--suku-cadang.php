<?php
    include_once("../../config/config.php");

    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();

    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if(isset($_POST['edit-suku-cadang'])){
        $nama           = $_POST['nama_suku_cadang'];
        $harga          = $_POST['harga_satuan'];
        $stok           = $_POST['stok'];

        $gambar         = $_FILES['gambar_suku_cadang']['name'];
        $lokasi         = $_FILES['gambar_suku_cadang']['tmp_name'];
        if(!empty($lokasi)){
            move_uploaded_file($lokasi, '../../assets/gambar-suku-cadang/'.$gambar);

            $result         =   "UPDATE suku_cadang
                                SET nama_suku_cadang='$nama', gambar_suku_cadang='$gambar', stok='$stok', harga_satuan='$harga'
                                WHERE id_suku_cadang='" . $_GET['id_suku_cadang'] ."' '";
            $edit            = mysqli_query($mysqli, $result);

        } else {
            $result         =   "UPDATE suku_cadang
                                SET nama_suku_cadang='$nama', stok='$stok', harga_satuan='$harga'
                                WHERE id_suku_cadang='" . $_GET['id_suku_cadang'] ."' ";
            $edit            = mysqli_query($mysqli, $result);
        }

        if($edit){
            header("location:../../pages/dashboard/admin/suku-cadang-table.php");
        }
    }
?>