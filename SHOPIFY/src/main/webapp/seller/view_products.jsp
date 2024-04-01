<%@page import="com.org.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.org.daoImplementation.SellerDaoImpl"%>
<%@page import="com.org.dto.Seller"%>
<%@page import="com.org.dao.SellerDao"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>View Products</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/components/SellerStyles/view_style.css" />
	</head>
<body>
	
	<header>

        <nav class="navbar">

			<h1>Seller Account</h1>

            <ul>
                <li><a href="${pageContext.request.contextPath}/seller/seller_home.jsp">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/seller_to_buyer">Become a Buyer</a></li>
                <li><a href="${pageContext.request.contextPath}/emptyProduct">Add Products</a></li>
                <li><a href="${pageContext.request.contextPath}/seller_logout">Logout</a></li>
            </ul>

        </nav>

    </header>

	<% 
		String sid = (String) session.getAttribute("sellerId");
		
		if(sid != null){
			
			int id = Integer.parseInt(sid);
		
			SellerDao sd = new SellerDaoImpl();
	
			Seller seller = sd.fetchSellerById(id);
			
			if (seller != null) {	
	
				List<Product> products = seller.getProducts();
				if(products.isEmpty()){
			
				
	%>
			<h1> Product List is Empty </h1> <br>
			<h2><a href="${pageContext.request.contextPath}/emptyProduct">Click Here</a> To add Products</h2>		
	<% 
			} else {
	%>
	

    <main>
        <h1>Product Details</h1>
        <br>

        <div class="product-container">

			<c:forEach var="p" items="<%=products%>">

            	<div class="product">
                	<span id="id">ID: ${p.getId()}</span>

                	<div class="image">
                	</div>

                	<div class="details">
                	    <b>Name:</b> <span style= "text-transform: capitalize;"> ${p.getName()} </span><br>
                	    <b>Price:</b> ${p.getPrice()} Rs.<br>
                	    <b>Category:</b> ${p.getCategory()} <br>
                	    <b>Description:</b> <span style= "text-transform: capitalize;"> ${p.getDescription()}</span> <br>
                	    <b>Stock Left:</b> ${p.getStockLeft()} <br>
                	    <b>Stock Sold:</b> ${p.getStockSold()}<br>

                  		  <div>
                  			  	<form method="post">
                  			  		<input type="hidden" name="id" value="${p.getId()}">
	              			       	<button id="delete" formaction="${pageContext.request.contextPath}/delete_product"> Delete </button>
	                		     	<button id="update" formaction="${pageContext.request.contextPath}/update_product"> Update </button>
	                		    </form>
                    	  </div>
                	</div>

            	</div> 
			</c:forEach>
			
           </div>

    </main>
	
	
	<% 
				} 
			}
			else {
				response.sendRedirect(request.getContextPath()+"/seller/seller_login.jsp");
			}
		} else{
				response.sendRedirect(request.getContextPath()+"/seller/seller_login.jsp");
		}
		
	%>
	
	
</body>
</html>