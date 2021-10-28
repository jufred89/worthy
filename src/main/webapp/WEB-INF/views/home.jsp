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
<style>
a{
	margin: 0px 20px 0px 20px;
}
</style>
<body>
	<div id="container">
		<div id="header">
			<img src="http://placehold.it/150x60"/>
		</div>
		<div id="center">
			<div id="menu">
				<a href="#">어디로 떠날까요?</a>
				<a href="#">언제 떠날까요?</a>
				<a href="#">테마검색</a>
				<a href="#">캠핑정보</a>
				<a href="#">캠핑상점</a>
				<a href="#">login</a>
				<a href="#">join</a>
			</div>
			<div id="content">
				<jsp:include page="${pageName}"></jsp:include>
			</div>
		</div>
		<div id="footer"></div>
	</div>
</body>
</html>
