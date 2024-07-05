<%@page import="webdesign.model.*"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.List" %>
<%@page import="webdesign.connection.*" %>
<%@page import="webdesign.model.dao.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% User auth = (User) request.getSession().getAttribute("auth");
if (auth != null){
	request.setAttribute("auth", auth);
}

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if(cart_list != null){
	ProductDao pDao = new ProductDao(Databaseconnection.getConnection());
	cartProduct = pDao.getCartProducts(cart_list);
	double total = pDao.totalPrice(cart_list);
	request.setAttribute("cart_list", cart_list);
	request.setAttribute("total", total);
}

%>
<!DOCTYPE html>
<html>
<head>
<title>Hepsişurada Sepetim</title>
<%@include file="includes/head.jsp"%>
<style type="text/css">
.table tbody td {
	vartical-align: middle;
}

.btn-incre, .btn-decre {
	box-shadow: none;
	font-size: 25px;
}
</style>
<style><%@include file="style/font.css"%>
<%@include file="style/cart.css"%>
</style>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">İsim</th>
					<th scope="col">Kategori</th>
					<th scope="col">Ücret</th>
					<th scope="col">Adet</th>				
					<th scope="col">Kaldır</th>
				</tr>
			</thead>
			<% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
			<% } %>
			<tbody>
			<% if(cart_list != null){
				for(Cart c:cartProduct){%>
					<tr>
					<td><%= c.getName() %></td>
					<td><%= c.getCategory() %></td>
					<td><%= c.getPrice() %>TL</td>
					<td>
						<form action="" method="post" class="form-inline">
							<input type="hidden" name="id" value="<%= c.getId() %>" class="form-input">
							<div class="form-group d-flex justify-content-between">
								<a class="btn btn-lg btn-decre" href="increase-decrease?action=dec&id=<%= c.getId()%>"><i
									class="fas fa-minus-square"></i></a> <input type="text"
									name="quantity" class="form-control" value="<%= c.getQuantity() %>" readonly>
								<a class="btn btn-lg btn-incre" href="increase-decrease?action=inc&id=<%= c.getId()%>"><i
									class="fas fa-plus-square"></i></a>
							</div>
						</form>
					</td>
					<td><a class="btn btn-sm btn-danger" href="remove-product-from-cart?id=<%= c.getId() %>"><i class="fa fa-trash"></i></a></td>
				</tr>
				<%}
			}
				
				%>
			</tbody>
		</table>
		<div class="totalprice py-4 mt-5 mx-auto" style ="background-color:gray; border-radius:50px; width:500px">
		<div style="text-align: center;font-size:24px; color:white ">
		<strong>Toplam Ücret: ${ (total>0)?total:0 }<i class="fa fa-try"></i></strong>
		</div>
		</div>
		<div class="paybtn">
		<a class=" btn btn-primary btn-lg paybtn1 <%=(cart_list == null || cart_list.isEmpty()) ? "disabled" : "" %>" href="payment.jsp">
		Ödemeye Geç  <i class="fa fa-credit-card"></i>
		</a>
		</div>
	   </div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>