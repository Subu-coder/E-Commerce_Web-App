package com.org.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.org.dao.SellerDao;
import com.org.dto.Seller;

@Controller
public class SellerController {

	@Autowired
	SellerDao seller_dao;
	
	@PostMapping("/seller_register")
	public ModelAndView sellerRegister(@ModelAttribute Seller seller) {

		boolean sellerAvl = seller_dao.fetchSellerByEmail(seller.getEmail());
		
		
		if(!sellerAvl) {
			seller_dao.saveAndUpdateSeller(seller);
		}

		return new ModelAndView("seller/seller_login.jsp");

	}

	@RequestMapping("/seller_login")
	public ModelAndView sellerLogin(@RequestParam String email, @RequestParam String password, HttpSession session) {
		
		Seller seller = seller_dao.fetchSellerByEmailAndPassword(email, password);
		ModelAndView mav;
		
		if(seller == null) {
			mav = new ModelAndView("seller/seller_login.jsp");
			mav.addObject("isValidCredentials","Invalid Credentials");
			return  mav;
			
		}
			mav = new ModelAndView("seller/seller_home.jsp");
			session.setAttribute("sellerId", seller.getId()+"");
			return mav;
		

	}

	@RequestMapping("/seller_logout")
	public ModelAndView sellerLogout(HttpSession session,HttpServletRequest req) {
		session.invalidate();
		return new ModelAndView("redirect:/seller/seller_login.jsp");
	}
	
	@RequestMapping("/seller_to_buyer")
	public String sellerToBuyer(HttpServletRequest req,HttpSession session) {
		session.invalidate();
		return "customer/customer_login.jsp";
	}
	
	@RequestMapping("/seller_profile")
	public ModelAndView sellerProfile(HttpSession session) {
		
		int sellerId = Integer.parseInt((String)session.getAttribute("sellerId"));
	
		Seller seller = seller_dao.fetchSellerById(sellerId);
		
		ModelAndView mav = new ModelAndView("seller/seller_profile.jsp");
		mav.addObject(seller);
		return mav;
		
	}
	
	@RequestMapping("/seller_update")
	public String sellerProfile(@ModelAttribute Seller seller) {
		seller_dao.saveAndUpdateSeller(seller);
		return "seller/seller_home.jsp";
	}
	
	@RequestMapping("/remove_seller")
	public String removeSeller(@RequestParam int id,HttpSession session) {
		seller_dao.removeSeller(seller_dao.fetchSellerById(id));
		session.invalidate();
		return "seller/seller_login.jsp";
	}
	
}
