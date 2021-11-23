<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.goBook{
	font-size:85%;
	padding:7px 25px;
	background-color:black;
	color:white;
	border:none;
	vertical-align: bottom;
}
.campingInfoBox{
	float:left;
	width:500px;
	height:250px;
	margin:30px 0 0 30px;
	border: 1px solid black;
	padding:20px;
	text-align:left;
	position: relative;
}
.campingInfoBox .title{
	font-size:170%;
	font-weight:bold;
}
.campingInfoBox .etc, .campingInfoBox .detail{margin-top:10px;}
.campingInfoBox .price{
	font-size:120%;
	margin:30px 0 0 300px;
}
</style>
<div id="sub">
	<div class="subheading">
	<h1 style="font-weight: bold">관심 캠핑장</h1>
	</div>
	<c:forEach items="${campLikeList}" var="cll">
	<div style="overflow: hidden">
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
		</div>
	</div>
	</c:forEach>
</div>