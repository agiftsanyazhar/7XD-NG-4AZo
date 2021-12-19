<?php
    /**
     * using mysqli_connect for database connection
     */
    
    $databaseHost       = 'localhost';
    $databaseName       = 'bengkel_uas';
    $databaseUsername   = 'root';
    $databasePassword   = '';
    
    $mysqli = mysqli_connect($databaseHost, $databaseUsername, $databasePassword, $databaseName);

    // Tes koneksi
    if ( !$mysqli ){
        echo "Koneksi database gagal: ".mysqli_error($mysqli);
    }
?>