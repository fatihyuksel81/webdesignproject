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
import webdesign.model.User;
import webdesign.model.dao.UserdDao;

/**
 * Servlet implementation class SearchUserServlet
 */
@WebServlet("/admin/search-user")
public class SearchUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchUserServlet() {
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
        UserdDao userDao = null;
		try {
			userDao = new UserdDao(Databaseconnection.getConnection());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        List<User> users = userDao.searchUsersByName(searchTerm);
        
        request.setAttribute("users", users);
        RequestDispatcher dispatcher = request.getRequestDispatcher("searchresultsusers.jsp");
        dispatcher.forward(request, response);
    }

}
