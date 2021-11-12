<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>

#condition{position:relative; height:50px;}
#condition input[type=text]{
	position:absolute;
	left:0%;
}
.fa-search {
  color: #c2c2c3;
  position:absolute;
  left:55%;
  top:15px;
}
</style>
<div id="sub">
	<div class="subheading">주문내역</div>
	<div id="condition">
		<input type="text" name="keyword" placeholder="주문 내역 조회가 가능합니다." value=""/>
		<i class="fa fa-search fa-lg" aria-hidden="true"></i>
	</div>
	<div class="divider"></div>
	<div class="myshop">
		<h3>2021.11.02</h3>
		<div class="orderbox">
		<span class="status">상품준비중</span>
			<div style="overflow:hidden; margin-top:10px;">
				<div class="image">
					<img src="http://placehold.it/150x150"/>
				</div>
				<div class="orderinfo">
					<div class="title"><span>상품명</span>|<span class="quantity">1개</span></div>
					<div class="orderId"><span>주문번호</span></div>
					<div class="price"><span>결제금액</span></div>
				</div>
				<div class="orderBtn">
					<div>
						<button class="whiteBtn">배송조회</button>
					</div>
					<div>
						<button class="blackBtn">리뷰작성</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>