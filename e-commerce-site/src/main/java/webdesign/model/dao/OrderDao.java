package webdesign.model.dao;

import webdesign.connection.Databaseconnection;
import webdesign.model.Order;
import webdesign.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {
    private Connection con;
	private String query, query1;
	private PreparedStatement pst, pst1;
	private ResultSet rs;
    
    public OrderDao(Connection con) {
		this.con = con;
	}
	public boolean addOrderDetail(int order_id, int product_id, int quantity) {
        boolean status = false;
        PreparedStatement ps = null;

        try {
            query = "INSERT INTO order_details (order_id, product_id, quantity) VALUES (?, ?, ?)";
            ps = con.prepareStatement(query);
            ps.setInt(1, order_id);
            ps.setInt(2, product_id);
            ps.setInt(3, quantity);

            int result = ps.executeUpdate();
            if (result > 0) {
                status = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return status;
    }
	
	public List<Order> getMyOrders(int userId) {
	    List<Order> orders = new ArrayList<>();
	    PreparedStatement pst = null;
	    ResultSet rs = null;
	    
	    try {
	        String query = "SELECT * FROM orders WHERE u_id=?";
	        pst = this.con.prepareStatement(query);
	        pst.setInt(1, userId);
	        rs = pst.executeQuery();
	        
	        while (rs.next()) {
	            Order order = new Order();
	            order.setId(rs.getInt("o_id"));
	            order.setUserId(rs.getInt("u_id"));
	            order.setProductId(rs.getInt("p_id"));
	            order.setQuantity(rs.getInt("o_quantity"));
	            order.setOrderDate(rs.getString("o_date"));
	            order.setPaymentMethod(rs.getString("payment_method"));
	            order.setTotalPrice(rs.getString("total_price"));
	            
	            orders.add(order);
	        }
	        
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) {
	                rs.close();
	            }
	            if (pst != null) {
	                pst.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    return orders;
	}
	
	
	
	public List<Order> getAllOrders(){
		List<Order> orders = new ArrayList<Order>();
		PreparedStatement pst = null;
	    ResultSet rs = null;
		
		try {
			query = "SELECT * FROM orders";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while(rs.next()) {
				Order order = new Order();
	            order.setId(rs.getInt("o_id"));
	            order.setUserId(rs.getInt("u_id"));
	            order.setProductId(rs.getInt("p_id"));
	            order.setQuantity(rs.getInt("o_quantity"));
	            order.setOrderDate(rs.getString("o_date"));
	            order.setPaymentMethod(rs.getString("payment_method"));
	            order.setTotalPrice(rs.getString("total_price"));
	            
	            orders.add(order);
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
	        try {
	            if (rs != null) {
	                rs.close();
	            }
	            if (pst != null) {
	                pst.close();
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
		
		return orders;
		
	}
	
	public void deleteOrder(int id) {
		query1 = "DELETE FROM order_details WHERE ORDER_ID=?";
		query = "DELETE FROM orders WHERE O_ID=?";
        try {
            pst = this.con.prepareStatement(query);
            pst1 = this.con.prepareStatement(query1);
            pst.setInt(1, id);
            pst1.setInt(1, id);
            pst.executeUpdate();
            pst1.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	
	
    public int addOrder(Order order) {
        int order_id = 0;

        try {
            String sql = "INSERT INTO orders (p_id, u_id, o_quantity, o_date, payment_method, total_price) VALUES (?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pst.setInt(1, order.getProductId());
            pst.setInt(2, order.getUserId());
            pst.setInt(3, order.getQuantity());
            pst.setString(4, order.getOrderDate());
            pst.setString(5, order.getPaymentMethod());
            pst.setString(6, order.getTotalPrice());

            int result = pst.executeUpdate();

            if (result > 0) {
                rs = pst.getGeneratedKeys();
                if (rs.next()) {
                    order_id = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (pst != null) {
                    pst.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return order_id;
    }
}
