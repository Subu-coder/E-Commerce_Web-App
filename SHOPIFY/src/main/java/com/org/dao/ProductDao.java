package com.org.dao;

import java.util.List;

import com.org.dto.Product;

public interface ProductDao {
		
	public void saveAndUpdateProduct(Product product);
	
	public Product fetchProductById(int id);
	
	public boolean fetchProductByNameCategoryAndDescription(String name,String category , String desc);
	
	public List<Product> fetchAllProduct();
	
	public void deleteProductById(int id);
	
}
