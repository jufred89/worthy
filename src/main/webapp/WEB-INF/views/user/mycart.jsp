<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="sub">
	<div class="subheading">장바구니</div>
	<div class="mycart">
		<table id="tblCart">
			<tr>
				<th width=200 colspan=2><input type="checkbox"/> 전체선택</th>
				<th width=400>상품정보</th>
				<th width=100>수량</th>
				<th width=150>상품금액</th>
				<th width=150>배송비</th>
			</tr>
			<tr>
				<td><input type="checkbox"/></td>
				<td><img src='http://placehold.it/100x100'/></td>
				<td class="title">춘천 닭갈비 밀키트</td>
				<td>
					<div class="quantityBox">
						<button class="minus">-</button>
						<div class="quantity">1</div>
						<button class="plus">+</button>
					</div>
				</td>
				<td class="price">18000원</td>
				<td class="shippingfee">3000원</td>
			</tr>
		</table>
	</div>
</div>
<script>
	var quantity = $('#tblCart .quantity').html();
	var price = $('#tblCart td:eq(4)').html();
	price = price.substr(0,price.length-1);

	$('#tblCart').on('click','.minus',function(){
		quantity = quantity-1;
		if(quantity<1){
			alert('수량은 1개 이상 입력해주세요');
			return;
		}
		$('#tblCart .quantity').html(quantity);
		$('#tblCart .price').html(price*quantity+"원");
		if(parseInt($('#tblCart .price').html())<50000){
			$('#tblCart .shippingfee').html("3000원");
		}
	});
	
	$('#tblCart').on('click','.plus',function(){
		quantity = parseInt(quantity)+1;
		
		$('#tblCart .quantity').html(quantity);
		$('#tblCart .price').html(price*quantity+"원");
		if(parseInt($('#tblCart .price').html())>50000){
			$('#tblCart .shippingfee').html("무료배송");
		}
	});
</script>