package com.org.dao;

import com.org.dto.Customer;

public interface CustomerDao {
	
	public void saveAndUpdateCustomer(Customer customer);
	
	public Customer fetchCustomerByEmailAndPassword(String email, String password);
	
	public Customer fetchCustomerById(int id);

	public boolean fetchCustomerByEmail(String email);

	public void removeCustomer(Customer customer);
}
