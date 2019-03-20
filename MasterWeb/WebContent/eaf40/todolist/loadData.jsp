<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>

<title>To Do List</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/eaf40/todolist/resources/css/tododemo.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/eaf40/todolist/resources/css/material-dashboard.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/eaf40/todolist/resources/css/main.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/eaf40/todolist/resources/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/eaf40/todolist/resources/css/font-awesome.min.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/eaf40/todolist/resources/css/loading.css" type="text/css" />


</head>
<body>
	<div class="container-fluid column2">
    	<div id="loading">
    		<div class="spinner"></div>
    		
		  <%-- <p><img class="images-loader" src="<c:url value="/manual/jsp/todolist/resources/images/ajax-loader.gif" />"></p> --%>
	<!--  <p class="text-load"> Please Wait </p>   -->	
		</div>
	</div>
</body>
</html>