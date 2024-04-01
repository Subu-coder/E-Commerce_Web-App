<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
    
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Customer Login</title>
			<link rel="icon" href="https://cdn4.iconfinder.com/data/icons/shopping-and-commerce-outline-color/512/shopping_commerce_21-1024.png">
	<link type="text/css" rel='stylesheet' href="${pageContext.request.contextPath}/components/SellerStyles/login_style.css" />
	
	<%@ include file="../components/bootstrap.jsp"%>

</head>
<body>
		<%@ include file="../components/index_navbar.jsp"%>
	
	
	<div class="form-container">
        <form action="${pageContext.request.contextPath}/customer_login" method="post" class="form">
            <h1>CUSTOMER LOGIN</h1>

			<c:if test="${ isValidCredentials != null }">
				<h4 style="color:crimson; display:inline;">${isValidCredentials}</h4>
			</c:if>

            <div class="input-container">
                <!-- <p id="mail-label">Email Address</p> -->
                <input type="email" id="email" placeholder="Enter Your Email" name="email" required>
                <!-- <p id="password-label">Password</p> -->
                <input type="password" id="password" placeholder="Enter Your Password" name="password" required>
                <input type="submit" value="submit" id="submit-btn">
            </div>
            <p>Not yet Registered ? <a href="${pageContext.request.contextPath}/emptyCustomer" id="register">Register Here</a></p>
        </form>
    </div>
    
</body>
</html>