<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/resources/home.css" />
<link rel="stylesheet" href="/resources/admin.css" />
<style>
.subheading{
   text-align:left;
   font-size:150%;
   margin:20px;
   font-weight:bold;
}
</style>
<div id="subject">Administrator PAGE</div>
<h5>관리자 페이지</h5>

<div id="intro">
	<c:if test="${uid eq 'admin'}">
		관리자님 반가워요!
	</c:if>
</div>
<div class="line"></div>
<div style="overflow:hidden; width:80%; margin:0 auto;">
	<div id="menu">
		<ul>
			<li class="menuTitle">회원관리</li>
			<li><a href='/admin/user/list'>회원목록</a></li>
			<li><a href='/adminChat'>1:1채팅목록</a></li>
		</ul>
		<ul>
			<li class="menuTitle">캠핑장관리</li>
			<li><a href='/admin/camping/list'>캠핑장목록</a></li>
		</ul>
		<ul>
			<li class="menuTitle">상품관리</li>
			<li><a href='/admin/shop/list'>상품목록</a></li>
		</ul>
		<ul>
			<li class="menuTitle">캠핑장예약관리</li>
			<li><a href='/admin/camping/Reservelist'>캠핑장예약현황</a></li>
		</ul>
		<ul>
			<li class="menuTitle">상품구매관리</li>
			<li><a href='/admin/order'>상품주문현황</a></li>
		</ul>
	</div>
		<div id="adminpage">
			<jsp:include page="${adminPageName }"></jsp:include>	
		</div>
</div>