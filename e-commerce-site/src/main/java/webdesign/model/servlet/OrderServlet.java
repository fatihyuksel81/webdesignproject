package webdesign.model.servlet;

import webdesign.model.Cart;
import webdesign.model.User;
import webdesign.connection.Databaseconnection;
import webdesign.model.dao.ProductDao;
import webdesign.model.dao.OrderDao;
import webdesign.model.Order;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public OrderServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
    	request.setCharacterEncoding("UTF-8");
    	response.setCharacterEncoding("UTF-8");
        User auth = (User) session.getAttribute("auth");
        ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
        String payment_method = request.getParameter("payment_method");

        if (auth == null || cart_list == null || cart_list.isEmpty() || payment_method == null) {
            response.sendRedirect("cart.jsp");
            return;
        }

        Connection con = null;
        response.setContentType("text/html;charset=UTF-8");
        try {
            con = Databaseconnection.getConnection();
            ProductDao productDao = new ProductDao(con);
            OrderDao orderDao = new OrderDao(con);
        	double totalcart = productDao.totalPrice(cart_list);
        	String total_price = String.valueOf(totalcart);
        	

            con.setAutoCommit(false);

            Date date = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            String o_date = formatter.format(date);

            Order order = new Order();
            order.setProductId(auth.getId());
            order.setUserId(auth.getId());
            order.setQuantity(cart_list.size());
            order.setOrderDate(o_date);
            order.setPaymentMethod(payment_method);
            order.setTotalPrice(total_price);

            int orderId = orderDao.addOrder(order);

            for (Cart cart : cart_list) {
                int product_id = cart.getId();
                int quantity = cart.getQuantity();
                orderDao.addOrderDetail(orderId, product_id, quantity);
            }

            con.commit();

            session.removeAttribute("cart-list");

            response.sendRedirect("paymentsuccess.jsp");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            response.sendRedirect("cart.jsp?error=sql_error");
        } finally {
            try {
                if (con != null) {
                    con.setAutoCommit(true);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
