<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
 #orderbox{
 	border: 1px solid #c2c2c3;
 }
 #orderbox .title{font-size:150%; font-weight:bold;}
 #orderbox .image{float:left;}
 #orderbox .orderinfo{float:left;}
</style>
<h3>주문내역</h3>
<h6>지난 3년간의 주문 내역 조회가 가능합니다.</h6>
<div style="border-bottom:4px solid gray;"></div>
	<div>
		<h3>2021.11.02</h3>
		
		<div id="orderbox">
			<span class="title">주문한 상품의 제목</span>
			<div style="overflow:hidden;">
				<div class="image">
					<img src="http://placehold.it/150x150"/>
				</div>
				<div class="orderinfo">
					<div>주문번호</div>
					<div>결제금액</div>
					<div>주문상태</div>
				</div>
			</div>
		</div>
	</div>
