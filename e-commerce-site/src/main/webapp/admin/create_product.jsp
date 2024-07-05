<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="tur">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ürün Ekleme</title>
<%@include file="../includes/head.jsp"%>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container">
		<div class="card w-50 mx-auto my-5">
			<div class="card-header text-center">Ürün Ekleme</div>
			<div class="card-body">
				<%
				if (request.getAttribute("error") != null) {
				%>
				<div class="alert alert-danger" role="alert">
					<%=request.getAttribute("error")%>
				</div>
				<%
				}
				%>
				<form action="create-product" method="post">
					<div class="form-group">
						<label for="name">Ürün İsmi</label> <input
							type="text" class="form-control" id="name" name = "name">
					</div>
					<div class="form-group">
						<label for="category">Kategori</label> <select
							class="form-control" id="category" name="category">
							<option>Yiyecek</option>
							<option>Kıyafet</option>
							<option>İçecek</option>
							<option>Teknoloji</option>
							<option>Kişisel Bakım</option>
						</select>
					</div>
					<div class="form-group">
						<label for="price">Ürün Fiyatı</label> <input
							type="text" class="form-control" id="price" name = "price">
					</div>
					<div class="form-group">
						<label for="description">Açıklama</label>
						<textarea class="form-control" id="description" name="description"
							rows="5"></textarea>
					</div>
					<div class="text-center">
                        <button type="submit" class="btn btn-primary">Ekle</button>
                    </div>
				</form>
			</div>
		</div>
	</div>
	<%@include file="../includes/footer.jsp"%>
</body>
</html>
