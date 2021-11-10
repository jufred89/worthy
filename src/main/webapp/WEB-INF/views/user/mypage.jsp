<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="../resources/mypage.css" />
<div id="subject">MY PAGE</div>
<h5>마이 페이지</h5>

<div id="intro">
	<b>${uname}</b>님 반가워요!
	<div id="modifyInfo">${uid} | <a href='/beforeMyinfo'>회원 정보 수정</a></div>
</div>
<div class="line"></div>
<div style="overflow:hidden; width:80%; margin:0 auto;">
	<div id="menu">
		<ul>
			<li class="menuTitle">My Camping</li>
			<li><a href='/mypage'>예약 정보</a></li>
			<li><a href='/mycampingLike'>관심 캠핑장</a></li>
		</ul>
		<ul>
			<li class="menuTitle">My Shop</li>
			<li><a href='/myshop'>주문 내역</a></li>
			<li>장바구니</li>
		</ul>
		<ul>
			<li class="menuTitle">내 계정</li>
			<li><a href='/beforeMyinfo'>회원 정보 수정</a></li>
			<c:if test="${uid ne 'admin'}">
				<li><a href='/chat' id="chat">1:1 문의</a></li>
			</c:if>
			<c:if test="${uid eq 'admin'}">
				<li><a href='/adminChat' id="adminChat">1:1 채팅 목록</a></li>
			</c:if>
		</ul>
	</div>
		<div id="mypage">
			<jsp:include page="${myPageName }"></jsp:include>	
		</div>
</div>

<script>
	$('#chat').on('click',function(e){
		e.preventDefault();
		window.open("/chat?chat_id=${uid}","chat","width=500,height=800,top=80,left=900");  //url,창이름,속성
	});

	$('#btnSearch').on('click',function(){
		location.href='/camping/list';
	});
</script>