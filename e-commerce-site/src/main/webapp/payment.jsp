<%@page import="webdesign.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="webdesign.connection.*"%>
<%@page import="webdesign.model.dao.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
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
<title>Ödeme Sayfası</title>
<%@include file="includes/head.jsp"%>
<style type="text/css">
.table tbody td {
	vertical-align: middle;
}

.btn-incre, .btn-decre {
	box-shadow: none;
	font-size: 25px;
}
</style>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>
	<style><%@include file="style/payment.css"%></style>
	<br>
	<br>
<form action="order" method="post">
	<div class="container">
		<h1 class="h3 mb-5">Ödeme</h1>
		<div class="row">
			<div class="col-lg-9">
				<div class="accordion" id="accordionPayment">
					<div class="accordion-item mb-3">
						<h2
							class="h5 px-4 py-3 accordion-header d-flex justify-content-between align-items-center">
							<div class="form-check w-100 collapsed" data-bs-toggle="collapse"
								data-bs-target="#collapseCC" aria-expanded="false">

								<input class="form-check-input" type="radio" name="payment_method"
									id="payment1" value="Kredi Kartı"> <label class="form-check-label pt-1"
									for="payment1"> Kredi Kartıyla Ödeme </label>
							</div>
							<span> <svg width="34" height="25"
									xmlns="http://www.w3.org/2000/svg">
                  <g fill-rule="nonzero" fill="#333840">
                    <path
										d="M29.418 2.083c1.16 0 2.101.933 2.101 2.084v16.666c0 1.15-.94 2.084-2.1 2.084H4.202A2.092 2.092 0 0 1 2.1 20.833V4.167c0-1.15.941-2.084 2.102-2.084h25.215ZM4.203 0C1.882 0 0 1.865 0 4.167v16.666C0 23.135 1.882 25 4.203 25h25.215c2.321 0 4.203-1.865 4.203-4.167V4.167C33.62 1.865 31.739 0 29.418 0H4.203Z"></path>
                    <path
										d="M4.203 7.292c0-.576.47-1.042 1.05-1.042h4.203c.58 0 1.05.466 1.05 1.042v2.083c0 .575-.47 1.042-1.05 1.042H5.253c-.58 0-1.05-.467-1.05-1.042V7.292Zm0 6.25c0-.576.47-1.042 1.05-1.042H15.76c.58 0 1.05.466 1.05 1.042 0 .575-.47 1.041-1.05 1.041H5.253c-.58 0-1.05-.466-1.05-1.041Zm0 4.166c0-.575.47-1.041 1.05-1.041h2.102c.58 0 1.05.466 1.05 1.041 0 .576-.47 1.042-1.05 1.042H5.253c-.58 0-1.05-.466-1.05-1.042Zm6.303 0c0-.575.47-1.041 1.051-1.041h2.101c.58 0 1.051.466 1.051 1.041 0 .576-.47 1.042-1.05 1.042h-2.102c-.58 0-1.05-.466-1.05-1.042Zm6.304 0c0-.575.47-1.041 1.051-1.041h2.101c.58 0 1.05.466 1.05 1.041 0 .576-.47 1.042-1.05 1.042h-2.101c-.58 0-1.05-.466-1.05-1.042Zm6.304 0c0-.575.47-1.041 1.05-1.041h2.102c.58 0 1.05.466 1.05 1.041 0 .576-.47 1.042-1.05 1.042h-2.101c-.58 0-1.05-.466-1.05-1.042Z"></path>
                  </g>
                </svg>
							</span>
						</h2>
						<div id="collapseCC" class="accordion-collapse collapse show"
							data-bs-parent="#accordionPayment" style="">
							<div class="accordion-body">
								<div class="mb-3">
									<label class="form-label">Kart Numarası</label> <input
										type="password" class="form-control" placeholder="XXXX-XXXX-XXXX-XXXX">
								</div>
								<div class="row">
									<div class="col-lg-6">
										<div class="mb-3">
											<label class="form-label">Kart üstündeki isim soyisim</label> <input
												type="text" class="form-control" placeholder="">
										</div>
									</div>
									<div class="col-lg-3">
										<div class="mb-3">
											<label class="form-label">Son K. Tarihi</label> <input
												type="text" class="form-control" placeholder="MM/YY">
										</div>
									</div>
									<div class="col-lg-3">
										<div class="mb-3">
											<label class="form-label">CVV</label> <input
												type="password" class="form-control">
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="accordion-item mb-3 border">
						<h2
							class="h5 px-4 py-3 accordion-header d-flex justify-content-between align-items-center">
							<div class="form-check w-100 collapsed" data-bs-toggle="collapse"
								data-bs-target="#collapsePP" aria-expanded="false">
								<input class="form-check-input" type="radio" name="payment_method"
									id="payment2" value = "Kapıda Ödeme"> <label class="form-check-label pt-1"
									for="payment2"> Kapıda Ödeme </label>

							</div>
							<span> <svg xmlns="http://www.w3.org/2000/svg" width="44" height="30" fill="currentColor" class="bi bi-truck" viewBox="0 0 16 16">
  <path d="M0 3.5A1.5 1.5 0 0 1 1.5 2h9A1.5 1.5 0 0 1 12 3.5V5h1.02a1.5 1.5 0 0 1 1.17.563l1.481 1.85a1.5 1.5 0 0 1 .329.938V10.5a1.5 1.5 0 0 1-1.5 1.5H14a2 2 0 1 1-4 0H5a2 2 0 1 1-3.998-.085A1.5 1.5 0 0 1 0 10.5zm1.294 7.456A2 2 0 0 1 4.732 11h5.536a2 2 0 0 1 .732-.732V3.5a.5.5 0 0 0-.5-.5h-9a.5.5 0 0 0-.5.5v7a.5.5 0 0 0 .294.456M12 10a2 2 0 0 1 1.732 1h.768a.5.5 0 0 0 .5-.5V8.35a.5.5 0 0 0-.11-.312l-1.48-1.85A.5.5 0 0 0 13.02 6H12zm-9 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2m9 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2"/>
</svg>
							</span>
						</h2>
						<div id="collapsePP" class="accordion-collapse collapse"
							data-bs-parent="#accordionPayment" style="">
							<div class="accordion-body">
								<div class="px-2 col-lg-6 mb-3">
									<label class="form-label">Eposta Adresi</label> <input
										type="email" class="form-control">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="card position-sticky top-0">
					<div class="p-3 bg-light bg-opacity-10">
						<h6 class="card-title mb-3">Toplam Tutar</h6>
						<div class="d-flex justify-content-between mb-1 small">
							<span>Subtotal</span> <span>${ total }<i class="fa fa-try"></i></span>
						</div>
						<div class="d-flex justify-content-between mb-1 small">
							<span>Kargo Ücreti</span> <span>200.0<i class="fa fa-try"></i></span>
						</div>
						<div class="d-flex justify-content-between mb-1 small">
							<span>Kupon</span> <span class="text-danger">-200.0<i class="fa fa-try"></i></span>
						</div>
						<hr>
						<div class="d-flex justify-content-between mb-4 small">
							<span>Toplam Tutar</span> <strong class="text-dark">${ total }<i class="fa fa-try"></i></strong>
						</div>
						<div class="form-check mb-1 small">
							<input class="form-check-input" type="checkbox" value="" id="tnc">
							<label class="form-check-label" for="tnc">
								<a href="#">Kullanıcı Koşulları</a>'nı kullanıyorum
							</label>
						</div>
						<div class="form-check mb-3 small">
							<input class="form-check-input" type="checkbox" value=""
								id="subscribe"> <label class="form-check-label"
								for="subscribe"> Ürünlerimiz ve Hizmetlerimiz hakkında bilgi almak istiyorsanız işaretleyiniz. <a href="#">Gizlilik Politikası</a>
							</label>
						</div>
						<c:forEach var="cart" items="${cart_list}">
                			<input type="hidden" name="product_id[]" value="${cart.id}">
                			<input type="hidden" name="quantity[]" value="${cart.quantity}">
            			</c:forEach>
						<button type = "submit" class="btn btn-primary w-100 mt-2">Sipariş Ver</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>



	<%@include file="includes/footer.jsp"%>
</body>
</html>