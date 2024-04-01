package com.org.dao;

import java.util.List;

import com.org.dto.Items;

public interface ItemsDao {
	
	public void addItems(Items item);
	
	public Items fetchItemById(int id);
	
	public List<Items> fetchAllItems();

	public void deleteItemById(int id);
	
}
