<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<h3>주문 목록</h3>
<div>
	<select id="searchType">
		<option value="order_id">주문번호</option>
		<option value="cart_uid">주문자아이디</option>
		<option value="cart_pname">상품명</option>
	</select>
	<input type="text" id="keyword" placeholder="검색어 입력"> 
	<span id="total"></span>
</div>
<hr/>
<table id="tblOrder"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr>
		<th width="100">주문번호</th>
		<th width="100">주문자아이디</th>
		<th width="400">상품명</th>
		<th width="100">배송상태</th>
	</td>
	{{#each list}}
		<tr class="item">
			<td class="order_id">{{order_id}}</td>
			<td>{{cart_uid}}</td>
			<td>{{cart_pname}}</td>
			<td class="status">{{pay_status}}</td>
			<input type="hidden" value="{{cart_no}}" class="cart_no" />
		</tr>
	{{/each}}
</script>
<div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script>

<script>
	var page = 1;
	getOrder();
	
	$("#tblOrder").on("click", ".item", function(){
		var pay_no = $(this).find(".order_id").html();
		var cart_no = $(this).find(".cart_no").val();
		location.href="/admin/orderInfo?pay_no=" + pay_no + "&cart_no=" + cart_no;
	});
	
	$("#keyword").on("keypress", function(e){
		if(e.keyCode == 13){
			getOrder();
		}
	});
	
	function getStatus(){
		$("#tblOrder .item .status").each(function(){
			var status = $(this).html();
			
			if(status == 1){
				$(this).html("");
			}else if(status == 2){
				$(this).html("상품준비");
			}else if(status == 3){
				$(this).html("배송중");
			}else if(status == 4){
				$(this).html("배송완료");
			}else{
				$(this).html("구매확인");
			}
		})
	}
	
	function getOrder(){
		
		var keyword = $("#keyword").val();
		var searchType = $("#searchType").val();
		
		$.ajax({
			type: "get",
			url: "/admin/order.json",
			data: {"page" : page, "keyword" : keyword, "searchType" : searchType},
			dataType: "json",
			success: function(data){
				var temp = Handlebars.compile($("#temp").html());
				$("#tblOrder").html(temp(data));
				$("#pagination").html(getPagination(data));
				$("#total").html("총 " + data.pm.totalCount + "건");

				getStatus();
			}
		});
	}
	
	$("#pagination").on("click", "a", function(e) {
		e.preventDefault();

		page = $(this).attr("href");
		getOrder();
	});
</script>