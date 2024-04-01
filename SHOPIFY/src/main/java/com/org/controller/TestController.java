package com.org.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.org.dto.Customer;
import com.org.dto.Product;
import com.org.dto.Seller;

@Controller
public class TestController {
	
	@GetMapping("/emptyCustomer")
	public ModelAndView emptyCustomer() {
		Customer customer = new Customer();
		
		ModelAndView mav = new ModelAndView("customer/customer_register.jsp");
		
		mav.addObject("customer",customer);

		return mav;
	}
	
	
	@GetMapping("/emptySeller")
	public ModelAndView emptySeller() {
		Seller seller = new Seller();
		
		ModelAndView mav = new ModelAndView("seller/seller_register.jsp");
		
		mav.addObject("seller",seller);
		
		return mav;
	}
	
	@GetMapping("/emptyProduct")
	public ModelAndView emptyProduct() {
		Product product = new Product();
		
		ModelAndView mav = new ModelAndView("seller/add_product.jsp");
		
		mav.addObject("product", product);
		
		return mav;
	}
	
	
	
}
