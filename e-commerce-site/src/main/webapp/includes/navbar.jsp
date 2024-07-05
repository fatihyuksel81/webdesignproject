<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="webdesign.model.*"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import = "webdesign.model.dao.ProductDao" %>
<%@ page import="webdesign.connection.Databaseconnection"%>

<%
List<String> category = new ArrayList<String>();
category.add("Yiyecek");
category.add("İçecek");
category.add("Kıyafet");
category.add("Teknoloji");
category.add("Kişisel Bakım");
%>

<style>
<%@include file="../style/navfont.css"%>
.navbar-custom .search-bar {
    border-radius: 50px;
    width:500px;
    overflow: hidden;
    align-items: center;
}

.navbar-custom .search-bar .form-control {
    border: none;
    box-shadow: none;
    text-align: center;
}

.navbar-custom .search-bar .form-control:focus {
    box-shadow: none;
}

.navbar-custom .search-bar .btn {
    width:120px;
	background-color:orange;
	border-color:rgb(252, 164, 0);
}
</style>


<nav class="navbar navbar-expand-lg navbar-dark navbar-custom" style="background-color: #6767e0; height: 70px">
    <a class="navbar-brand" href="index.jsp">Hepsişurada</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">Anasayfa <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="cart.jsp">Sepet <i class="fa fa-shopping-cart"></i><span class="badge badge-danger">${ cart_list.size()}</span></a>
            </li>
			<li class="nav-item">
				<% if (request.getSession().getAttribute("auth") != null) { %> <a
				class="nav-link" href="orders.jsp">Siparislerim</a> <% } %>
			</li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> Kategoriler </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<%
					for (String i : category) {
					%>
					<a class="dropdown-item" href="category.jsp?category=<%=i%>"><%=i%></a>
					<%
					}
					%>
				</div></li>
			<li class="nav-item">
                <%
                if (request.getSession().getAttribute("auth") == null) {
                %>
                <a class="nav-link" href="login.jsp">Giris Yap</a>
                <% } else { %>
                <a class="nav-link" href="LogoutServlet">Cikis Yap</a>
                <% } %>
            </li>
        </ul>

        <form action="search-product" method="get" class="form-inline mr-3">
            <div class="input-group search-bar">
                <input type="text" name="query" class="form-control" placeholder="Ürün Ara" />
                <div class="input-group-append">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
            </div>
        </form>
    </div>
</nav>
