package com.org.dao;

import com.org.dto.Seller;

public interface SellerDao {
	
	public void saveAndUpdateSeller(Seller seller);

	public Seller fetchSellerByEmailAndPassword(String email, String password);

	public Seller fetchSellerById(int id);
	
	public boolean fetchSellerByEmail(String email);
	
	public void removeSeller(Seller seller);
}
