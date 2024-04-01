<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Seller Registration</title>
<link type="text/css" rel='stylesheet' href="${pageContext.request.contextPath}/components/SellerStyles/registration_style.css" />
	<%@ include file="../components/bootstrap.jsp"%>

</head>
<body>
	<%@ include file="../components/index_navbar.jsp"%>
	
	<div class="form-container">
        <h1>Seller Registration</h1> <br><br>
        <form:form action="seller_register" method="post" modelAttribute="seller">

    		<form:input type="text" placeholder="First Name" path="name" required="required"/> 

            <form:input type="email" placeholder="Enter Email" path="email" required="required"/>
            <form:input type="tel" placeholder="Enter Mobile Number" maxlength="10" path="mobile" required="required"/>

            <form:input type="password" placeholder="Enter Your password" minlength="4" path="password" id="password" required="required"/>
			<p id="invalid"></p>
            <input type="password" placeholder="Re-type password" minlength="4" path="password-cnfm" id="cnfrm-pwd" onkeyup="validation()" required/>

            <form:input type="text" placeholder="Enter Your Address" maxlength="15" path="address" required="required"/> <br>
            
            <form:button id="submit">Submit</form:button>
            
        </form:form> <br>
        <p class="login">Already Have an account: <a href="${pageContext.request.contextPath}/seller/seller_login.jsp"> Login Here</a> </p>
    </div>
	
	<script type="text/javascript">
		document.getElementById("invalid").style = "display:none";
		function validation(){
			
			let pwd1 = document.getElementById("password").value;
			let pwd2 = document.getElementById("cnfrm-pwd").value;
			
				console.log(pwd1===pwd2);
			
			if(pwd1 === pwd2){
				document.getElementById("invalid").style = "display:none";
				document.getElementById("submit").disabled = "";
				document.getElementById("submit").style = "cursor: pointer;";
			}
			else{
				document.getElementById("invalid").style = "display:inline-block;color:red;font-size:16px;";
				document.getElementById("invalid").innerHTML = "Password Mismatch";
				document.getElementById("submit").disabled = "disabled";
				document.getElementById("submit").style = "cursor: not-allowed;";
				return;
			}
			
		}
	</script>
	
</body>
</html>