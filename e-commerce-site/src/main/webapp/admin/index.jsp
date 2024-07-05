<%@page import="webdesign.model.*"%>
<%@page import="java.util.List" %>
<%@page import = "webdesign.model.dao.UserdDao" %>
<%@ page import="webdesign.connection.Databaseconnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    // Kullanıcı yetkilendirme kontrolü
    User user = (User) session.getAttribute("auth");
    if (user == null || !user.isSuperUser()) {
        response.sendRedirect("index.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Paneli</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/3.0.5/css/adminlte.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="index.jsp" class="nav-link">Ana Sayfa</a>
      </li>
    </ul>
    <ul class="navbar-nav ml-auto">
      <li class="nav-item">
        <a class="nav-link" href="../LogoutServlet">
          Çıkış Yap <i class="fas fa-sign-out-alt"></i>
        </a>
      </li>
    </ul>
  </nav>
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="index.jsp" class="brand-link">
      <img src="logos/hepsisurada.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
           style="opacity: .8">
      <span class="brand-text font-weight-light">ADMIN</span>
    </a>
    <div class="sidebar">
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <li class="nav-item">
            <a href="index.jsp" class="nav-link">
              <i class="nav-icon fas fa-home"></i>
              <p>
                Ana Sayfa
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="users.jsp" class="nav-link">
              <i class="nav-icon fas fa-users"></i>
              <p>
                Kullanıcılar
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="products.jsp" class="nav-link">
              <i class="nav-icon fas fa-box"></i>
              <p>
                Ürünler
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="orders.jsp" class="nav-link">
              <i class="nav-icon fas fa-shopping-cart"></i>
              <p>
                Siparişler
              </p>
            </a>
          </li>
        </ul>
      </nav>
    </div>
  </aside>

  <div class="content-wrapper">
  </div>

  <aside class="control-sidebar control-sidebar-dark">
  </aside>
  <footer class="main-footer">
    <div class="float-right d-none d-sm-inline">
      Anything you want
    </div>
    <strong>Admin Paneli &copy; 2024 <a href="#">WebDesign</a>.</strong> All rights reserved.
  </footer>
</div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/admin-lte/3.0.5/js/adminlte.min.js"></script>
</body>
</html>
