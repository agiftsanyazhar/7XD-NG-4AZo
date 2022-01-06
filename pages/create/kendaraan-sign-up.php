<?php
    // Create database connection using config file
    include_once("../../config/config.php");

    // errror
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
?>

<!--
=========================================================
* Material Dashboard 2 - v3.0.0
=========================================================

* Product Page: https://www.creative-tim.com/product/material-dashboard
* Copyright 2021 True Bengkel (https://www.creative-tim.com)
* Licensed under MIT (https://www.creative-tim.com/license)
* Coded by True Bengkel

=========================================================

* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
-->
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="../../assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="../../assets/img/favicon.png">
  <title>
   True Bengkel
  </title>
  <!--     Fonts and icons     -->
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
  <!-- Nucleo Icons -->
  <link href="../../assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="../../assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <!-- Material Icons -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <!-- CSS Files -->
  <link id="pagestyle" href="../../assets/css/material-dashboard.css" rel="stylesheet" />
</head>

<body class="bg-gray-200">
  <main class="main-content  mt-0">
    <div class="page-header align-items-start min-vh-100" style="background-image: url('https://images.unsplash.com/photo-1497294815431-9365093b7331?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80');">
      <span class="mask bg-gradient-dark opacity-6"></span>
      <div class="container my-auto">
        <div class="row">
          <div class="col-lg-6 col-md-8 col-12 mx-auto">
            <div class="card z-index-0 fadeIn3 fadeInBottom">
              <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
              <?php
                    if(isset($_GET['pesan'])){
                      if($_GET['pesan'] == "successSignUp"){ ?>
                       <div class="alert alert-success alert-dismissible fade show" role="alert">
                          Sign Up Berhasil! Silakan Tambah Kendaraan Anda!
                        </div>
                <?php }
                    }
                   ?>
                <div class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-1">
                  <h4 class="text-white font-weight-bolder text-center mb-0">Add Kendaraan</h4>
                </div>
              </div>
              <div class="card-body">
              <form method="POST" action="../../process/create/kendaraan-sign-up.php" role="form" class="text-start">
                    <div class="row my-3">
                      <div class="col-md-6">
                        <div class="input-group input-group-outline">
                          <input type="text" placeholder="No. STNK (Contoh: XX-1234-XX)" class="form-control" name="no_stnk" maxlength="10" required>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="input-group input-group-outline">
                          <select class="form-control" name="id_tipe" required>
                              <option value="" disabled selected hidden>Tipe Kendaraan</option>
                              <?php
                                $result          = " SELECT * FROM tipe_kendaraan ";
                                $tipe_kendaraans = mysqli_query($mysqli, $result);

                                foreach ($tipe_kendaraans as $tipe_kendaraan) :
                              ?>
                              <option value="<?php echo $tipe_kendaraan['id_tipe']; ?>"><?php echo $tipe_kendaraan['nama_tipe']; ?></option>
                              <?php endforeach; ?>
                          </select>
                        </div>
                      </div>
                    </div>
                    <div class="row my-3">
                      <div class="col-md-6">
                        <div class="input-group input-group-outline">
                          <input type="text" placeholder="No. Mesin" class="form-control" name="no_mesin" maxlength="14" required>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="input-group input-group-outline">
                          <input type="text" placeholder="No. Rangka" class="form-control" name="no_rangka" maxlength="18" required>
                        </div>
                      </div>
                    </div>
                    <div class="row my-3">
                      <div class="col-md-6">
                        <div class="input-group input-group-outline">
                          <input type="text" placeholder="Warna" class="form-control" name="warna" >
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="input-group input-group-outline">
                          <input type="number" placeholder="Tahun" class="form-control" name="tahun" maxlength="9999" required>
                        </div>
                      </div>
                    </div>
                    <div class="text-center">
                      <div class="text-center">
                        <button type="submit" class="btn bg-gradient-primary w-100 my-4 mb-2" name="add-kendaraan-sign-up">Add</button>
                      </div>
                    </div>
                  </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <footer class="footer position-absolute bottom-2 py-2 w-100">
        <div class="container">
          <div class="row align-items-center justify-content-lg-between">
            <div class="col-12 col-md-6 my-auto">
              <div class="copyright text-center text-sm text-muted text-lg-start">
                  © <script>
                    document.write(new Date().getFullYear())
                  </script>,
                  made with <i class="fa fa-heart"></i> by
                  <strong><span>True Bengkel</strong></span>
                  for a better web.
              </div>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </main>
  <!--   Core JS Files   -->
  <script src="../../assets/js/core/popper.min.js"></script>
  <script src="../../assets/js/core/bootstrap.min.js"></script>
  <script src="../../assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="../../assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>
  <!-- Github buttons -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  <!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="../../assets/js/material-dashboard.min.js?v=3.0.0"></script>
</body>

</html>