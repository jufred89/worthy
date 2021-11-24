<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="../resources/admin.css" />
<style>
	input[type=file]{
		display: none;
	}
	body{padding-bottom:50px;}
</style>
<div style="width:1000px; margin:0 auto;">
	<div class="subHeading">캠핑 예약 정보</div>
	<div id="productUpdate">
		<div id="insert_info">
			<div class="title">예약번호</div>
			<input type="text" value="${crr.reser_no}" /><br />
			<div class="title">캠핑장이름</div>
			<input type="text" value="${crr.camp_name}" /><br />
			<div class="title">캠핑장번호</div>
			<input type="text" value="${crr.camp_id}" /> <br />
			<div class="title">예약자명</div>
			<input type="text" value="${crr.reser_booker}" /><br />
			<div class="title">예약자전화번호</div>
			<input type="text" value="${crr.reser_booker_phone}" /><br />
			<div class="title">체크인</div>
			<input type="text" value="${crr.reser_checkin}" /><br />
			<div class="title">체크아웃</div>
			<input type="text" value="${crr.reser_checkout}" /><br />
			<c:if test="${crr.reser_status==1}">
				<div class="title">예약상태</div>
				<input type="text" value="정상예약" /><br />
			</c:if>
			<c:if test="${crr.reser_status==0}">
				<div class="title">예약상태</div>
				<input type="text" value="환불예정" /><br />
			</c:if>
			<div class="title">결제금액</div>
			<input type="text" value="${crr.reser_price}" /><br />
		</div>
	</div>
</div>
