package webdesign.model.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import webdesign.connection.Databaseconnection;
import webdesign.model.dao.ProductDao;

/**
 * Servlet implementation class CreateProductServlet
 */
@WebServlet("/admin/create-product")
public class CreateProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
	    response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            Double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");

            if (name == null || category == null || price == null || name.isEmpty() || category.isEmpty()) {
                out.println("Lütfen tüm alanları doldurun.");
                return;
            }

            ProductDao productDao = new ProductDao(Databaseconnection.getConnection());
            boolean success = productDao.addProduct(name, category, price, description);

            if (success) {
                response.sendRedirect("products.jsp");
            } else {
            	String errorMessage = "Ürün eklenemedi bilgileri kontrol ediniz!";
				request.setAttribute("error", errorMessage);
				request.getRequestDispatcher("add_product.jsp").forward(request, response);
            }
        } catch(SQLException e) {
        	e.printStackTrace();
        } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

   }
	
}
