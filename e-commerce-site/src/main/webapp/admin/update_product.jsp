<%@ page import="webdesign.model.Product" %>
<%@ page import="webdesign.model.dao.ProductDao" %>
<%@ page import="webdesign.connection.Databaseconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%

	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
    int productId = Integer.parseInt(request.getParameter("id"));
    ProductDao productDao = new ProductDao(Databaseconnection.getConnection());
    Product product = productDao.getProductById(productId);

    if (request.getParameter("submit") != null) {
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        Double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");

        product.setName(name);
        product.setCategory(category);
        product.setPrice(price);
        product.setDescription(description);

        if (productDao.updateProduct(product)) {
            response.sendRedirect("products.jsp");
        } else {
            out.print("<p>Güncelleme başarısız oldu.</p>");
        }
    }
%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ürün Güncelleme</title>
<%@include file="../includes/head.jsp"%>
</head>
<body>
    <div class="container">
        <div class="card w-50 mx-auto my-5">
            <div class="card-header text-center">Ürün Güncelleme</div>
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
                <form method="post" action="update_product.jsp?id=<%= productId %>">
                    <div class="form-group">
                        <label for="name">Ürün İsmi</label> 
                        <input type="text" class="form-control" id="name" name="name" value="<%= product.getName() %>">
                    </div>
                    <div class="form-group">
                        <label for="category">Kategori</label> 
                        <select class="form-control" id="category" name="category">
                            <option value="Yiyecek" <%= "Yiyecek".equals(product.getCategory()) ? "selected" : "" %>>Yiyecek</option>
                            <option value="Kıyafet" <%= "Kıyafet".equals(product.getCategory()) ? "selected" : "" %>>Kıyafet</option>
                            <option value="İçeçek" <%= "İçeçek".equals(product.getCategory()) ? "selected" : "" %>>İçeçek</option>
                            <option value="Teknoloji" <%= "Teknoloji".equals(product.getCategory()) ? "selected" : "" %>>Teknoloji</option>
                            <option value="Kişisel Bakım" <%= "Kişisel Bakım".equals(product.getCategory()) ? "selected" : "" %>>Kişisel Bakım</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="price">Ürün Fiyatı</label> 
                        <input type="text" class="form-control" id="price" name="price" value="<%= product.getPrice() %>">
                    </div>
                    <div class="form-group">
                        <label for="description">Açıklama</label>
                        <textarea class="form-control" id="description" name="description" rows="5"><%= product.getDescription() %></textarea>
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
