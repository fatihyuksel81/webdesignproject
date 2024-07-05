<%@ page import="webdesign.model.Product" %>
<%@ page import="webdesign.model.dao.ProductDao" %>
<%@ page import="webdesign.connection.Databaseconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="tr">
<html>
<head>
<meta charset="UTF-8">
<%
    int productId = Integer.parseInt(request.getParameter("id"));
    ProductDao productDao = new ProductDao(Databaseconnection.getConnection());
    Product product = productDao.getProductById(productId);
    
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    if(cart_list != null){
    	request.setAttribute("cart_list", cart_list);
    }
%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ürün Güncelleme</title>
<%@include file="includes/head.jsp"%>
<%@include file="includes/navbar.jsp" %>
    <style>
    <%@include file="style/productdetail.css"%>
    </style>
<style><%@include file="style/font.css"%></style>
</head>
<body>
    <div class="container mt-5">
        <div class="card">
            <div class="row no-gutters">
                <aside class="col-md-6">
                    <article class="gallery-wrap">
                        <div class="img-big-wrap">
                            <div> <a href="#"><img src="product-icon/<%= product.getId() %>.png" class="product-image"></a></div>
                        </div>
                    </article>
                </aside>
                <main class="col-md-6">
                    <article class="content-body">
                        <h2 class="title mt-3 mb-3 ml-5"><%= product.getName() %></h2>
                        <div class="mb-3">
                            <var class="price h4">Ürün Fiyatı: <%= product.getPrice() %> TL</var>
                        </div>
                        <dl>
                            <dt class = "ml-4 mb-2">Açıklama</dt>
                            <dd class="product-description ml-1"><%= product.getDescription() %></dd>
                        </dl>
                    </article>
                </main>
               <a href="cart-add?id=<%= product.getId() %>" class="btn btn-primary btn-lg btn-block " style="border-top-left-radius:25px;border-top-right-radius:25px; background-color:#6767e0; border:#6767e0;border-bottom-left-radius:0px;border-bottom-right-radius:0px;">Sepete Ekle</a>
            </div>
        </div>
    </div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>
