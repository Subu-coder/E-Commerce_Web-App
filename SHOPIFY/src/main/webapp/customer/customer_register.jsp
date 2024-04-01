<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Customer Registration</title>
			<link rel="icon" href="https://cdn4.iconfinder.com/data/icons/shopping-and-commerce-outline-color/512/shopping_commerce_21-1024.png">
	<link type="text/css" rel='stylesheet' href="${pageContext.request.contextPath}/components/SellerStyles/registration_style.css?v=1"/>
	<%@ include file="../components/bootstrap.jsp"%>

</head>
<body>
	<%@ include file="../components/index_navbar.jsp"%>
	
	<div class="form-container">
        <h1>Customer Registration</h1> <br><br>
        <form action="${pageContext.request.contextPath}/customer_register" method="post">

            <input type="text" placeholder="First Name" name="firstname" required>
            <input type="text" placeholder="Last Name" name="lastname">

            <input type="email" placeholder="Enter Email" required name="email">
            <input type="tel" placeholder="Enter Mobile Number" maxlength="10" required name = "mobile">

            <input type="password" placeholder="Enter Your password" required minlength="4" name="password" id="password">
			<p id="invalid"></p>
            <input type="password" placeholder="Re-type password" minlength="4" path="password-cnfm" id="cnfrm-pwd" onkeyup="validation()"/>
			
            <input type="text" placeholder="Enter Your Address" required maxlength="15" name="address"> <br>
            <button type="submit">Submit</button>
        </form> <br>
        <p class="login">Already Have an account: <a href="${pageContext.request.contextPath}/customer/customer_login.jsp"> Login Here</a> </p>
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