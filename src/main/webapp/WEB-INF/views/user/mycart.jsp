<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div id="sub">
	<div class="subheading">장바구니</div>
	<div class="mycart">
		<table id="tblCart"></table>
		<script id="temp" type="text/x-handlebars-template">
			<tr>
				<th width=200 colspan=2><input type="checkbox" id="chkAll" /> 전체선택</th>
				<th width=400>상품정보</th>
				<th width=100>수량</th>
				<th width=150>상품금액</th>
				<th width=150>배송비</th>
			</tr>
			{{#each cart_list}}
				<tr class="item">
					<td>
						<input type="checkbox" class="chk" />
						<input type="hidden" class="no" value="{{cart_no}}" />
					</td>
					<td><img src='/shop/display?file={{cart_pimage}}'width="100" height="100"/></td>
					<td class="title">{{cart_pname}}</td>
					<td>
						<div class="quantityBox">
							<button class="minus">-</button>
							<div class="quantity">{{cart_pqty}}</div>
							<button class="plus">+</button>
						</div>
					</td>
					<td class="price">{{cart_price}}</td>
					<td class="shippingfee">3000원</td>
				</tr>
			{{/each}}
			<tr>
				<td>
					<span>상품금액</span>
					<span id="price_sum"></span>
					<span>원</span>
				</td>
				<td>
					<span>배송비</span>
					<span id="shippingfee_sum"></span>
				</td>
				<td >
					<span>주문가격</span>
					<span id="order_amount"></span>
					<span>원</span>
				</td>
			</tr>
			<tr>
				<td><button id="btnDel">삭제</button></td>
				<td><button id="payment" >구매하기</button></td>
				<td><img src="/resources/kakao_payment.png" width=80 onClick="kakaoPay()"/></td>
			</tr>

		</script>
	</div>
</div>
<script>
	getCart();
	

	

	//카카오페이
	function kakaoPay(){
		var item_name = $('#tblCart .item .title').html();
		var total_amount = $('#order_amount').html();
		
		if(!confirm('결제를 진행하시겠습니까?')) return;
		$.ajax({
			type:'post',
			url:'/shop/kakaoPay',
			dataType:'json',
			data:{"item_name":item_name,"total_amount":total_amount},
			success:function(data){
				localStorage.setItem("tid",data.tid); //세션에 tid 저장
				var box = data.next_redirect_pc_url;
				window.open(box,'kakaoPay','width=500,height=600,top=80,left=1100');
				
			}
		});
	}

	//구매하기
	$("#tblCart").on("click", "#payment", function(){
		
		alert("payment insert");
		
		var pay_price = $("#price_sum").html();
		var pay_uid = "${uid}";
		
		
		alert(pay_price + " / " + pay_uid);
		
		
		$.ajax({
			type: "post",
			url: "/shop/pay_insert",
			data: {"pay_no" : 1, "pay_price" : pay_price, "pay_type" : '1', 
				"pay_uid" : pay_uid, "pay_status" : 2, "deli_postno" : '111', "deli_address1" : "인천 어딘가", 
				"deli_address2" : "101동 101호", "deli_tel" : "010-1111-2222", "deli_name" : "원동민", 
				"deli_memo" : "안전한 배송 부탁드립니다"},
			success: function(){
				$("#tblCart .item .chk:checked").each(function(){
					var cart_no = $(this).parent().find(".no").val();
					//alert(cart_no);
					
					$.ajax({
						type: "post",
						url: "/shop/order_insert",
						data: {"order_id" : 1, "cart_no" : cart_no},
						success: function(){
							
						}
					});
				});
				alert("저장됨");
			}
		});
	});
	
	//체크박스 선택시 상품 가격 변경
	$("#tblCart").on("click", ".item .chk", function() {
		var sum = 0;
		
		if ($(this).is(":checked")) {
			$("#tblCart .item .chk:checked").each(function() {
				var price_sum = $(this).parent().parent().find(".price").html();
				
				sum += Number(price_sum);
				$("#price_sum").html(sum);

				//alert(sum);
				if (sum > 50000) {
					$("#shippingfee_sum").html("무료");
					$("#order_amount").html(sum)
				} else {
					$("#shippingfee_sum").html(3000);
					$("#order_amount").html(sum + 3000);
				}
			});
		} else {
			$("#tblCart .item .chk").each(function() {
				var check = $("#tblCart .item .chk").is(":checked");
				
				//체크 되지 않은 상품은 0
				if (check == false) {
					sum += 0;
					//alert(sum);
				}

				$("#tblCart .item .chk:checked").each(function() {
						var price_sum = $(this).parent().parent().find(".price").html();
						sum += Number(price_sum);
				});
				
				$("#price_sum").html(sum);
				//alert(sum);
				if (sum > 50000) {
					$("#shippingfee_sum").html("무료");
					$("#order_amount").html(sum)
				} else {
					if (sum != 0) {
						$("#shippingfee_sum").html(3000);
						$("#order_amount").html(sum + 3000);
					} else {
						$("#shippingfee_sum").html(0);
						$("#order_amount").html(0);
					}
				}
			});
		}
	});

	//상품 가격 합계
	function getSum() {

		var cart_uid = "${uid}";

		$.ajax({
			type : "get",
			url : "/shop/cart_price_sum",
			data : {
				"cart_uid" : cart_uid
			},
			success : function(data) {
				$("#price_sum").html(data);
				if (data > 50000) {
					$("#shippingfee_sum").html("무료");
					$("#order_amount").html(data);
				} else {
					$("#shippingfee_sum").html(3000);
					var order_amount = data + 3000;
					$("#order_amount").html(order_amount);
				}
			}
		});
	}

	//전체 선택
	$("#tblCart").on("click", "#chkAll", function() {

		var price_sum = $("#price_sum").html();
		var sum = 0;
		if ($(this).is(":checked")) {
			$("#tblCart .item .chk").each(function() {
				$(this).prop("checked", true);

				var price = $(this).parent().parent().find(".price").html();
				sum += Number(price);
			});
			$("#price_sum").html(sum);
			if (sum > 50000) {
				$("#shippingfee_sum").html("무료");
				$("#order_amount").html(sum);
			} else {
				$("#shippingfee_sum").html(3000);
				$("#order_amount").html(sum + 3000);
			}
		} else {
			$("#tblCart .item .chk").each(function() {
				$(this).prop("checked", false);

				$("#price_sum").html(0);
				$("#shippingfee_sum").html(0);
				$("#order_amount").html(0);
			});
		}
	});

	//상품 체크 전체 선택 해제
	$("#tblCart").on("click", ".item .chk", function() {
		var checked = $("#tblCart .item .chk:checked").length;
		var chkAll = $("#tblCart .item .chk").length;
		//alert(checked +" / " + chkAll);

		if (checked == chkAll) {
			$("#chkAll").prop("checked", true);

		} else {
			$("#chkAll").prop("checked", false);
		}
	});

	//선택 삭제	
	$("#tblCart").on("click", "#btnDel", function() {
		var checked = $("#tblCart .item .chk:checked").length;

		if (!confirm("선택된 상품을 삭제하시겠습니까"))
			return;

		if (checked == 0) {
			alert("선택된 상품이 없습니다");
			return;
		}

		$("#tblCart .item .chk:checked").each(function() {
			var cart_no = $(this).parent().find(".no").val();

			$.ajax({
				type : "POST",
				url : "/shop/cart_delete",
				data : {
					"cart_no" : cart_no
				},
				success : function() {
					getCart();
					getSum();
				}
			});
		});
	});

	//-버튼
	$("#tblCart").on("click", ".minus", function() {
		var parent = $(this).parent().parent();
		var quantity = parent.find(".quantity").html();
		var price = parent.parent().find(".price").html();
		var normalprice = (price / quantity);
		//alert(quantity + " / " + price);

		if (quantity == 1) {
			alert('수량은 1개 이상 입력해주세요');
			return;
		} else {
			quantity--;
			$(this).parent().parent().find(".quantity").html(quantity);
			$(this).parent().parent().parent().find(".price").html(normalprice * quantity);
			
			//상품바의 배송비
			if (normalprice * quantity < 50000) {
				$(this).parent().parent().parent().find(".shippingfee").html(3000);
			}
			
			var checked = $(this).parent().parent().parent().find(".chk").is(":checked");
			
			if (checked) {
				var price_sum = Number($("#price_sum").html());
				$("#price_sum").html(price_sum - normalprice);

				if (price_sum - normalprice > 50000) {
					$("#shippingfee_sum").html("무료");
					$("#order_amount").html(price_sum - normalprice);
				} else {
					$("#shippingfee_sum").html(3000);
					$("#order_amount").html(price_sum - normalprice + 3000);
				}
			}
		}
	});

	//+버튼
	$("#tblCart").on("click", ".plus", function() {
		var parent = $(this).parent().parent();
		var quantity = parent.find(".quantity").html();
		var price = parent.parent().find(".price").html();
		var normalprice = (price / quantity);
		//alert(quantity + " / " + price + " = " + normalprice);
		
		quantity++;
		$(this).parent().parent().find(".quantity").html(quantity);
		$(this).parent().parent().parent().find(".price").html(normalprice * quantity);
		
		if (normalprice * quantity >= 50000) {
			$(this).parent().parent().parent().find(".shippingfee").html("무료배송");
		}

		var checked = $(this).parent().parent().parent().find(".chk").is(":checked");
		
		if (checked) {var price_sum = Number($("#price_sum").html());
			$("#price_sum").html(price_sum + normalprice);

			if (price_sum + normalprice > 50000) {
				$("#shippingfee_sum").html("무료");
				$("#order_amount").html(price_sum + normalprice);
			} else {
				$("#shippingfee_sum").html(3000);
				$("#order_amount").html(price_sum + normalprice + 3000);
			}
		}
	});

	//장바구니 목록
	function getCart() {
		var cart_uid = "${uid}";
		$.ajax({
			type : "get",
			url : "/shop/cart_list.json",
			data : {
				"cart_uid" : cart_uid
			},
			dataType : "json",
			success : function(data) {
				var temp = Handlebars.compile($("#temp").html());
				$("#tblCart").html(temp(data));
				
				getSum();

				$("#tblCart #chkAll").prop("checked", true);
				$("#tblCart .item .chk").each(function() {
					$(this).prop("checked", true);
				});
			}
		});
	}
</script>