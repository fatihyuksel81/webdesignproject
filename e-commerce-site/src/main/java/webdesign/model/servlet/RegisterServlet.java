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
import webdesign.model.dao.UserdDao;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (name == null || email == null || password == null || name.isEmpty() || email.isEmpty() || password.isEmpty()) {
                out.println("Lütfen tüm alanları doldurun.");
                return;
            }

            UserdDao userDao = new UserdDao(Databaseconnection.getConnection());
            boolean success = userDao.addUser(name, email, password);

            if (success) {
                response.sendRedirect("login.jsp");
            } else {
            	String errorMessage = "Kayıt yapılırken hata oluştu lütfen bilgilerini kontrol ediniz!";
				request.setAttribute("error", errorMessage);
				request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } catch(SQLException e) {
        	e.printStackTrace();
        } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
    }
}
