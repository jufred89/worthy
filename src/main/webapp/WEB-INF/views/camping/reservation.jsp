<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<style>
#reservation_box {
	width: 700px;
	margin: 0px auto;
	overflow: hidden;
}

#reservation_box h3 {
	float: none;
}

#user_reservation_info {
	float: left;
	width: 70%;
	text-align: left;
	padding: 0px 20px 0px 20px;
}

#checkout_box {
	float: left;
	width: 70%;
	text-align: left;
	padding: 0px 20px 0px 20px;
}

#user_reservation_info div {
	margin-bottom: 30px;
}

#user_reservation_info input[type=text] {
	padding: 10px;
	width: 100%;
}

#user_reservation_info button {
	width: 100%;
	padding: 10px;
}

#camp_reservation_info {
	float: right;
	width: 30%;
	text-align: left;
	background: rgb(245, 245, 245);
	padding: 10px;
}

#camp_reservation_info div {
	margin-bottom: 30px;
}

#camp_reservation_info button {
	width: 100%;
	padding: 10px;
}
</style>
<h1>예약하기</h1>
<hr />
<div id="reservation_box">
	<h3>예약자 정보</h3>
	<hr />
	<div id="user_reservation_info">
		<div>
			<div>
				<h4>예약자 이름</h4>
				<input type="text" placeholder="체크인시 필요한 정보입니다." />
			</div>
			<div>
				<h4>휴대폰 번호</h4>
				<input type="text" placeholder="체크인시 필요한 정보입니다." />
			</div>
		</div>
		<c:if test="${uid==null}">
			<button id="pleaseLogin">
				로그인 후 예약해주세요.<br> <br>로그인 >
			</button>
		</c:if>
		<hr />
		<h4>결제수단 선택</h4>
	</div>
	<div id="checkout_info"></div>
	<div id="camp_reservation_info">
		<h5>숙소 이름</h5>
		<div>
			<h4>${vo.camp_name}</h4>
		</div>
		<h5>객실타입/기간</h5>
		<div id="cal_daytrip">
			<c:if test="${style_no eq 1}">
				<h4>카라반</h4>
			</c:if>
			<c:if test="${style_no eq 2}">
				<h4>일반야영장</h4>
			</c:if>
			<c:if test="${style_no eq 3}">
				<h4>자동차야영장</h4>
			</c:if>
			<c:if test="${style_no eq 4}">
				<h4>글램핑</h4>
			</c:if>
		</div>
		<h5>체크인</h5>
		<div>
			<h4>${reser_checkin}</h4>
		</div>
		<h5>체크아웃</h5>
		<div>
			<h4>${reser_checkout}</h4>
		</div>
		<hr />
		<c:if test="${uid!=null}">
			<button onclick="goReservation()">결제하기</button>
		</c:if>
		<c:if test="${uid==null}">
			<button onclick="pleaseLogin()">결제하기</button>
		</c:if>
	</div>
</div>
<script>
	var camp_id = "${camp_id}";
	var style_no = "${style_no}";
	var reser_checkin = '${reser_checkin}';
	var reser_checkout = '${reser_checkout}';
	caldaytrip();
	// 몇 박 몇일인지 계산하기
	function caldaytrip() {
		var start_date = new Date(reser_checkin);
		var end_date = new Date(reser_checkout);
		var cal_daytrip = (end_date - start_date) / (1000 * 60 * 60 * 24);
		$("#cal_daytrip h4").append("/" + cal_daytrip + "박");
	}
	function goReservation() {
		alert(camp_id + "/" + style_no + "/" + reser_checkin + "/" + reser_checkout)
		$.ajax({
			type:"post",
			url:'/camping/checkout',
			data:{
				camp_id:camp_id,
				style_no:style_no,
				reser_checkin:reser_checkin,
				reser_checkout:reser_checkout
			},
			success:function(){
				alert("숙소가 예약되었습니다.")
			}
		})
	}
	function pleaseLogin() {
		alert("로그인 후 예약가능합니다.")
	}
</script>