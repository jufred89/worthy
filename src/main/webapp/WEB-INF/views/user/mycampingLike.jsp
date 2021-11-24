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

.campingInfoBox {
	float: left;
	width: 500px;
	height: 250px;
	margin: 30px 0 0 30px;
	border: 1px solid black;
	padding: 20px;
	text-align: left;
	position: relative;
}

.campingInfoBox .title {
	font-size: 170%;
	font-weight: bold;
}

.campingInfoBox .etc, .campingInfoBox .detail {
	margin-top: 10px;
}

.campingInfoBox .price {
	font-size: 120%;
	margin: 30px 0 0 300px;
}
.mycampingButton{
	background: black;
	color: white;
	border: none;
	padding: 10px 30px 10px 30px;
	border-radius:10px;
	font-size: 15px;
	font-weight: bold;
	text-align: center;
}
</style>
<div id="sub">
	<div class="subheading">
		<h1 style="font-weight: bold">관심 캠핑장</h1>
	</div>
	<hr />
	<c:if test="${campLikeList.size()!=0}">
		<c:forEach items="${campLikeList}" var="cll">
			<div style="overflow: hidden">
				<div id="infoimg">
					<img src='/camping/display?file=${cll.camp_image}' width=300
						height=250 />
				</div>
				<div class="campingInfoBox">
					<div class="addr">${cll.camp_addr}</div>
					<div class="title">${cll.camp_name}</div>
					<div class="etc">
						<span class="camp_memo">${cll.camp_memo}</span>
					</div>
					<div
						style="position: absolute; clear: left; float: left; width: 300px; height: 50px; left: 20px; bottom: 0px;">
						<button class="goBook">예약하기</button>
					</div>
				</div>
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