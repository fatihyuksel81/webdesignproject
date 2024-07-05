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
import webdesign.model.User;
import webdesign.model.dao.UserdDao;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/userlogin")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("login.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()){
			String email = request.getParameter("eposta");
			String password = request.getParameter("parola");
			
			try {
				UserdDao udao = new UserdDao(Databaseconnection.getConnection());
				User user = udao.userLogin(email, password);
				
				if(user != null) {
					request.getSession().setAttribute("auth", user);
					
					if(user.isSuperUser()) {
						response.sendRedirect("admin/index.jsp");
					}
					
					else {
					    response.sendRedirect("index.jsp");
					}
				}
				else {
					String errorMessage = "Geçersiz e-posta veya şifre!";
					request.setAttribute("error", errorMessage);
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}
				
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}

}
