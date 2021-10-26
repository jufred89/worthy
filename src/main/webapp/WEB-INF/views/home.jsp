<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>워디 : 캠핑 어디까지 가봤어?</title>
<link rel="stylesheet" href="" />
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<div id="header">
	<h1>head:worthy</h1>
	</div>
	<div id="center">
		<div id="menu">
			<h4 class="col-xs-6 col-sm-4">menu1</h4>
			<h4 class="col-xs-6 col-sm-4">menu2</h4>
			<h4 class="col-xs-6 col-sm-4">menu3</h4>
		</div>
		<div id="content">
			<jsp:include page="${pageName}"></jsp:include>
		</div>
	</div>
	<div id="footer"></div>
</body>
</html>
