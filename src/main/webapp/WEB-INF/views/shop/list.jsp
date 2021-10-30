<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<style>
	#tbl{
		display: flex;
		flex: wrap;
		justify-content: space-evenly;
		align-content: stretch;
		flex-basis: 30%;
		flex-grow: 1;
		flex-shrink: 1;
	}
</style>

<h1>캠핑상점</h1>

<div id="condition">
	<input type="text" id="keyword" placeholder="검색어 입력">
	<span id="total"></span>
	<select id="searchType">
		<option value="desc">최신순</option>
		<option value="price">낮은가격순</option>
		<option value="price_desc">높은가격순</option>
	</select>
</div>
<a href="/shop/insert">상품 등록</a>
<div id="tbl"></div>
<script id="temp" type="text/x-handlebars-template">
	{{#each list}}
		<div id="item" onClick="location.href='/shop/read?prod_id={{prod_id}}'">
			<img src="http://placehold.it/300x300" />
			<div>
				<p>{{prod_name}}</p>
				<p>{{prod_normalprice}}</p>
				<p>{{prod_detail}}</p>
			</div>
		</div>
	{{/each}}
</script>
<div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script>

<script>
	var page=1;
	getList();
	
	$("#searchType").on("change", function(){
		page=1;
		getList();
	});
	
	$("#keyword").on("keypress", function(e){
		if(e.keyCode == 13){
			page=1;
			getList();
		}
	})

	function getList() {
		var keyword = $("#keyword").val();
		var searchType = $("#searchType").val();
		$.ajax({
			type : "get",
			url : "/shop/list.json",
			data: {"page" : page, "keyword" : keyword, "searchType" : searchType},
			dataType : "json",
			success : function(data) {
				var temp = Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				
				$("#pagination").html(getPagination(data));
				$("#total").html("검색건: " + data.pm.totalCount + "건");
			}
		});
	}
	
	$("#pagination").on("click", "a", function(e){
		e.preventDefault();
	
		page = $(this).attr("href");
		getList();
	});
</script>
    pageEncoding="UTF-8"%>
<h1>상품 목록 페이지</h1>
<a href="/shop/insert">상품 등록</a>


<table>
	<tr>
		<td onClick="location.href='/shop/read'">클릭하면 상품 정보 페이지로 넘어갑니다.</td>
	</tr>
</table>
