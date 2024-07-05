package webdesign.model;

import java.io.InputStream;

import com.mysql.cj.jdbc.Blob;

public class Product {
	private int id;
	private String name;
	private String category;
	private double price;
	private String description;
	private InputStream image;
	
	public Product() {
	}

	public Product(int id, String name, String category, double price, InputStream image) {
		super();
		this.id = id;
		this.name = name;
		this.category = category;
		this.price = price;
		this.description = description;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getDescription() {
		return description;
	}



	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", category=" + category + ", price=" + price + ", descrition =" + description + "]";
	}


	
	
	
	
	
	

}
