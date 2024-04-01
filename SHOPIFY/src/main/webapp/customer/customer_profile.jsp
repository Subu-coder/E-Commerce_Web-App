<%@page import="com.org.dto.Customer"%>
<%@page import="com.org.daoImplementation.CustomerDaoImpl"%>
<%@page import="com.org.dao.CustomerDao"%>
<%@page import="com.org.daoImplementation.SellerDaoImpl"%>
<%@page import="com.org.dto.Seller"%>
<%@page import="com.org.dao.SellerDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false" %>
    
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Seller Profile</title>
	
	<link type="text/css" rel='stylesheet' href="${pageContext.request.contextPath}/components/SellerStyles/seller_profile_style.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>	
<body>
	
		<%
		String cid = (String) session.getAttribute("customerId");
		
		if(cid != null){
			
			int id = Integer.parseInt(cid);
			CustomerDao sd = new CustomerDaoImpl();
	
			Customer customer = sd.fetchCustomerById(id);
		
				if (customer != null) {	
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
	
	
	<div class="form-container">
        <h1>Customer Profile</h1> <br><br>
        <form:form action="customer_update" method="post" modelAttribute="customer">
			
			<div class="label-input">
			
				<div class="labels">
					<label for="id">ID:</label> 
					<br>
					<label for="name">Customer Name:</label>
					<br>
					<label for="email">Customer E-mail:</label>
					<br>
					<label for="mobile">Customer Mobile No.:</label>
					<br>
					<label for="password">Password:</label>
					<br>
					<label for="address">Address:</label>
				</div>
			
				<div class="inputs">
    				<form:input type="text" path="id" readonly="true" id="id"/> 
    		
    				<br>
    				<form:input type="text" placeholder="Full Name" path="name" id="name"/> 

    				<br>
        		    <form:input type="email" placeholder="Enter Email" path="email" id="email"/>
            
            
    				<br>
         	 	  	<form:input type="tel" placeholder="Enter Mobile Number" maxlength="10" path="mobile" id="mobile"/>

    				<br>
        	 	   <form:input type="text" placeholder="Enter Your password" minlength="4" path="password" id="password"/>

    				<br>
         		   	<form:input type="text" placeholder="Enter Your Address" maxlength="15" path="address" id="address"/> <br>
				</div>
				
			</div>
      	  <form:button id="update">Update Account Details</form:button>
      	  <form:button id="delete" formaction="remove_customer">Delete Account</form:button>
            
        </form:form> <br>
    </div>
	
	<%
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