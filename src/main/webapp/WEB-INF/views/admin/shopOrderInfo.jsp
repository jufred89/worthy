<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
	table{
		border-top: 1px solid black;
		border-bottom: 1px solid black;
		text-align: center;
	}
	tr{
		border: 1px solid black;
	}
	.title{
		background-color: #DCDCDC;
		padding: 10px;
	}
</style>

<table>
	<h3>주문자 정보</h3>
	<c:forEach items="${orderInfo }" var="order">
		<tr>
			<th class="title" width="300">주문자명 / 아이디</th>
			<td width="500">${order.deli_name} / ${order.cart_uid }</td>
		</tr>
		<tr>
			<th class="title">주문번호</th>
			<td>${order.order_id }</td>
		</tr>
		<tr>
			<th class="title">상품명</th>
			<td>${order.cart_pname }</td>
		</tr>
		<tr>
			<th class="title">상품가격 / 개수</th>
			<td>${order.cart_price } / ${order.cart_pqty }</td>
		</tr>
		<tr>
			<th class="title">전화번호</th>
			<td>${order.deli_tel }</td>
		</tr>
		<tr>
			<th class="title">우편번호</th>
			<td>${order.deli_postno }</td>
		</tr>
		<tr>
			<th class="title">주소</th>
			<td>${order.deli_address1 } ${order.deli_address2 }</td>
		</tr>
		<tr>
			<th class="title">구입일</th>
			<td>${order.f_pay_date }</td>
		</tr>
	</c:forEach>
</table>