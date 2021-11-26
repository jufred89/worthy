<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
#pagination .active{
   font-weight: bold;
   background: #f2f2f3;
}

#pagination a{
   text-decoration:none;
   font-weight: normal;
   color:black;
   padding:6px 12px;
   border:1px solid black;
}

#pagination{
   width:500px;
   margin:0 auto;
}
.subheading{
   text-align:left;
   font-size:150%;
   margin:20px;
   font-weight:bold;
}
</style>
<div id="sub">
	<div class="subheading">상품 목록</div>
<div id="condition">
	<select id="searchType">
		<option value="prod_id">상품번호</option>
		<option value="prod_name">상품명</option>
	</select>
	<input type="text" id="keyword" placeholder="검색어 입력"> 
	<span id="total"></span>

</div>
<div id="shopInsert">
	<a href="/shop/insert">상품 등록</a>
</div>
<table id="tblShop"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr>
		<th width="50">상품 번호</th>
		<th width="400">상품명</th>
		<th width="300">보유 수량</th>
		<th width="100">상품 관리</th>
	</tr>
	{{#each list}}
		<tr class="item">
			<td class="prod_id" style="color: #333;">{{prod_id}}</td>
			<td class="prod_name" onClick="location.href='/shop/update?prod_id={{prod_id}}'">{{prod_name}}</td>
			<td>
				<button class="minus">-</button>
				<input type="text" class="prod_qty" value="{{prod_stack_qty}}" />
				<button class="plus">+</button>
				<button class="change">변경</button>
			</td>
			<td>
				<button class="prod_hide"></button>
				<input type="hidden" class="status" value="{{prod_status}}" />
			</td>
		<tr>
	{{/each}}	
</script>
<div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script>
</div>
<script>
	var page=1;
	getList();

	function status(){
		$("#tblShop .item .status").each(function(){
			var prod_status = $(this).val();
			//alert(prod_status);
			
			if(prod_status == '1'){
				$(this).parent().find(".prod_hide").html("해제");	
			}else{
				$(this).parent().find(".prod_hide").html("숨김");
			}
		});
	}
	
	//숨기기/해제
	$("#tblShop").on("click", ".prod_hide", function(){
		var prod_id = $(this).parent().parent().find(".prod_id").html();
		var prod_status = $(this).parent().find(".status").val();
		
		if(!confirm("이 상품을 숨기시겠습니까")) return;
		
		//status 변경
		if(prod_status == '0'){
			prod_status = '1';
		}else{
			prod_status = '0';
		}
		
		//alert(prod_status);
		
		$.ajax({
			type: "get",
			url: "/admin/shop/hide_update",
			data: {"prod_id" : prod_id, "prod_status" : prod_status},
			success: function(){	
				alert("숨기기/해제 되었습니다");
				window.location.reload();
			}
		});	
		$(this).parent().find(".status").val(prod_status);
	});
	
	//-버튼
	$("#tblShop").on("click", ".minus", function(){
		var qty = $(this).parent().find(".prod_qty").val();
		qty--;
		$(this).parent().find(".prod_qty").val(qty);
	});
	
	//+버튼
	$("#tblShop").on("click", ".plus", function(){
		var qty = $(this).parent().find(".prod_qty").val();
		qty ++;
		$(this).parent().find(".prod_qty").val(qty);
	});
	
	//상품 개수 변경
	$("#tblShop").on("click", ".change", function(){
		var prod_id = $(this).parent().parent().find(".prod_id").html();
		var qty = $(this).parent().find(".prod_qty").val();	
		
		if(!confirm("상품 보유 개수를 변경하시겠습니까")) return;
		
		$.ajax({
			type: "get",
			url: "/admin/shop/qty_update",
			data: {"prod_id" : prod_id, "prod_stack_qty" : qty},
			success: function(){
				alert("변경되었습니다");ㅣ
			}
		});
	});
	
	//검색창 엔터 입력
	$("#keyword").on("keypress", function(e) {
		if (e.keyCode == 13) {
			page = 1;
			getList();
		}
	});

	function getList(){
		
		var keyword = $("#keyword").val();
		var searchType = $("#searchType").val();
		
		$.ajax({
			type: "get",
			url: "/admin/shop/list.json",
			data: {"page" : page, "keyword" : keyword, "searchType" : searchType},
			dataType: "json",
			success: function(data){
				var temp = Handlebars.compile($("#temp").html());
				$("#tblShop").html(temp(data));
				$("#pagination").html(getPagination(data));
				
				$("#total").html("총 " + data.pm.totalCount + "건");
				status();
			}
		});
	}
	
	$("#pagination").on("click", "a", function(e) {
		e.preventDefault();

		page = $(this).attr("href");
		getList();
	});
</script>