<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<style type="text/css">
	.navbar{
		border-bottom:2px white solid;
		background-color: rgb(0,0,0,0.5);
		box-shadow: 0px 0px 14px aqua;
	}
	
	.navbar li:hover, .navbar button:hover{
		text-decoration: underline; 
		color:aqua;
		transition: all 0.3s;
	}
	
	.btn{
		border:none;
	}

</style>

</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark position-absolute top-0 start-0 w-100" style="">
		<div class="container-fluid">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/main/index.jsp">SHOPIFY</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="${pageContext.request.contextPath}/main/index.jsp">Home</a></li>

					<div class="dropdown">
						<button class="btn text-light dropdown-toggle" type="button"
							id="dropdownMenuButton1" data-bs-toggle="dropdown"
							aria-expanded="false">Customer</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li><a class="dropdown-item"
								href=" ${pageContext.request.contextPath}/emptyCustomer">Sign
									Up</a></li>
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/customer/customer_login.jsp">Sign
									In</a></li>
						</ul>
					</div>
					<div class="dropdown">
						<button class="btn text-light dropdown-toggle" type="button"
							id="dropdownMenuButton1" data-bs-toggle="dropdown"
							aria-expanded="false">Seller</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/emptySeller">Sign
									Up</a></li>
							<li><a class="dropdown-item"
								href="${pageContext.request.contextPath}/seller/seller_login.jsp">Sign
									In</a></li>
						</ul>
					</div>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">About Us</a></li>

				</ul>

			</div>
		</div>
	</nav>
</body>
</html>