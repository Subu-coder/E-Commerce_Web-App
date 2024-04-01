<%@page import="com.org.dto.Seller"%>
<%@page import="com.org.daoImplementation.SellerDaoImpl"%>
<%@page import="com.org.dao.SellerDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    
     <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Add Product</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/components/SellerStyles/addProd_style.css">
	</head>
<body>
	<%
		
	String sid = (String) session.getAttribute("sellerId");
	
	if(sid != null){
		
		int id = Integer.parseInt(sid);
		SellerDao sd = new SellerDaoImpl();

		Seller seller = sd.fetchSellerById(id);
	
		if (seller != null) {	
			
	%>
		
		<header>

        <nav class="navbar">

            <h1>Seller Account</h1>

            <ul>
                <li><a href="${pageContext.request.contextPath}/seller/seller_home.jsp">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/seller_to_buyer">Become a Buyer</a></li>
                <li><a href="${pageContext.request.contextPath}/seller/view_products.jsp">View Products</a></li>
                <li><a href="${pageContext.request.contextPath}/seller_logout">Logout</a></li>
            </ul>

        </nav>

    </header>
		
		<c:if test="${isProductAvl != null}">
			<h2 style="color:crimson;">${isProductAvl}</h2>
		</c:if>
			<%request.removeAttribute("isProductAvl"); %>
		
	    <div class="add">
        <h1>Add Product Details</h1>
        <br><br>
        
        <form:form action="add_products" method="post" modelAttribute="product">
        	
        	<form:input type="hidden" path="id" value="${product.getId()}"/>
        	
            <form:input type="text" path="name" minlength="3" maxlength="20" placeholder="Name of Product" required="required"/> <br>
            <br>
            <form:input type="number" min="5" path="price" id="" placeholder="Product Price" required="required"/> <br> <br>

            <form:label path="category">Select Category: </form:label>
            <form:select path="category" id="category" required="required">
                <form:option disabled="disabled" selected="selected" value=""> -- select a value -- </form:option>
                <form:option value="electronic">Electronics</form:option>
                <form:option value="Food And Drinks">Food and Drinks</form:option>
                <form:option value="kitchen">Kitchen</form:option>
                <form:option value="grocery">Grocery</form:option>
                <form:option value="beauty">Beauty</form:option>
                <form:option value="clothes">Fashion</form:option>
                <form:option value="movie">Movie</form:option>
            </form:select> <br> <br>

            <form:input type="text" path="description" id="" placeholder="description" required="required"/> <br> <br>

            <form:input type="number" min="0" path="stockLeft" id="" placeholder="Stock Left" required="required"/> <br> <br>

            <form:input type="number" min="0" path="stockSold" id="" placeholder="Stock Sold" required="required"/> <br> <br>

            <form:button type="submit">Add Product</form:button>
        </form:form>
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