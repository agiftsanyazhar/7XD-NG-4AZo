<?php
    // Create database connection using config file
    include_once("../config/config.php");

    // errror
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    if(isset($_POST['sign-up'])){
        // menangkap data yang dikirim dari form
        $nama           = filter_input(INPUT_POST, 'nama', FILTER_SANITIZE_STRING);          //$_POST['nama'];
        $email          = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);          //$_POST['email'];
        $password       = md5($_POST['password']);          //md5($_POST['password']);
        // $repassword     = md5($_POST['repassword']);          //md5($_POST['password']);
        $role           = "pemilik";          //md5($_POST['password']);
        $alamat         = filter_input(INPUT_POST, 'alamat', FILTER_SANITIZE_STRING);
        $telp           = $_POST['telp'];

        // menyiapkan query insert
        $result         =   "INSERT INTO user (nama, email, password, role, alamat, telp)
                            VALUES ('$nama', '$email', '$password', '$role', '$alamat', '$telp')";
        $signup         = mysqli_query($mysqli, $result);

        // $stmt           = $mysqli->prepare($result);

        // // bind parameter ke query
        // $validatedData = array(
        //     ":nama"     => $nama,
        //     ":email"    => $email,
        //     ":password" => $password,
        //     ":repassword" => $repassword,
        //     ":role"     => 'pemilik',
        //     ":alamat"   => $alamat,
        //     ":telp"     => $telp,
        // );

        // $saved            = $stmt->execute($validatedData);

        if($signup){
            header("location:sign-in.php?pesan=successSignUp");
        } else {
            header("location:sign-up.php?pesan=errorSignUp");
        }
    }
?>