<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
</style>
<div class="subheading">주문이 완료되었습니다.</div>
<div id ="orderSuccess">
	<div id="orderSuccessBox">
		<div id="orderID">결제번호 <span id="aid">19</span>(<span id="approved_at"></span>)</div>
		<div><span id="item_name"></span> 포함 <span id="quantity"></span>건<span id="status">결제완료</span></div>
		
	</div>
	
	<table id="delivery">
	<tr>
		<th colspan=2>배송지 정보</th>
	</tr>
	<tr>
		<td class="title">수령인</td>
		<td>홍길동</td>
	</tr>
	<tr>
		<td class="title">휴대폰</td>
		<td>000-0000-0000</td>
	</tr>
	<tr>
		<td class="title">주소지</td>
		<td>인천시 남동구 구월동</td>
	</tr>
	</table>
	
	<table id="payinfo">
	<tr>
		<th colspan=2>결제 정보</th>
	</tr>
	<tr>
		<td class="title">결제 방식</td>
		<td id="payment_method_type"></td>
	</tr>
	<tr>
		<td class="title">결제 금액</td>
		<td id="total"></td>
	</tr>
	</table>
</div>