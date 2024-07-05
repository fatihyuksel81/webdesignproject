package webdesign.model.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import webdesign.connection.Databaseconnection;
import webdesign.model.Product;
import webdesign.model.dao.ProductDao;

/**
 * Servlet implementation class SearchAdminProductServlet
 */
@WebServlet("/admin/search-admin-product")
public class SearchAdminProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchAdminProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
    	response.setCharacterEncoding("UTF-8");
        String searchTerm = request.getParameter("query");
        ProductDao productDao = null;
		try {
			productDao = new ProductDao(Databaseconnection.getConnection());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        List<Product> products = productDao.searchProductsByName(searchTerm);
        
        request.setAttribute("products", products);
        RequestDispatcher dispatcher = request.getRequestDispatcher("adminsearchproduct.jsp");
        dispatcher.forward(request, response);
	}

}
