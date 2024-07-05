<%@page import="webdesign.model.*"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import = "webdesign.model.dao.ProductDao" %>
<%@ page import="webdesign.connection.Databaseconnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

List<Product> products = (List<Product>) request.getAttribute("products");

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if(cart_list != null){
	request.setAttribute("cart_list", cart_list);
	

}
%>

<!DOCTYPE html>
<html>
<head>
<title>Hepsişurada</title>
<%@include file="includes/head.jsp"%>

</head>
<style><%@include file="style/font.css"%>
<%@include file="style/allproducts.css"%>
</style>

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
		<text1>Arama Sonucu</text1>
		</div>
		</div>
		<div class="row">
		<%
			if(products != null && !products.isEmpty()){
				for(Product i:products){%>
					<div class="col-md-3">
					<div class="card w-100 product-card" style="width: 18rem;">
						<div> 
                     	        <a href="product_detail.jsp?id=<%= i.getId() %>">
                                    <img src="<%= request.getContextPath() %>/product-icon/<%= i.getId() %>.png" class="product-image">
                                </a>
                        </div>
						<div class="card-body">
							<a href = "product_detail.jsp?id=<%= i.getId() %>" style = "color:purple"><%= i.getName() %></a>
							<h6 class="category">Kategori: <%= i.getCategory() %></h6>
							<div class="price-container">
                                    <h6 class="price">Fiyat: <%= i.getPrice() %>TL</h6>
                                    <a href="cart-add?id=<%= i.getId() %>" class="btn btn-dark" style="background-color: #6767e0;"><i class="fa fa-shopping-cart"></i></a>
                            </div>
						</div>
					</div>
				</div>
				<% }
			}
		%>
		</div>
	</div>


	<%@include file="includes/footer.jsp"%>
</body>
</html>

