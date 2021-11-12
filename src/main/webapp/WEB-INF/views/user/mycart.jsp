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
				<td><button id="btnDel" onClick>삭제</button></td>
			</tr>
		</script>
	</div>
</div>
<script>
	getCart();

	//전체 선택
	$("#tblCart").on("click", "#chkAll", function(){		
		if($(this).is(":checked")){
			$("#tblCart .item .chk").each(function(){
				$(this).prop("checked", true);
			});
		}else{
			$("#tblCart .item .chk").each(function(){
				$(this).prop("checked", false);		
			});
		}
	});
	
	//상품 체크 전체 선택 해제
	$("#tblCart").on("click", ".item .chk", function(){
		var checked = $("#tblCart .item .chk:checked").length;
		var chkAll = $("#tblCart .item .chk").length;
		
		//alert(checked +" / " + chkAll);
		
		if(checked == chkAll){
			$("#chkAll").prop("checked", true);
		}else{
			$("#chkAll").prop("checked", false);
		}
	});
	
	//선택 삭제	
	$("#tblCart").on("click", "#btnDel", function(){
		var checked = $("#tblCart .item .chk:checked").length;

		if(!confirm("선택된 상품을 삭제하시겠습니까")) return;
		
		if(checked == 0){
			alert("선택된 상품이 없습니다");
			return;
		}
		
		$("#tblCart .item .chk:checked").each(function(){
			var cart_no = $(this).parent().find(".no").val();
			
			$.ajax({
				type: "POST",
				url: "/shop/cart_delete",
				data: {"cart_no" : cart_no},
				success: function(){
					getCart();
				}
			});
		});
	});
	
	//-버튼
	$("#tblCart").on("click", ".minus", function(){
		var parent = $(this).parent().parent();
		var quantity = parent.find(".quantity").html();
		var price = parent.parent().find(".price").html();
		
		var normalprice = (price/quantity);
		//alert(quantity + " / " + price);
		
		if(quantity == 1){
			alert('수량은 1개 이상 입력해주세요');
			return;
		}else{
			quantity--;
			$(this).parent().parent().find(".quantity").html(quantity);
			$(this).parent().parent().parent().find(".price").html(normalprice*quantity);
			
			if(normalprice*quantity < 50000){
				$(this).parent().parent().parent().find(".shippingfee").html("3000원");
			}
		}
		

	});
	
	//+버튼
	$("#tblCart").on("click", ".plus", function(){
		var parent = $(this).parent().parent();
		var quantity = parent.find(".quantity").html();
		var price = parent.parent().find(".price").html();
		var normalprice = (price/quantity);
		
		//alert(quantity + " / " + price + " = " + normalprice);
		quantity++;
		$(this).parent().parent().find(".quantity").html(quantity);
		$(this).parent().parent().parent().find(".price").html(normalprice*quantity);
		
		if(normalprice*quantity >= 50000){
			$(this).parent().parent().parent().find(".shippingfee").html("무료배송");
		}
	});
	
	
	function getCart(){                                             
		var cart_uid = "${uid}";
		$.ajax({
			type: "get",
			url: "/shop/cart_list.json",
			data: {"cart_uid" : cart_uid},
			dataType: "json",
			success: function(data){
				var temp = Handlebars.compile($("#temp").html());
				$("#tblCart").html(temp(data));
			}
		});
	}
</script>