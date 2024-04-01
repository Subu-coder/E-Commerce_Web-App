<%@page import="com.org.dto.Customer"%>
<%@page import="com.org.daoImplementation.CustomerDaoImpl"%>
<%@page import="com.org.dao.CustomerDao"%>
<%@page import="com.org.dto.Items"%>
<%@page import="com.org.daoImplementation.ItemsDaoImpl"%>
<%@page import="com.org.dao.ItemsDao"%>
<%@page import="java.util.List"%>
	
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Customer Home</title>
		
		<!-- Home Style Has been used as both are same -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/components/CustomerStyles/customer_cart.css" />
		<link rel="icon" href="https://cdn4.iconfinder.com/data/icons/shopping-and-commerce-outline-color/512/shopping_commerce_21-1024.png">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	</head>
	
	<body>

	<%
		
		String customerId = (String)(session.getAttribute("customerId"));
		if(customerId!=null){
			CustomerDao customerDao = new CustomerDaoImpl();
			Customer customer = customerDao.fetchCustomerById(Integer.parseInt(customerId));
		
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

	<%
	
	
		if (customer != null) {
	
			List<Items> items = customer.getItems();
			if(items.isEmpty()){
				
		%>
				<h1> No Items in the Cart </h1>
				<h2><a href="${pageContext.request.contextPath }/customer/customer_home.jsp">Add Items to Cart</a></h2>
		<% 
				} else {
					double sum=0;
					int i=0;
		%>
		
		<main>
        	<h1>Cart Items</h1>
        <br>

        <div class="product-container">

			<c:forEach var="i" items="<%=items%>">

            	<div class="product">

                	<div class="image">
                	</div>

                	<div class="details">
                	    <b>Name:</b> <span style= "text-transform: capitalize;"> ${i.getName()} </span><br>
                	    <b>Price:</b> ${i.getPrice()} Rs.<br>
                	    <b>Category:</b> ${i.getCategory()} <br>
                	    <b>Description:</b> <span style= "text-transform: capitalize;"> ${i.getDescription()}</span> <br>
                	    <b>Stock Left:</b> ${i.getStockLeft()}<br>

                  		  <div>
                  			  	<form action="${pageContext.request.contextPath}/remove_item" method="post">
                  			  		<input type="hidden" name="itemId" value="${i.getId()}">
	              			       	<button> Remove </button>
	                		    </form>
                    	  </div>
                	</div>

            	</div> 
            	
            	<%
            		sum+=Integer.parseInt(items.get(i).getPrice());
            		i++;
            	%>
			</c:forEach>
			
			<div class="total">
				<h1>Total Price: <%=sum%> Rs.</h1>
				<form action="${pageContext.request.contextPath}/buy_all" method="post">
					<input type="hidden" name="customerId" value=" <%= customerId %> ">
					<button id="buy-all">Buy All</button>
				</form>
			</div>
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