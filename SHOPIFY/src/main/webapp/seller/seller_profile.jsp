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
		%>
	
	<div class="form-container">
        <h1>Seller Profile</h1> <br><br>
        <form:form action="seller_update" method="post" modelAttribute="seller">
			
			<div class="label-input">
			
				<div class="labels">
					<label for="id">ID:</label> 
					<br>
					<label for="name">Seller Name:</label>
					<br>
					<label for="email">Seller E-mail:</label>
					<br>
					<label for="mobile">Seller Mobile No.:</label>
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
      	  <form:button id="delete" formaction="remove_seller">Delete Account</form:button>
            
        </form:form> <br>
    </div>
	
	<%
			}
				else{
					response.sendRedirect(request.getContextPath()+"/seller/seller_login.jsp");
				}
			}
			else{
				response.sendRedirect(request.getContextPath()+"/seller/seller_login.jsp");
			}
	%>
	
</body>
</html>