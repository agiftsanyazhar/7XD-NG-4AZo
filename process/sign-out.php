<?php
    session_start();

    session_destroy();

    // errror
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

    header("location:../index.php?pesan=successSignOut");
?>