package webdesign.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import webdesign.model.Product;
import webdesign.model.User;

public class UserdDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;
	
	public UserdDao(Connection con) {
		this.con = con;
	}
	
	public boolean addUser(String name, String email, String password) {
	    try {
	        query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
	        pst = this.con.prepareStatement(query);
	        pst.setString(1, name);
	        pst.setString(2, email);
	        pst.setString(3, password);
	        

	        int rowsAffected = pst.executeUpdate();
	        
	        return rowsAffected > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println(e.getMessage());
	        return false;
	    }
	}
	
	public boolean updateUser(User user) {
	    boolean rowUpdated = false;
	    try {
	        query = "UPDATE users SET name = ?, email = ?, password = ?, is_super_user = ? WHERE id = ?";
	        pst = this.con.prepareStatement(query);
	        pst.setString(1, user.getName());
	        pst.setString(2, user.getEmail());
	        pst.setString(3, user.getPassword());
	        pst.setBoolean(4, user.isSuperUser());
	        pst.setInt(5, user.getId());
	        
	        rowUpdated = pst.executeUpdate() > 0;
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return rowUpdated;
	}
	
	
	public List<User> searchUsersByName(String searchTerm) {
	    List<User> users = new ArrayList<>();
	    try {
	        query = "SELECT * FROM users WHERE name LIKE ?";
	        pst = this.con.prepareStatement(query);
	        pst.setString(1, "%" + searchTerm + "%");
	        rs = pst.executeQuery();
	        while (rs.next()) {
	            User user = new User();
	            user.setId(rs.getInt("id"));
	            user.setName(rs.getString("name"));
	            user.setEmail(rs.getString("email"));
	            user.setPassword(rs.getString("password"));
	            users.add(user);
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
	    return users;
	}

	
	
	public void deleteUser(int id) {
        String query = "DELETE FROM users WHERE id=?";
        try {
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	
	
	
	public User getUserById(int userId) {
	    User user = null;
	    String query = "SELECT * FROM users WHERE id = ?";
	    try {
	        PreparedStatement pst = this.con.prepareStatement(query);
	        pst.setInt(1, userId);
	        ResultSet rs = pst.executeQuery();
	        if (rs.next()) {
	            user = new User();
	            user.setId(rs.getInt("id"));
	            user.setName(rs.getString("name"));
	            user.setEmail(rs.getString("email"));
	            user.setPassword(rs.getString("password"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return user;
	}


	
	
	public User userLogin(String email, String password) {
		User user = null;
		try {
			query = "select * from users where email=? and password=?";
			pst = this.con.prepareStatement(query);
			pst.setString(1,  email);
			pst.setString(2, password);
			rs = pst.executeQuery();
			
			if(rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setSuperUser(rs.getBoolean("is_super_user"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		return user;
	}
	
	public List<User> getAllUser() {
		List<User> users = new ArrayList<>();
		try {
			query = "select * from users";
			pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setSuperUser(rs.getBoolean("is_super_user"));

                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
	}
}
	
	
	


