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

#payment_select {
	width: 200px;
	padding: .8em .5em;
	font-family: inherit;
	background:
		url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg)
		no-repeat 95% 50%;
	border: 1px solid black;
	border-radius: 0px;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
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
				<input type="text" name="reser_booker" maxlength="3"
					placeholder="체크인시 필요한 정보입니다." />
			</div>
			<div>
				<h4>휴대폰 번호</h4>
				<input type="text" name="reser_booker_phone" id="telInput" required
					pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13"
					placeholder="체크인시 필요한 정보입니다." />
			</div>
		</div>
		<c:if test="${uid==null}">
			<button id="pleaseLogin">
				로그인 후 예약해주세요.<br> <br>로그인 >
			</button>
		</c:if>
		<hr />
		<h4>결제수단 선택</h4>
		<div id="payment_box">
			<select id="payment_select" class="select_type_1" data-v-094c63f3>
				<option value="none" selected>결제 수단을 선택해주세요.</option>
				<option value="KAKAO">카카오페이</option>
			</select>
		</div>
	</div>
	<div id="checkout_info"></div>
	<div id="camp_reservation_info">
		<h5>숙소 이름</h5>
		<div>
			<h4>${vo.camp_name}</h4>
		</div>
		<h5>객실타입/기간</h5>
		<div id="cal_daytrip">
			<h4 style="display:none"></h4>
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
		<h4>총 결제금액</h4>
		<div id="totalPrice">
			<h4></h4>
		</div>
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
	var camp_name= "${vo.camp_name}"
	var style_no = "${style_no}"
	var style_price = "${style_price}"
	var reser_checkin = "${reser_checkin}";
	var reser_checkout = "${reser_checkout}";
	caldaytrip();
	
	// 전화번호 하이픈 처리
	$('#telInput').keyup(function(event) {
		event = event || window.event;
		var val = this.value.trim();
		this.value = autoHypenTel(val);
	});

	// 몇 박 몇일인지 계산하기
	function caldaytrip() {
		var start_date = new Date(reser_checkin);
		var end_date = new Date(reser_checkout);
		var cal_daytrip = (end_date - start_date) / (1000 * 60 * 60 * 24);
		$("#cal_daytrip h4:nth-child(1)").html(cal_daytrip);
		$("#cal_daytrip h4:nth-child(2)").append("/" + cal_daytrip + "박");
		// 몇 박 몇일 기준 총 금액 계산
		var totalCount = cal_daytrip*style_price
		$("#totalPrice h4").html(totalCount);
		return cal_daytrip;
	}

	// 예약자 정보 보내기
	function goReservation() {
		// 스타일 이름, 예약자 이름, 전화번호 
		var style_name = $("#cal_daytrip h4").html();
		var reser_booker = $("input[name='reser_booker']").val();
		var reser_booker_phone = $("input[name='reser_booker_phone']").val();
		var payment_select = $("#payment_select").val();
		
		// 카카오 결제 정보 넘기기
		var item_name = camp_name+"/"+style_name
		var quantity = $("#cal_daytrip h4:nth-child(1)").html();
		var total_amount = quantity*style_price
		alert(item_name+"/"+quantity+"/"+total_amount);
		if (reser_booker == "") {
			alert("예약자 이름을 입력해주세요.")
			$("input[name='reser_booker']").focus();
			return;
		}
		if (reser_booker_phone == "") {
			alert("예약자 전화번호를 입력해주세요.")
			$("input[name='reser_booker_phone']").focus();
			return;
		}
		if (payment_select == "none") {
			alert("결제수단을 선택해주세요.")
			$("#payment_select").focus();
			return;
		}
		if (payment_select == "KAKAO") {
			alert("결제창으로 넘어갑니다.")
			$.ajax({
				type:'post',
				url:'/kakaoPay',
				dataType:'json',
				data:{"item_name":item_name,"total_amount":total_amount},
				success:function(data){
					localStorage.setItem("tid",data.tid); //세션에 tid 저장
					var box = data.next_redirect_pc_url;
					window.open(box,'kakaoPay','width=500,height=600,top=80,left=1100');
					
				}
			});
		}
		
		/*
		$.ajax({
			type : "post",
			url : '/camping/checkout',
			data : {
				camp_id : camp_id,
				style_no : style_no,
				reser_checkin : reser_checkin,
				reser_checkout : reser_checkout
			},
			success : function() {
				alert("숙소가 예약되었습니다.")
			}
		})
		*/
	}
	// 비로그인시 알림
	function pleaseLogin() {
		alert("로그인 후 예약가능합니다.")
	}
</script>
<!-- 전화번호  하이픈 자동입력 -->
<script>
	function autoHypenTel(str) {
		str = str.replace(/[^0-9]/g, '');
		var tmp = '';

		if (str.substring(0, 2) == 02) {
			// 서울 전화번호일 경우 10자리까지만 나타나고 그 이상의 자리수는 자동삭제
			if (str.length < 3) {
				return str;
			} else if (str.length < 6) {
				tmp += str.substr(0, 2);
				tmp += '-';
				tmp += str.substr(2);
				return tmp;
			} else if (str.length < 10) {
				tmp += str.substr(0, 2);
				tmp += '-';
				tmp += str.substr(2, 3);
				tmp += '-';
				tmp += str.substr(5);
				return tmp;
			} else {
				tmp += str.substr(0, 2);
				tmp += '-';
				tmp += str.substr(2, 4);
				tmp += '-';
				tmp += str.substr(6, 4);
				return tmp;
			}
		} else {
			// 핸드폰 및 다른 지역 전화번호 일 경우
			if (str.length < 4) {
				return str;
			} else if (str.length < 7) {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3);
				return tmp;
			} else if (str.length < 11) {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3, 3);
				tmp += '-';
				tmp += str.substr(6);
				return tmp;
			} else {
				tmp += str.substr(0, 3);
				tmp += '-';
				tmp += str.substr(3, 4);
				tmp += '-';
				tmp += str.substr(7);
				return tmp;
			}
		}
	}
</script>