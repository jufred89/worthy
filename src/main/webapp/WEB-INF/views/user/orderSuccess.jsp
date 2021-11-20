<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
</style>
<div class="subheading">주문이 완료되었습니다.</div>
<div id ="orderSuccess">
	<div id="orderSuccessBox">
		<div id="orderID">결제번호 <span id="pay_no"></span>(<span id="pay_date"></span>)</div>
		<div><span id="item_name">${item_name}</span> 포함 <span id="quantity">${quantity}</span>건<span id="status">결제완료</span></div>
		
	</div>
	
	<table id="delivery">
	<tr>
		<th colspan=2>배송지 정보</th>
	</tr>
	<tr>
		<td class="title">수령인</td>
		<td id="deli_name"></td>
	</tr>
	<tr>
		<td class="title">휴대폰</td>
		<td id="deli_tel"></td>
	</tr>
	<tr>
		<td class="title">주소지</td>
		<td id="deli_address1"></td>
		<td id="deli_address2"></td>
	</tr>
	</table>
	
	<table id="payinfo">
	<tr>
		<th colspan=2>결제 정보</th>
	</tr>
	<tr>
		<td class="title">결제 방식</td>
		<td id="pay_type"></td>
	</tr>
	<tr>
		<td class="title">결제 금액</td>
		<td id="pay_price"></td>
	</tr>
	</table>
</div>
<script>
var pay_no = parseInt("${pay_no}");
 $.ajax({
	type:'get',
	url:'/shop/pay.json',
	dataType:'json',
	data:{"pay_no":pay_no},
	success:function(data){
		//orderSuccess 페이지에 값 넣기
		$("#pay_no").html(data.pay_no);
		$("#pay_date").html(data.pay_date);
		$("#pay_price").html(data.pay_price);
		$("#pay_type").html(data.pay_type);
		$("#deli_address1").html(data.deli_address1);
		$("#deli_address2").html(data.deli_address2);
		$("#deli_tel").html(data.deli_tel);
		$("#deli_name").html(data.deli_name);
		
	}
 });
</script>