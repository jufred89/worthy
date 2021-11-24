<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.goBook {
	font-size: 85%;
	padding: 7px 25px;
	background-color: black;
	color: white;
	border: none;
	vertical-align: bottom;
}

.campingInfoBox{
	float:left;
	width:650px;
	height:250px;
	margin:30px 0 0 30px;
	padding:20px;
	text-align:left;
	position: relative;
}

.campingInfoBox .title {
	font-size: 170%;
	font-weight: bold;
}

.campingInfoBox .etc, .campingInfoBox .detail{margin-top:20px;}
.campingInfoBox .price{
	font-size:120%;
	margin:30px 0 0 300px;
}
.subheading{
	text-align:left;
	font-size:150%;
	margin:20px 5px;
	font-weight:bold;
}
</style>
<div id="sub">
	<div class="subheading">
		관심 캠핑장
	</div>
	<c:forEach items="${campLikeList}" var="cll">
	<div style="overflow: hidden; border:1px solid #e2e2e3; padding-bottom:30px; width:1070px;">
		<div id="infoimg">
			<img src='/camping/display?file=${cll.camp_image}' width=300 height=250 />
		</div>
		<div class="campingInfoBox">
			<div class="addr">${cll.camp_addr}</div>
			<div class="title">${cll.camp_name}</div>
			<div class="etc">
				<span class="camp_memo">${cll.camp_memo}</span>
			</div>
			<div style="position:absolute; clear:left; float:left; width:300px; height:50px; left:20px; bottom:0px;">
				<button class="goBook">예약하기</button>
			</div>
		</c:forEach>
	</c:if>
	<c:if test="${campLikeList.size()==0}">
		<h3 style="text-align: center;">관심 캠핑장을 선택하지 않으셨습니다. 워디 둘러보기를 눌러보세요.</h3>
		<img src='/resources/mycampingbackground.png' width=1150px />
		<div>
			<button class="mycampingButton"
				onclick="location.href='/camping/list?camp_addr=&reser_checkin=&reser_checkout='">워디
				둘러보기</button>
		</div>
	</c:if>
</div>