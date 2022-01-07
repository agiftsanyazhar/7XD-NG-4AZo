<?php
  // Create database connection using config file
  include_once("../../../config/config.php");

  // errror
  mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

  session_start();
  if($_SESSION['role'] == ""){
    header("location:../../../index.php?pesan=belumSignIn");
  }

  // Fetch all users data from database
  if(isset($_GET['id_pkb'])){
    $kueri              = "SELECT * FROM detail_pesanan_vu
                          WHERE id_pkb='". $_GET['id_pkb'] ."'";
    $detail_pesanan     = mysqli_query($mysqli, $kueri);
  }

  $counter            = 1;

  $query              =   "SELECT * FROM user WHERE email='". $_SESSION['email']."'";
  $result             = mysqli_query($mysqli, $query);

  $row                = mysqli_fetch_assoc($result);

  $_SESSION['nama']   = $row['nama'];
  $_SESSION['email']  = $row['email'];
  $_SESSION['alamat'] = $row['alamat'];
  $_SESSION['telp']   = $row['telp'];
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
  <link rel="apple-touch-icon" sizes="76x76" href="../../../assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="../../../assets/img/favicon.png">
  <title>
    True Bengkel
  </title>
  <!--     Fonts and icons     -->
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
  <!-- Nucleo Icons -->
  <link href="../../../assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="../../../assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <!-- Material Icons -->
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <!-- CSS Files -->
  <link id="pagestyle" href="../../../assets/css/material-dashboard.css" rel="stylesheet" />
</head>

<body class="g-sidenav-show  bg-gray-200">
<div class="container-fluid py-4">
      <div class="row">
        <div class="mt-4">
          <div class="card">
            <div class="card-header pb-0 px-3">
              <h6 class="mb-0">Detail Pesanan</h6>
            </div>
            <div class="card-body pt-4 p-3">
              <ul class="list-group">
                <?php
                  $result     = "SELECT * FROM detail_pesanan_vu
                                ORDER BY no_nota_suku_cadang DESC LIMIT 1";
                  $execute    = mysqli_query($mysqli, $result);
                  $det_pesan  = mysqli_fetch_assoc($execute);
                ?>
                <li class="list-group-item border-0 d-flex p-4 mb-2 bg-gray-100 border-radius-lg">
                  <div class="d-flex flex-column">
                    <h6 class="mb-3 text-sm"><?php echo $det_pesan["no_nota_suku_cadang"]; ?></h6>
                    <span class="mb-2 text-xs">Nama: <span class="text-dark font-weight-bold ms-sm-2"><?php echo $det_pesan["nama_pemilik"]; ?></span></span>
                    <span class="mb-2 text-xs">No. STNK: <span class="text-dark font-weight-bold ms-sm-2"><?php echo $det_pesan["no_stnk"]; ?></span></span>
                    <span class="mb-2 text-xs">Tanggal Pesan: <span class="text-dark ms-sm-2 font-weight-bold"><?php echo $det_pesan["tgl_pesan"]; ?> <?php echo $det_pesan["jam_pesan"]; ?></span></span>
                    <span class="mb-2 text-xs">Tanggal Bayar: <span class="text-dark ms-sm-2 font-weight-bold">
                      <?php 
                        if($det_pesan["status"] == 0){
                          echo "-";
                        } else {
                          echo $det_pesan["tgl_bayar"]." ".$det_pesan["jam_bayar"];
                        }
                      ?>
                    </span></span>
                    <span class="mb-2 text-xs">Status: <span class="text-dark ms-sm-2 font-weight-bold">
                      <?php 
                        if($det_pesan["status"] == 0){
                          echo "Belum Bayar";
                        } else {
                          echo "Sudah Bayar";
                        }
                      ?>
                    </span></span>
                  </div>
                  <div class="ms-auto text-end">
                      <?php 
                        if($det_pesan["status"] == 0){ ?>
                          <a class="btn btn-link text-danger text-gradient px-3 mb-0" href="javascript:;"><i class="material-icons text-sm me-2">info</i>Belum Bayar</a>
                  <?php } else { ?>
                          <a class="btn btn-link text-success text-gradient px-3 mb-0" href="javascript:;"><i class="material-icons text-sm me-2">info</i>Sudah Bayar</a>
                  <?php } ?>
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-12 mt-4">
          <div class="card my-4">
            <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
              <div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
                <h6 class="text-white text-capitalize ps-3">Tagihan</h6>
              </div>
            </div>
            <div class="card-body px-0 pb-0">
              <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 align-middle text-center">Numb</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">ID</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nama Suku Cadang</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Harga</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Qty</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Subtotal</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php $total        = 0; ?>
                    <?php foreach ($detail_pesanan as $det_pesanan) : ?>
                    <tr>
                      <td class="align-middle text-center text-sm">
                        <span class="text-secondary font-weight-bold text-xs"><?php echo $counter; ?></span>
                      </td>
                      <td>
                        <span class="text-secondary font-weight-bold text-xs"><?php echo $det_pesanan["id_suku_cadang"]; ?></span>
                      </td>
                      <td>
                        <span class="text-secondary text-xs font-weight-bold"><?php echo $det_pesanan["nama_suku_cadang"]; ?></span
                        >
                      </td>
                      <td>
                        <span class="text-secondary text-xs font-weight-bold"><?php echo "Rp".number_format($det_pesanan["harga_satuan"], 2, ',', '.'); ?></span>
                      </td>
                      <td>
                        <span class="text-secondary text-xs font-weight-bold"><?php echo $det_pesanan['banyak']; ?></span>
                      </td>
                      <td>
                        <span class="text-secondary text-xs font-weight-bold"><?php echo "Rp".number_format(($det_pesanan['harga_satuan']), 2, ',', '.'); ?></span>
                      </td> 
                    </tr>
                    <?php
                      $counter++;
                      endforeach;   
                    ?>
                  </tbody>
                  <tfoot>
                      <th class="text-uppercase text-secondary font-weight-bold align-middle text-center" colspan="5">Total</th>
                      <th class="text-uppercase text-secondary font-weight-bold">Rp<?php echo number_format(($det_pesanan['total_harga']), 2, ',', '.'); ?></th>
                  </tfoot>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
      <?php 
        if($det_pesan["status"] == 0){ ?>
          <a class="btn bg-gradient-info mb-3 mt-4" href="bayar.php?id_pkb=<?php echo $det_pesanan['id_pkb']; ?>"><i class="material-icons text-sm">attach_money</i>&nbsp;&nbsp;Pay</a>
  <?php } else {
          echo NULL;
        }
      ?>
      <footer class="footer py-4  ">
      <div class="container-fluid">
        <div class="row align-items-center justify-content-lg-between">
          <div class="col-lg-6 mb-lg-0 mb-4">
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
  <div class="fixed-plugin">
    
    <div class="card shadow-lg">
      <div class="card-header pb-0 pt-3">
        <div class="float-start">
          <h5 class="mt-3 mb-0">Material UI Configurator</h5>
          <p>See our dashboard options.</p>
        </div>
        <div class="float-end mt-4">
          <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
            <i class="material-icons">clear</i>
          </button>
        </div>
        <!-- End Toggle Button -->
      </div>
      <hr class="horizontal dark my-1">
      <div class="card-body pt-sm-3 pt-0">
        <!-- Sidebar Backgrounds -->
        <div>
          <h6 class="mb-0">Sidebar Colors</h6>
        </div>
        <a href="javascript:void(0)" class="switch-trigger background-color">
          <div class="badge-colors my-2 text-start">
            <span class="badge filter bg-gradient-primary active" data-color="primary" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-dark" data-color="dark" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-info" data-color="info" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-success" data-color="success" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-warning" data-color="warning" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-danger" data-color="danger" onclick="sidebarColor(this)"></span>
          </div>
        </a>
        <!-- Sidenav Type -->
        <div class="mt-3">
          <h6 class="mb-0">Sidenav Type</h6>
          <p class="text-sm">Choose between 2 different sidenav types.</p>
        </div>
        <div class="d-flex">
          <button class="btn bg-gradient-dark px-3 mb-2 active" data-class="bg-gradient-dark" onclick="sidebarType(this)">Dark</button>
          <button class="btn bg-gradient-dark px-3 mb-2 ms-2" data-class="bg-transparent" onclick="sidebarType(this)">Transparent</button>
          <button class="btn bg-gradient-dark px-3 mb-2 ms-2" data-class="bg-white" onclick="sidebarType(this)">White</button>
        </div>
        <p class="text-sm d-xl-none d-block mt-2">You can change the sidenav type just on desktop view.</p>
        <!-- Navbar Fixed -->
        <div class="mt-3 d-flex">
          <h6 class="mb-0">Navbar Fixed</h6>
          <div class="form-check form-switch ps-0 ms-auto my-auto">
            <input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarFixed" onclick="navbarFixed(this)">
          </div>
        </div>
        <hr class="horizontal dark my-3">
        <div class="mt-2 d-flex">
          <h6 class="mb-0">Light / Dark</h6>
          <div class="form-check form-switch ps-0 ms-auto my-auto">
            <input class="form-check-input mt-1 ms-auto" type="checkbox" id="dark-version" onclick="darkMode(this)">
          </div>
        </div>
        <hr class="horizontal dark my-sm-4">
        <a class="btn btn-outline-dark w-100" href="">View documentation</a>
        <div class="w-100 text-center">
          <a class="github-button" href="https://github.com/creativetimofficial/material-dashboard" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star creativetimofficial/material-dashboard on GitHub">Star</a>
          <h6 class="mt-3">Thank you for sharing!</h6>
          <a href="https://twitter.com/intent/tweet?text=Check%20Material%20UI%20Dashboard%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fsoft-ui-dashboard" class="btn btn-dark mb-0 me-2" target="_blank">
            <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
          </a>
          <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.creative-tim.com/product/material-dashboard" class="btn btn-dark mb-0 me-2" target="_blank">
            <i class="fab fa-facebook-square me-1" aria-hidden="true"></i> Share
          </a>
        </div>
      </div>
    </div>
  </div>
  <!--   Core JS Files   -->
  <script src="../../../assets/js/core/popper.min.js"></script>
  <script src="../../../assets/js/core/bootstrap.min.js"></script>
  <script src="../../../assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="../../../assets/js/plugins/smooth-scrollbar.min.js"></script>
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
  <script src="../../../assets/js/material-dashboard.min.js?v=3.0.0"></script>
  <script type="text/javascript">
    window.print();
  </script>
</body>

</html>