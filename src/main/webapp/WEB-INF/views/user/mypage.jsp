<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	
	#menu{float:left;}
	#menu ul{
		all: unset; 
		display:block;
		margin: 50px 0 0 10px;
	}
	#menu li{
		all: unset; 
		display:block;
	}
	#mypage{
		width:900px;
		margin:0 auto;
	}

</style>
<h3>MY PAGE</h3>
<h4>마이 페이지</h4>

<h1>${uid}님 반가워요!</h1>
<div style="border-bottom:4px solid black;"></div>
<div style="overflow:hidden; width:80%; margin:0 auto;">
	<div id="menu">
		<ul>
			<li style="font-size:140%;">My Camping</li>
			<li><a href='/mypage'>예약 정보</a></li>
			<li>관심 캠핑장</li>
		</ul>
		<ul>
			<li style="font-size:140%;">My Shop</li>
			<li><a href='/myshop'>주문 내역</a></li>
			<li>장바구니</li>
		</ul>
		<ul>
			<li style="font-size:140%;">내 계정</li>
			<li><a href='/beforeMyinfo'>회원 정보 수정</a></li>
			<c:if test="${uid ne 'admin'}">
				<li><a href='/chat' id="chat">1:1 문의</a></li>
			</c:if>
			<c:if test="${uid eq 'admin'}">
				<li><a href='/adminChat' id="adminChat">1:1 문의 목록</a></li>
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