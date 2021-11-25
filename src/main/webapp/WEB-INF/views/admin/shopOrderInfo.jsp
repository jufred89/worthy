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
	<h3>주문 정보</h3>
	<c:forEach items="${orderInfo }" var="order">
		<tr>
			<th class="title" width="300">주문자명 / 아이디</th>
			<td width="500">${order.deli_name} / ${order.cart_uid }</td>
		</tr>
		<tr>
			<th class="title">주문번호</th>
			<td id="order_id">${order.order_id }</td>
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
		<tr>
			<th class="title">배송상태</th>
			<td><span id="status">${order.pay_status }</span> <button id="status_update">배송완료</button></td>
		</tr>
	</c:forEach>
</table>

<script>
	status();
	function status(){
		var status = $("#status").html();
		
		if(status == 2){
			$("#status").html("상품준비");
		}else if(status == 3){
			$("#status").html("배송중");
		}else if(status == 4){
			$("#status").html("배송완료");
		}else if(status == 5){
			$("#status").html("구매확정");
		}
	}

	$("#status_update").on("click", function(){
		var pay_no = $("#order_id").html();
		
		$.ajax({
			type: "post",
			url: "/admin/status",
			data: {"pay_no" : pay_no},
			success: function(){
				alert("변경되었습니다");
			}
		});
	});
</script>