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
			</tr>
			{{#each cart_list}}
				<tr class="item">
					<td>
						<input type="checkbox" class="chk" />
						<input type="hidden" class="cart_no" value="{{cart_no}}" />
						<input type="hidden" class="cart_pid" value="{{cart_pid}}" />
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
					<span id="shippingfee_sum">무료</span>
				</td>
				<td >
					<span>주문가격</span>
					<span id="order_amount"></span>
					<span>원</span>
				</td>
			</tr>
			<tr>
				<td><button id="btnDel">삭제</button></td>
				<td><button id="payment">구매하기</button></td>
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
		var pay_price = $("#price_sum").html();
		//var shippingfee_sum = $("#shippingfee_sum").html();
		var order_amount = $("#order_amount").html();
		var pay_uid = "${uid}";
		
		//구매상품 총 개수
		var quantity = 0;
		var chked = $(".chk:checked").each(function(){
			 quantity += parseInt($(this).parent().parent().find('.quantityBox .quantity').html()); 
		});
		
		//체크된 상품중 가장 첫번째 상품명
		var item_name =  $(".chk:checked").parent().parent().find('.title').html();
		//if(!confirm("item_name: "+item_name+" 포함 "+quantity+"건")) return;
		
		$.ajax({
			type: "post",
			url: "/shop/pay_insert",
			data: {"pay_date" : "2021.11.22", "pay_price" : pay_price, "pay_type" : '1',
				"pay_uid" : pay_uid, "pay_status" : 1, "quantity":quantity, "item_name":item_name},
			success: function(data){
				$("#tblCart .item .chk:checked").each(function(){
					
					var cart_no = $(this).parent().find(".cart_no").val();
					var order_id = data;
					
					//alert(data);
					
					$.ajax({
						type: "post",
						url: "/shop/order_insert",
						data: {"order_id" : order_id, "cart_no" : cart_no},
						success: function(){
							
						}
					});
					
					//장바구니 비우기
					$.ajax({
						type: "post",
						url: "/shop/order_cart_update",
						data: {"cart_no" : cart_no},
						success: function(){
							
						}
					});
					
					var quantity = $(this).parent().parent().find(".quantity").html();
					var prod_id = $(this).parent().find(".cart_pid").val();
					
					//상품 보유 수량 업데이트
					$.ajax({
						type: "post",
						url: "/shop/order_prod_update",
						data: {"prod_id" : prod_id, "prod_stack_qty" : quantity},
						success: function(){
							
						}
					});
					
					location.href="/shop/reservation?user_id=${uid}&pay_no=" + data;
				});
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
					//$("#shippingfee_sum").html("무료");
					$("#order_amount").html(sum)
				} else {
					//$("#shippingfee_sum").html(3000);
					$("#order_amount").html(sum);
				}
			});
		} else {
			$("#tblCart .item .chk").each(function() {
				var check = $(this).is(":checked");
				var price_sum = $(this).parent().parent().find(".price").html();
				
				//체크 되지 않은 상품은 0
				if (check == false) {
					sum += Number(0);
				}else{
					sum += Number(price_sum);				
				}				
				
				$("#price_sum").html(sum);
				//alert(sum);
				if (sum > 50000) {
					//$("#shippingfee_sum").html("무료");
					$("#order_amount").html(sum)
				} else {
					if (sum != 0) {
						//$("#shippingfee_sum").html(3000);
						$("#order_amount").html(sum);
					} else {
						//$("#shippingfee_sum").html(0);
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
					//$("#shippingfee_sum").html("무료");
					$("#order_amount").html(data);
				} else {
					//$("#shippingfee_sum").html(3000);
					var order_amount = data;
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
				//$("#shippingfee_sum").html("무료");
				$("#order_amount").html(sum);
			} else {
				//$("#shippingfee_sum").html(3000);
				$("#order_amount").html(sum);
			}
		} else {
			$("#tblCart .item .chk").each(function() {
				$(this).prop("checked", false);

				$("#price_sum").html(0);
				//$("#shippingfee_sum").html(0);
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
			var cart_no = $(this).parent().find(".cart_no").val();

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
			

			
			var checked = $(this).parent().parent().parent().find(".chk").is(":checked");
			
			if (checked) {
				var price_sum = Number($("#price_sum").html());
				$("#price_sum").html(price_sum - normalprice);

				if (price_sum - normalprice > 50000) {
					//$("#shippingfee_sum").html("무료");
					$("#order_amount").html(price_sum - normalprice);
				} else {
					//$("#shippingfee_sum").html(3000);
					$("#order_amount").html(price_sum - normalprice);
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
		
		if (checked) {
			var price_sum = Number($("#price_sum").html());
			$("#price_sum").html(price_sum + normalprice);

			if (price_sum + normalprice > 50000) {
				//$("#shippingfee_sum").html("무료");
				$("#order_amount").html(price_sum + normalprice);
			} else {
				//$("#shippingfee_sum").html(3000);
				$("#order_amount").html(price_sum + normalprice);
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