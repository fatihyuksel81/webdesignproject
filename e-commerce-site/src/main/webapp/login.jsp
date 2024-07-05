<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Hepsişurada Giriş</title>
<%@include file="includes/head.jsp"%>
</head>
<style>
<%@include file="style/font.css"%>
<%@include file="style/login.css"%>
</style>
<body style="bg-color: #6767e0">
	<div class="container full-height"">
		<div class="card w-50 mx-auto my-5">
			<h1 class="text-center">Merhaba!</h1>

			<div class="btn-group btn-group-toggle" data-toggle="buttons">
				<label class="btn btn-secondary active" id="loginBtn"> <input type="radio"
					name="options" id="option1" autocomplete="off" checked>
					Giriş Yap
				</label> <label class="btn btn-secondary" id="registerBtn"> <input type="radio"
					name="options" id="option2" autocomplete="off"> Kayıt Ol
				</label>
			</div>


			<div class="card-body mt-4">
			<% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
				<form action="userlogin" method="post">

					<div class="form-group">
						<label></label> <input type="email"
							class="form-control" name="eposta"
							placeholder="" required>
							<label>E-posta</label>
					</div>

					<div class="form-group">
						<input type="password"
							class="form-control" name="parola"
							placeholder="" required>
							<label>Şifre</label>
							<span class="forgot-password">Şifreni Mi Unuttun?</span>
						
					</div>

					
					<div class="text-center button-group">
						<button type="submit" class="btn btn-primary btn-lg">Giriş Yap</button>
					</div>
				</form>
			</div>

					<%@include file="includes/footer.jsp"%>
					<script>
						document.getElementById('registerBtn')
								.addEventListener('click', function() {
									window.location.href = 'register.jsp';
								});
					</script>
</body>
</html>