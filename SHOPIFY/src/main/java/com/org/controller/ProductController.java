package com.org.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.org.dao.ProductDao;
import com.org.dao.SellerDao;
import com.org.dto.Product;
import com.org.dto.Seller;

@Controller
public class ProductController {
	
	@Autowired
	ProductDao prod_dao;
	
	@Autowired
	SellerDao seller_dao;

	@RequestMapping("/add_products")
	public ModelAndView addProducts(@ModelAttribute Product product, HttpSession session) {
		
		product.setName(product.getName().toLowerCase().trim());
		product.setDescription(product.getDescription().toLowerCase().trim());
		
		//boolean isProductAvl = prod_dao.fetchProductByNameCategoryAndDescription(product.getName(),product.getCategory(), product.getDescription());
		
		//if(!isProductAvl) {
		
			int sellerId = Integer.parseInt((String) session.getAttribute("sellerId"));
		
			Seller seller = seller_dao.fetchSellerById(sellerId);
			List<Product> products = seller.getProducts();
		
			product.setSeller(seller);
			seller.setProducts(products);
			
			prod_dao.saveAndUpdateProduct(product);
		
		//	}
		
		ModelAndView mav = new ModelAndView("redirect:/seller/seller_home.jsp") ;
		return mav;
	}
	
	
	@RequestMapping("/update_product")
	public ModelAndView updateProduct(@RequestParam int id, HttpServletRequest req) {
		
		Product dbProduct = prod_dao.fetchProductById(id);
		ModelAndView mav = new ModelAndView("seller/add_product.jsp");
		mav.addObject(dbProduct);
		return mav;
		
	}

	
	@RequestMapping("/delete_product")
	public String deleteProduct(HttpServletRequest req) {
		
		prod_dao.deleteProductById(Integer.parseInt(req.getParameter("id")));
		
		return "seller/view_products.jsp";
	}
	
}
