package webdesign.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import webdesign.model.*;

public class ProductDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public ProductDao(Connection con) {
		this.con = con;
	}
	
	public List<Product> getAllProducts(){
		List<Product> products = new ArrayList<Product>();
		PreparedStatement pst = null;
	    ResultSet rs = null;
		
		try {
			query = "SELECT * FROM products";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while(rs.next()) {
				Product row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getDouble("price"));
				
				products.add(row);
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
		
		return products;
		
	}
	
	public List<Product> getProductByCategory(String category) {
	    List<Product> products = new ArrayList<>();
	    PreparedStatement pst = null;
	    ResultSet rs = null;
	    
	    try {
	        String query = "SELECT * FROM products WHERE category=?";
	        pst = this.con.prepareStatement(query);
	        pst.setString(1, category);
	        rs = pst.executeQuery();
	        
	        while (rs.next()) {
	            Product row = new Product();
	            row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getDouble("price"));
	            
	            products.add(row);
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
	    
	    return products;
	}
	
	public boolean updateProduct(Product product) {
	    boolean rowUpdated = false;
	    try {
	        query = "UPDATE products SET name = ?, category = ?, price = ?, description = ? WHERE id = ?";
	        pst = this.con.prepareStatement(query);
	        pst.setString(1, product.getName());
	        pst.setString(2, product.getCategory());
	        pst.setDouble(3, product.getPrice());
	        pst.setString(4, product.getDescription());
	        pst.setInt(5, product.getId());
	        
	        rowUpdated = pst.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return rowUpdated;
	}
	
	public Product getProductById(int productId) {
	    Product product = null;
	    String query = "SELECT * FROM products WHERE id = ?";
	    try {
	        PreparedStatement pst = this.con.prepareStatement(query);
	        pst.setInt(1, productId);
	        ResultSet rs = pst.executeQuery();
	        if (rs.next()) {
	            product = new Product();
	            product.setId(rs.getInt("id"));
	            product.setName(rs.getString("name"));
	            product.setCategory(rs.getString("category"));
	            product.setPrice(rs.getDouble("price"));
	            product.setDescription(rs.getString("description"));
	            
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return product;
	}
	
	public List<Product> searchProductsByName(String searchTerm) {
	    List<Product> products = new ArrayList<>();
	    try {
	        query = "SELECT * FROM products WHERE name LIKE ?";
	        pst = this.con.prepareStatement(query);
	        pst.setString(1, "%" + searchTerm + "%");
	        rs = pst.executeQuery();
	        while (rs.next()) {
	            Product product = new Product();
	            product.setId(rs.getInt("id"));
	            product.setName(rs.getString("name"));
	            product.setCategory(rs.getString("category"));
	            product.setPrice(rs.getDouble("price"));
	            product.setDescription(rs.getString("description"));
	            products.add(product);
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
	    return products;
	}
	
	public void deleteProduct(int id) {
        query = "DELETE FROM products WHERE ID=?";
        try {
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	
	public boolean addProduct(String name, String category, Double price, String description) {
	    try {
	        query = "INSERT INTO products (name, category, price, description) VALUES (?, ?, ?, ?)";
	        pst = this.con.prepareStatement(query);
	        pst.setString(1, name);
	        pst.setString(2, category);
	        pst.setDouble(3, price);
	        pst.setString(4, description);
	        
	        int rowsAffected = pst.executeUpdate();
	        
	        return rowsAffected > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println(e.getMessage());
	        return false;
	    }
	}
	
	public List<Cart> getCartProducts(ArrayList<Cart> cartList){
		List<Cart> products = new ArrayList<Cart>();
				
		try {
			if(cartList.size()>0) {
				for(Cart item:cartList) {
					query = "SELECT * FROM PRODUCTS WHERE ID=?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1,item.getId());
					rs = pst.executeQuery();
					while(rs.next()) {
						Cart cart = new Cart();
						cart.setId(rs.getInt("id"));
						cart.setName(rs.getString("name"));
						cart.setCategory(rs.getString("category"));
						cart.setPrice(rs.getDouble("price")*item.getQuantity());
						cart.setQuantity(item.getQuantity());
						products.add(cart);
					}
				}
			}
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
//			e.printStackTrace();
			
		}
		return products;
	}
	
	public double totalPrice(ArrayList<Cart> cartList) {
		double sum = 0;
		try {
			if(cartList.size()>0 ) {
				for(Cart product:cartList) {
					query = "SELECT PRICE FROM PRODUCTS WHERE ID=? ";
					pst = this.con.prepareStatement(query);
					pst.setInt(1,  product.getId());
					rs = pst.executeQuery();
					
					while(rs.next()) {
						sum = sum + rs.getDouble("price")*product.getQuantity();
					}
				}
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return sum;
	}
	
	
}
