<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hepsişurada Kayıt</title>
    <%@include file="includes/head.jsp"%>
</head>
<style>
<%@include file="style/font.css"%>
<%@include file="style/login.css"%>
</style>
<body style="bg-color: #6767e0">
	<div class="container full-height"">
		<div class="card w-50 mx-auto my-5">
			<h1 class="text-center">Kayıt Ol!</h1>

			<div class="btn-group btn-group-toggle" data-toggle="buttons">
				<label class="btn btn-secondary active" id="loginBtn"> <input type="radio"
					name="options" id="option1" autocomplete="off">
					Giriş Yap
				</label> <label class="btn btn-secondary" id="registerBtn"> <input type="radio"
					name="options" id="option2" autocomplete="off" checked> Kayıt Ol
					</label>
			</div>


			<div class="card-body mt-4">
			<% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
				<form action="register" method="post">
				
					<div class="form-group">
						<label></label> <input type="text"
							class="form-control" id= "name" name="name"
							placeholder="" required>
							<label>Ad</label>
					</div>

					<div class="form-group">
						<input type="email"
							class="form-control" id="email" name="email"
							placeholder="" required>
							<label>E-posta</label>
					</div>

					<div class="form-group">
						<input type="password"
							class="form-control" id="password" name="password"
							placeholder="" required>
							<label>Şifre</label>
						
					</div>

					
					<div class="text-center button-group">
						<button type="submit" class="btn btn-primary btn-lg">Kayıt Ol</button>
					</div>
				</form>
			</div>
			</div>
			</div>

					<%@include file="includes/footer.jsp"%>
					<script>
						document.getElementById('loginBtn')
								.addEventListener('click', function() {
									window.location.href = 'login.jsp';
								});
					</script>
</body>
</html>
