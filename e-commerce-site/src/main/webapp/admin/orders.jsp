<%@page import="webdesign.model.*"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import = "webdesign.model.dao.*" %>
<%@ page import="webdesign.connection.Databaseconnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
UserdDao usr = new UserdDao(Databaseconnection.getConnection());
List<User> users = usr.getAllUser();
%>

<%
    User user = (User) session.getAttribute("auth");
    if (user == null || !user.isSuperUser()) {
        response.sendRedirect("index.jsp");
    }
    OrderDao ordr = new OrderDao(Databaseconnection.getConnection());
    List<Order> orders = ordr.getAllOrders();
    
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
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">Siparişler</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Ana Sayfa</a></li>
              <li class="breadcrumb-item active">Siparişler</li>
            </ol>
          </div>
        </div>
      </div>
    </div>
    <section class="content">
      <div class="container-fluid">
        <div class="card">
          <div class="card-header">
            <h3 class="card-title">Siparişler</h3>
          </div>
          <div class="card-body">
            <table id="productTable" class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Kullanıcı Adı</th>
                  <th>Sipariş Tarihi</th>
                  <th>Toplam Tutar</th>
                  <th>Ödeme Yöntemi</th>
                  <th>İşlemler</th>
                </tr>
              </thead>
              <tbody>
              <%
              	if(!orders.isEmpty()){
              		for(Order i:orders){
              			User orderUser = usr.getUserById(i.getUserId());
              			String userName = orderUser.getName();
              		%>
              		
              	
                <tr>
                  <td><%=i.getId() %></td>
                  <td><%= userName %>
                  <td><%=i.getOrderDate() %></td>
                  <td><%=i.getTotalPrice() %></td>
                  <td><%=i.getPaymentMethod() %></td>
                  <td>
                    <a href="delete-order?id=<%= i.getId() %>" class="btn btn-danger btn-sm"><i class="fas fa-trash"></i> Sil</a>
                  </td>
                </tr>
                
                  
                   <% }
              	  }
                %>
              </tbody>
            </table>
            <br>
            
          </div>
        </div>
      </div>
    </section>
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
