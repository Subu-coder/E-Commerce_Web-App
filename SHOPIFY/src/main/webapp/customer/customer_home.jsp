<%@page import="com.org.dto.Customer"%>
<%@page import="com.org.dao.CustomerDao"%>
<%@page import="com.org.daoImplementation.CustomerDaoImpl"%>
<%@page import="com.org.dto.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.org.daoImplementation.ProductDaoImpl"%>
<%@page import="com.org.dao.ProductDao"%>
	
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
	<head>
			<meta charset="ISO-8859-1">
			<title>Customer Home</title>
			<link rel="icon" href="https://cdn4.iconfinder.com/data/icons/shopping-and-commerce-outline-color/512/shopping_commerce_21-1024.png">
			<link rel="stylesheet" href="${pageContext.request.contextPath}/components/CustomerStyles/customer_home.css" />
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	</head>
	
	<body>

	<%
	
	String customerId = (String)(session.getAttribute("customerId"));
	if (customerId != null) {
	
		CustomerDao customerDao = new CustomerDaoImpl();
		Customer customer = customerDao.fetchCustomerById(Integer.parseInt(customerId));
	
		if (customer != null) {
			ProductDao pd = new ProductDaoImpl();
			List<Product> products = pd.fetchAllProduct();
			if(products.isEmpty()){
				
		%>
				<h1> No Items are Available! VISIT LATER </h1> <br>
		<% 
				} else {
		%>
		
	<header>

        <nav class="navbar">

            <h1>Customer Account</h1>

            <ul>
                <li><a href="${pageContext.request.contextPath}/customer/customer_home.jsp"><i class="fa-solid fa-user-tie"></i> Home</a></li>
                <li><a href="${pageContext.request.contextPath}/buyer_to_seller"><i class="fa-brands fa-sellcast"></i> Become a Seller</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/customer_cart.jsp"><i class="fa-brands fa-opencart"></i> Cart</a></li>
                <li><a href="${pageContext.request.contextPath}/customer_profile"><i class="fa-regular fa-user"></i> <%=customer.getName() %></a></li>
                <li><a href="${pageContext.request.contextPath}/customer_logout"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a></li>
            </ul>

        </nav>

    </header>
		<main>
        <h1>Buy Products</h1>
        <br>

        <div class="product-container">

			<c:forEach var="p" items="<%=products%>">

            	<div class="product">

                	<div class="image">
                	</div>

                	<div class="details">
                	    <b>Name:</b> <span style= "text-transform: capitalize;"> ${p.getName()} </span><br>
                	    <b>Price:</b> ${p.getPrice()} Rs.<br>
                	    <b>Category:</b> ${p.getCategory()} <br>
                	    <b>Description:</b> <span style= "text-transform: capitalize;"> ${p.getDescription()}</span> <br>
                	    <b>Stock Left:</b> ${p.getStockLeft()}<br>

                  		  <div>
                  			  	<form action="${pageContext.request.contextPath}/add_item" method="post">
                  			  		<input type="hidden" name="productId" value="${p.getId()}">
	              			       	<button> Add To Cart </button>
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
			else{
					response.sendRedirect(request.getContextPath()+"/customer/customer_login.jsp");
			}
		}
		else{
				response.sendRedirect(request.getContextPath()+"/customer/customer_login.jsp");
		}
	%>

	</body>
</html>