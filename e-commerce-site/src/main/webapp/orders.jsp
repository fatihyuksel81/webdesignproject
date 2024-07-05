<%@page import="webdesign.model.*"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import = "webdesign.model.dao.*" %>
<%@ page import="webdesign.connection.Databaseconnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
    request.setAttribute("auth", auth);
}

ProductDao prod = new ProductDao(Databaseconnection.getConnection());
List<Product> products = prod.getAllProducts();

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
    request.setAttribute("cart_list", cart_list);
}

OrderDao ordr = new OrderDao(Databaseconnection.getConnection());   
List<Order> orders = new ArrayList<>();
if (auth != null) {
    orders = ordr.getMyOrders(auth.getId());
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Hepsişurada</title>
<%@include file="includes/head.jsp"%>
<style><%@include file="style/font.css"%>
<%@include file="style/allproducts.css"%>
<%@include file="style/order.css" %>
</style>
</head>

<body>
    <%@include file="includes/navbar.jsp"%>
    
<% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger" role="alert">
        <%= request.getAttribute("error") %>
    </div>
<% } %>

    <div class="container">

        <div class="card-header my-5" style ="background-color: orange; border-radius:50px">
		<div style="text-align: center;font-size:20px ">
		<text1>Siparişlerim</text1>
		</div>
		</div>
        <div class="row">
        <% if (orders != null && !orders.isEmpty()) {
            for (Order i : orders) { %>
                <div class="col-md-3">
                    <div class="card w-100" style="width: 18rem;">
                        <div class="card-body">
                        	<div class="orderno" style="text-align: center; ">
                            <a href="order_detail.jsp?id=<%= i.getId() %>" class="id stretched-link" style="text-decoration: none; color:purple"><%= i.getId() %>Nolu Sipariş</a>
                            </div>
                            <h6 class="category">Sipariş Boyutu: <%= i.getQuantity() %></h6>
                            <h6 class="price">Toplam Tutar: <%= i.getTotalPrice() %><i class="fa fa-try"></i></h6>
                            <h6 class="payment_method">Ödeme Yöntemi: <%= i.getPaymentMethod() %></h6>
                            <h6 class="order_date">Sipariş Tarihi: <%= i.getOrderDate() %></h6>
                            <div class="mt-3 d-flex justify-content-between">
                            </div>
                        </div>
                    </div>
                </div>
            <% }
        } else { %>
            <div class="col-md-12">
                <div class="alert alert-info" role="alert">
                    Henüz siparişiniz bulunmamaktadır.
                </div>
            </div>
        <% } %>
        </div>
    </div>

    <%@include file="includes/footer.jsp"%>
</body>
</html>
