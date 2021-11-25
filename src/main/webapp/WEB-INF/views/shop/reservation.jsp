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

#shop_reservation_info {
	float: right;
	width: 30%;
	text-align: left;
	background: rgb(245, 245, 245);
	padding: 10px;
}

#shop_reservation_info div {
	margin-bottom: 30px;
}

#shop_reservation_info button {
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
#radio{
	padding-left: 20px;
	text-align: left;
}
</style>
<h1>구매하기</h1>
<hr />
<div id="reservation_box">
	<h3>주문 상품</h3>
	<div style="text-align:left; margin:20px 0 50px 20px;">
		<span id="item_name">${item_name}</span><span id="quantity"> 포함 총 ${quantity}개의 상품</span>
	</div>
	<h3>배송지 정보</h3>
	<div id="radio">
		<input type="radio" id="user_deli" name="shipping" onClick="deli_input()"/>
		<label for="user_deli" ><span>기존 배송지</span></label>
		<input type="radio" id="user_deli2" name="shipping" onClick="deli_input2()" checked/>
		<label for="new_deli2" ><span>신규입력</span></label>
	</div>
	<hr />
	<div id="user_reservation_info">
		<div>
			<div>
				<h4>받는분</h4>
				<input type="text" id="deli_name" />
			</div>
			<div>
				<h4>휴대폰 번호</h4>
				<input type="text" id="deli_tel" required
					pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13"
					/>
			</div>
			<div>
				<h4>배송주소</h4>
				<input type="text" id="deli_postno"
					placeholder="우편번호" />
				<button id="add_search">주소검색</button>
				<input type="text" id="deli_address1"
					placeholder="주소" />
				<input type="text" id="deli_address2"
					placeholder="상세주소" />
			</div>
			<div>
				<h4>배송시 요청사항</h4>
				<input type="text" id="deli_memo" maxlength="50"
					placeholder="최대 50자 입력" />
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
				<option value="1">카카오페이</option>
			</select>
		</div>
	</div>
	
	<div id="checkout_info"></div>
	<div id="shop_reservation_info">
		<h5>총 상품가격</h5>
		<div>
			<h4>${pvo.pay_price}</h4>
		</div>
		<h5>배송비</h5>
		<div>
			<h4>무료</h4>
		</div>
		<hr />
		<h4>총 결제가격</h4>
		<div id="totalPrice">
			<h4>${pvo.pay_price}</h4>
		</div>
		<c:if test="${uid!=null}">
			<button onclick="goReservation()">결제하기</button>
		</c:if>
		<c:if test="${uid==null}">
			<button onclick="pleaseLogin()">결제하기</button>
		</c:if>
	</div>
</div>

<!-- 주소 입력 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$("#add_search").on("click", function(){
	        //카카오 지도 발생
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	            $("#deli_postno").val(data.zonecode);
	            $("#deli_address1").val(data.address);
	            $("#deli_address2").focus();
	        }
	    }).open();
	});
	
	function deli_input(){
			var uname = "${uservo.uname}";
			var tel = "${uservo.tel}";
			var address1 = "${uservo.address}";
			
			$("#deli_name").val(uname);
			$("#deli_tel").val(tel);
			$("#deli_address1").val(address1);
	}
	
	function deli_input2(){	
		$("#deli_name").val("");
		$("#deli_tel").val("");
		$("#deli_address1").val("");
}
	
	// 전화번호 하이픈 처리
	$('#deli_tel').keyup(function(event) {
		event = event || window.event;
		var val = this.value.trim();
		this.value = autoHypenTel(val);
	});

	// 비로그인시 알림
	function pleaseLogin() {
		alert("로그인 후 예약가능합니다.")
	}

	function goReservation(){
		var pay_price = ${pvo.pay_price};
		var pay_uid = "${uid}";
		var deli_postno = $("#deli_postno").val();
		var deli_address1 = $("#deli_address1").val();
		var deli_address2 = $("#deli_address2").val();
		var deli_name = $("#deli_name").val();
		var deli_tel = $("#deli_tel").val();
		var deli_memo = $("#deli_memo").val();
		var pay_type = $("#payment_select").val();
		var pay_no = ${pvo.pay_no};
		
		if($("#payment_select").val() == 'none'){
			return;
		}
		
		//alert(pay_price + " / " + pay_uid + " / " + deli_address2 + " / " + deli_name);
		
		$.ajax({
			type: "post",
			url: "/shop/pay_update",
			data: {"pay_no" : pay_no ,"pay_status" : 2, "deli_postno" : deli_postno, "deli_address1" : deli_address1,
				"deli_address2" : deli_address2, "deli_tel" : deli_tel, "deli_name" : deli_name, 
				"deli_memo" : deli_memo},
			success: function(){
				var item_name = "${item_name}";
				var quantity = "${quantity}";
				
				if(!confirm('결제를 진행하시겠습니까?')) return;
				$.ajax({
					type:'post',
					url:'/shop/kakaoPay',
					dataType:'json',
					data:{"item_name":item_name,"quantity":quantity, "total_amount":pay_price, "pay_no":pay_no},
					success:function(data){
						localStorage.setItem("tid",data.tid); //세션에 tid 저장
						var box = data.next_redirect_pc_url;
						window.open(box,'kakaoPay','width=500,height=600,top=80,left=1100');
						
					}
				});
			}
		});
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