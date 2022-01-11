<?php
    // Create database connection using config file
    include_once("../../config/config.php");

    // errror
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    session_start();
    if($_SESSION['role'] == ""){
        header("location:../../index.php?pesan=belumSignIn");
    }

    if(isset($_POST['add-admin'])){
        // menangkap data yang dikirim dari form
        $nama           = filter_input(INPUT_POST, 'nama', FILTER_SANITIZE_STRING);         //$_POST['nama'];
        $email          = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);         //$_POST['email'];
        $password       = md5($_POST['password']);
        $role           = "admin";

        $sql_cek        = mysqli_query($mysqli,"SELECT * FROM user WHERE email='$email'");
        $r_cek          = mysqli_num_rows($sql_cek);

        if ($r_cek>0) { ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                Email Telah Terdaftar! Silakan Sign In
            </div>
            <meta http-equiv="refresh" content="3;url=../index.php">
<?php        } else {
            $query         =    "INSERT INTO user (nama, email, password, role)
                                VALUES ('$nama', '$email', '$password', '$role');
                                INSERT INTO Admin
                                SELECT id_user, nama, email, PASSWORD FROM USER
                                ORDER BY id_user DESC LIMIT 1";
            $signup        = $mysqli->multi_query($query);

            do {
                if ($result = $mysqli->store_result()) {
                    var_dump($result->fetch_all(MYSQLI_ASSOC));
                    $result->free();
                }
            } while ($mysqli->next_result());

            if($signup){
                header("location:../../pages/dashboard/admin/admin-table.php");
            }
        }
    }
?>