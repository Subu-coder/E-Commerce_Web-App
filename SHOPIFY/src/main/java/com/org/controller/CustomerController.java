package com.org.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.org.dao.CustomerDao;
import com.org.dto.Customer;
import com.org.dto.Seller;

@Controller
public class CustomerController {

	@Autowired
	CustomerDao cd;

	@RequestMapping("/customer_register")
	public ModelAndView customerRegister(@RequestParam String firstname, @RequestParam String lastname,
			@RequestParam String email, @RequestParam long mobile, @RequestParam String password, @RequestParam String address) {
	
		boolean customerAvl = cd.fetchCustomerByEmail(email);
		
		ModelAndView mav;
		
		if(!customerAvl) {
			Customer customer = new Customer();
			customer.setName(firstname+" "+lastname);
			customer.setEmail(email);
			customer.setMobile(mobile);
			customer.setPassword(password);
			customer.setAddress(address);
			
			cd.saveAndUpdateCustomer(customer);			

		}
		
			mav = new ModelAndView("customer/customer_login.jsp");
			return mav;
	}

	@PostMapping("/customer_login")
	public ModelAndView customerLogin(@RequestParam String email, @RequestParam String password, HttpSession session) {
		
		Customer customer = cd.fetchCustomerByEmailAndPassword(email, password);
		
		ModelAndView mav;
		if(customer != null) {
			session.setAttribute("customerId", customer.getId()+"");
			mav = new ModelAndView("redirect:customer/customer_home.jsp");
			return mav;
		}
		else {
			mav = new ModelAndView("customer/customer_login.jsp");
			mav.addObject("isValidCredentials", "Invalid Credentials");
			return mav;
		}
		
	}
	
	@RequestMapping("/customer_logout")
	public String customerLogout(HttpSession session) {
		session.invalidate();
		
		return "customer/customer_login.jsp";
		
	}
	
	@RequestMapping("/buyer_to_seller")
	public String buyerToSeller(HttpSession session) {
		session.invalidate();
		return "seller/seller_login.jsp";
	}
	
	@RequestMapping("/customer_profile")
	public ModelAndView customerProfile(HttpSession session) {
		
		String cid = (String)session.getAttribute("customerId");
		int customerId=0;
		
		if(cid!=null) {
			customerId = Integer.parseInt(cid);
		}
		Customer customer = cd.fetchCustomerById(customerId);
		
		
		ModelAndView mav = new ModelAndView("customer/customer_profile.jsp");
		mav.addObject(customer);
		return mav;
	}
	
	@RequestMapping("/remove_customer")
	public String removeCustomer(@RequestParam int id) {
		
		Customer customer = cd.fetchCustomerById(id);
		cd.removeCustomer(customer);
		
		return "customer/customer_login.jsp";
		
	}
	
	@RequestMapping("/customer_update")
	public String sellerProfile(@ModelAttribute Customer customer) {
		cd.saveAndUpdateCustomer(customer);
		return "customer/customer_home.jsp";
	}
	
}
