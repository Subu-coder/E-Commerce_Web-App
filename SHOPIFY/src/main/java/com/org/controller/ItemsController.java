package com.org.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.org.dao.CustomerDao;
import com.org.dao.ItemsDao;
import com.org.dao.ProductDao;
import com.org.dto.Customer;
import com.org.dto.Items;
import com.org.dto.Product;

@Controller
public class ItemsController {
	@Autowired
	ProductDao productDao;
	
	@Autowired
	ItemsDao itemsDao;
	
	@Autowired
	CustomerDao customerDao;
	
	@PostMapping("/add_item")
	public ModelAndView addItemToCart(@RequestParam int productId, HttpSession session) {
		
		int customerId = Integer.parseInt((String)session.getAttribute("customerId"));
		
		Customer customer = customerDao.fetchCustomerById(customerId);
		
		Product prod = productDao.fetchProductById(productId);
		int stockLeft = Integer.parseInt(prod.getStockLeft()) - 1;
		int stockSold = Integer.parseInt(prod.getStockSold()) + 1;
		prod.setStockLeft(stockLeft+"");
		prod.setStockSold(stockSold+"");
		
		Items item = new Items();
		
		item.setName(prod.getName());
		item.setCategory(prod.getCategory());
		item.setDescription(prod.getDescription());
		item.setPrice(prod.getPrice());
		item.setStockLeft(prod.getStockLeft());
		item.setProductId(productId+"");
		
		List<Items> customerItems = customer.getItems();
		if(customerItems != null)
			customerItems.add(item);

		item.setCustomer(customer);
		customer.setItems(customerItems);
		
		itemsDao.addItems(item);
		productDao.saveAndUpdateProduct(prod);
		customerDao.saveAndUpdateCustomer(customer);
		
		return new ModelAndView("redirect:/customer/customer_home.jsp");
	}
	
	@PostMapping("/remove_item")
	public ModelAndView removeItem(@RequestParam int itemId) {
		
		Items item = itemsDao.fetchItemById(itemId);
		String productId = (String)item.getProductId();
		
		Product prod = productDao.fetchProductById(Integer.parseInt(productId));
		int stockLeft = Integer.parseInt(prod.getStockLeft()) + 1;
		int stockSold = Integer.parseInt(prod.getStockSold()) - 1;
		prod.setStockLeft(stockLeft+"");
		prod.setStockSold(stockSold+"");
		
		productDao.saveAndUpdateProduct(prod);
		itemsDao.deleteItemById(itemId);
		
		return new ModelAndView("redirect:/customer/customer_cart.jsp");
		
	}
	
	
	@RequestMapping("/buy_all")
	public String buyAllItems(@RequestParam int customerId) {
		
		Customer customer= customerDao.fetchCustomerById(customerId);
		List<Items> items = customer.getItems();
		
		for (Items item : items) {
			itemsDao.deleteItemById(item.getId());
		}
		
		items.clear();
		customer.setItems(items);
		customerDao.saveAndUpdateCustomer(customer);
		
		return "customer/customer_cart.jsp";
	}
	
}
