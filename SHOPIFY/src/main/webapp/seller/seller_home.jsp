<%@page import="com.org.dto.Seller"%>
<%@page import="com.org.daoImplementation.SellerDaoImpl"%>
<%@page import="com.org.dao.SellerDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false" %>
	
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Seller Home Page</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/components/SellerStyles/seller_home_style.css">
	
	
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
			
	<main>

        <nav class="navbar">

            <h1>Seller Account</h1>
			
			<br>
			
			<h2>Profile:<a href="${pageContext.request.contextPath }/seller_profile"><%=seller.getName()%></a></h2>
			
			<br>
			
            <ul>
                <li><a href="${pageContext.request.contextPath}/seller_logout">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/seller_to_buyer">Become a Buyer</a></li>
                <li><a href="${pageContext.request.contextPath}/seller_logout">Logout</a></li>
            </ul>

        </nav>

			
			
			<h3>
				<a href= "${pageContext.request.contextPath}/emptyProduct" >Add Products</a>
			</h3>
			<h3>
				<a href="${pageContext.request.contextPath}/seller/view_products.jsp"> View Products</a>
			</h3>
	
	
    </main>
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