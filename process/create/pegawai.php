<?php
    // Create database connection using config file
    include_once("../../config/config.php");

    // errror
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if(isset($_POST['add-pegawai'])){
        // menangkap data yang dikirim dari form
        $id_jabatan     = $_POST['id_jabatan'];
        $nama           = filter_input(INPUT_POST, 'nama', FILTER_SANITIZE_STRING);         //$_POST['nama'];
        $email          = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);         //$_POST['email'];
        $password       = md5($_POST['password']);
        $role           = "pegawai";
        $alamat         = $_POST['alamat'];
        $telp           = $_POST['telp'];

        $sql_cek        = mysqli_query($mysqli,"SELECT * FROM user WHERE email='$email' OR telp='$telp'");
        $r_cek          = mysqli_num_rows($sql_cek);

        if ($r_cek>0) { ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Email atau Telepon Telah Terdaftar!
            </div>
            <meta http-equiv="refresh" content="3;url=../../pages/create/pegawai.php">
<?php        } else {
            $query         =    "INSERT INTO user (id_jabatan, nama, email, password, role, alamat, telp)
                                VALUES ('$id_jabatan', '$nama', '$email', '$password', '$role', '$alamat', '$telp');
                                INSERT INTO pegawai
                                SELECT id_user, id_jabatan, nama, email, password, alamat, telp FROM USER
                                ORDER BY id_user DESC LIMIT 1";
            $signup        = $mysqli->multi_query($query);

            do {
                if ($result = $mysqli->store_result()) {
                    var_dump($result->fetch_all(MYSQLI_ASSOC));
                    $result->free();
                }
            } while ($mysqli->next_result());

            if($signup){
                header("location:../../pages/dashboard/admin/pegawai-table.php");
            }
        }
    }
?>