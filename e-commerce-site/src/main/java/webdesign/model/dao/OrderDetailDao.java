package webdesign.model.dao;

import webdesign.connection.Databaseconnection;
import webdesign.model.OrderDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDao {
    private Connection connection;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
    
    public OrderDetailDao(Connection connection) {
		this.connection = connection;
	}

    public OrderDetailDao() throws ClassNotFoundException, SQLException {
        connection = Databaseconnection.getConnection();
    }

    public void addOrderDetail(OrderDetail orderDetail) {
        String query = "INSERT INTO order_details (order_id, product_id, quantity) VALUES (?, ?, ?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, orderDetail.getOrderId());
            preparedStatement.setInt(2, orderDetail.getProductId());
            preparedStatement.setInt(3, orderDetail.getQuantity());
            preparedStatement.executeUpdate();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
    
	
	public List<OrderDetail> getOrderDetailById(int orderId){
		List<OrderDetail> orderdetail = new ArrayList<OrderDetail>();
		
		try {
			query = "SELECT * FROM order_details WHERE order_id = ?";
			pst = this.connection.prepareStatement(query);
			pst.setInt(1, orderId);
			rs = pst.executeQuery();
			while(rs.next()) {
				OrderDetail row = new OrderDetail();
				row.setProductId(rs.getInt("product_id"));
				row.setQuantity(rs.getInt("quantity"));
				
				orderdetail.add(row);
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
		
		return orderdetail;
		
	}
}
