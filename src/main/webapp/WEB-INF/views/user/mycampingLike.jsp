<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="sub">
	<div class="subheading">
	<h1 style="font-weight: bold">관심 캠핑장</h1>
	</div>
	<c:forEach items="${campLikeList}" var="cll">
	<div style="overflow: hidden">
		<div id="infoimg">
			<img src='/camping/display?file=${cll.camp_image}' width=300 height=250 />
		</div>
		<div class="campingInfo">
			<div class="addr">${cll.camp_addr}</div>
			<div class="title">${cll.camp_name}</div>
			<div class="etc">
				<span class="camp_memo">${cll.camp_memo}</span>
			</div>
			<div class="detail">${cll.camp_detail}</div>
			<div>
				<button class="btnBook">예약하기</button>
			</div>
		</div>
	</div>
	</c:forEach>
</div>