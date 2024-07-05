<%@ page import="webdesign.model.*" %>
<%@ page import="webdesign.model.dao.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="webdesign.connection.Databaseconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="tr">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"/>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<head>
<meta charset="UTF-8">
<%
    int orderId = Integer.parseInt(request.getParameter("id"));
    OrderDetailDao ordr = new OrderDetailDao(Databaseconnection.getConnection());
    List<OrderDetail> orderdetail = ordr.getOrderDetailById(orderId);
    int totalprice = 0;
    
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if(cart_list != null){
    	request.setAttribute("cart_list", cart_list);
    }
%>
<style><%@include file="style/orderdetail.css"%></style>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ürün Güncelleme</title>
<%@include file="includes/head.jsp"%>
<%@include file="includes/navbar.jsp" %>

</head>
<body  style="background-color: #faf3e0;">

<div class="container mt-5 ">
    <div class="row">
        <div class="col-xl-8">
            <% for (OrderDetail i : orderdetail) {
                int productId = i.getProductId();
                ProductDao productDao = new ProductDao(Databaseconnection.getConnection());
                Product product = productDao.getProductById(productId);
                totalprice += i.getQuantity() * product.getPrice();
            %>
            <div class="card border shadow-none">
                <div class="card-body">
                    <div class="d-flex align-items-start border-bottom pb-3">
                        <div class="flex-grow-1 align-self-center overflow-hidden">
                            <div>
                                <h5 class="text-truncate font-size-18"><a href="product_detail.jsp?id=<%= product.getId() %>" class="text-dark"><%= product.getName() %></a></h5>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="mt-3">
                                    <p class="text-muted mb-2">Fiyat</p>
                                    <h5 class="mb-0 mt-2"><span class="text-muted me-2"></span><%= product.getPrice() %><i class="fa fa-try"></i></h5>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="mt-3">
                                    <p class="text-muted mb-2">Adet</p>
                                    <h5><%= i.getQuantity() %> Tane</h5>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="mt-3">
                                    <p class="text-muted mb-2">Toplam Tutarı</p>
                                    <h5><%= i.getQuantity() * product.getPrice() %><i class="fa fa-try"></i></h5>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <div class="col-xl-4">
            <div class="mt-5 mt-lg-0">
                <div class="card border shadow-none">
                    <div class="card-header bg-transparent border-bottom py-3 px-4">
                        <h5 class="font-size-16 mb-0">Sipariş Özeti <span class="float-end"></span></h5>
                    </div>
                    <div class="card-body p-4 pt-2">
                        <div class="table-responsive">
                            <table class="table mb-0">
                                <tbody>

                                    <tr class="bg-light">
                                        <th>Toplam Tutar :</th>
                                        <td class="text-end">
                                            <span class="fw-bold">
                                                <%= totalprice %><i class="fa fa-try"></i>
                                            </span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@include file="includes/footer.jsp"%>
</div>

</body>
</html>
