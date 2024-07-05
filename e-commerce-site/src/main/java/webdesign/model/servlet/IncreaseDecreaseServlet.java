package webdesign.model.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import webdesign.model.Cart;

/**
 * Servlet implementation class IncreaseDecreaseServlet
 */
@WebServlet("/increase-decrease")
public class IncreaseDecreaseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		response.setContentType("text/html;charset=UTF-8");
		try(PrintWriter out = response.getWriter()) {
			String action = request.getParameter(("action"));
			int id = Integer.parseInt(request.getParameter("id"));
			
			ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart-list");
			
			if(action != null && id>=1) {
				if(action.equals("inc")) {
					for(Cart c:cart_list) {
						if(c.getId() == id) {
							int quantity = c.getQuantity();
							quantity++;
							c.setQuantity(quantity);
							response.sendRedirect("cart.jsp");
						}
					}
				}
				if(action.equals("dec")) {
					for(Cart c:cart_list) {
						if(c.getId() == id) {
							int quantity = c.getQuantity();
								if(quantity>1) {
									quantity--;
									c.setQuantity(quantity);
									response.sendRedirect("cart.jsp");
								}
								else  {
					            	String errorMessage = "Ürün miktarını daha fazla azaltamassınız. Lütfen ürünü kaldırın!";
									request.setAttribute("error", errorMessage);
									request.getRequestDispatcher("cart.jsp").forward(request, response);
								}
						}
					}
				}
			}
			
		}
		
	}

}
