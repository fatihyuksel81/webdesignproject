<%@ page import="webdesign.model.User" %>
<%@ page import="webdesign.model.dao.UserdDao" %>
<%@ page import="webdesign.connection.Databaseconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%



	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
    int userId = Integer.parseInt(request.getParameter("id"));
    UserdDao userDao = new UserdDao(Databaseconnection.getConnection());
    User user = userDao.getUserById(userId);

    if (request.getParameter("submit") != null) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);

        if (userDao.updateUser(user)) {
        	response.sendRedirect("users.jsp");
        } else {
            out.print("<p>Güncelleme başarısız oldu.</p>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hepsişurada Kayıt</title>
    <%@include file="../includes/head.jsp"%>
</head>
<body>
    <div class="container">
        <div class="card w-50 mx-auto my-5">
            <div class="card-header text-center">Kullanıcı Güncelleme</div>
            <div class="card-body">
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
                <form method="post" action="update_user.jsp?id=<%= userId %>">
                    <div class="form-group">
                        <label for="name">Adınız</label>
                        <input type="text" class="form-control" id="name" name="name" value="<%= user.getName() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="email">E-posta Adresi</label>
                        <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail()  %>" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Şifre</label>
                        <input type="password" class="form-control" id="password" name="password" value="<%= user.getPassword() %>" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary" name="submit">Güncelle</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%@include file="../includes/footer.jsp"%>

</body>
</html>
