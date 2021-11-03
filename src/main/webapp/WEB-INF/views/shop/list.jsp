<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<style>
#shop {
	display: flex;
	justify-content: center;
}
#item{
	margin: 20px;
}
</style>

<h1>캠핑상점</h1>

<div id="condition">
	<input type="text" id="keyword" placeholder="검색어 입력"> <span
		id="total"></span> <select id="searchType">
		<option value="desc">최신순</option>
		<option value="price">낮은가격순</option>
		<option value="price_desc">높은가격순</option>
	</select>
</div>
<a href="/shop/insert">상품등록 페이지 이동 버튼 위치는 관리자페이지로 옮길 예정</a>
<div id="shop"></div>
<script id="temp" type="text/x-handlebars-template">
	{{#each list}}
		<div id="item" onClick="location.href='/shop/read?prod_id={{prod_id}}'">
			<img src="/shop/display?file={{prod_image}}" width="350" height="350"/>
			<div>
				<p id="prod_name">{{prod_name}}</p>
				<p>{{prod_normalprice_f}}</p>
				<p>{{prod_detail}}</p>
			</div>
		</div>
	{{/each}}
</script>
<div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script>
<script>
	var page = 1;
	getList();

	$("#searchType").on("change", function() {
		page = 1;
		getList();
	});

	$("#keyword").on("keypress", function(e) {
		if (e.keyCode == 13) {
			page = 1;
			getList();
		}
	})

	function getList() {
		var keyword = $("#keyword").val();
		var searchType = $("#searchType").val();
		$.ajax({
			type : "get",
			url : "/shop/list.json",
			data : {
				"page" : page,
				"keyword" : keyword,
				"searchType" : searchType
			},
			dataType : "json",
			success : function(data) {
				var temp = Handlebars.compile($("#temp").html());
				$("#shop").html(temp(data));
				$("#pagination").html(getPagination(data));
				$("#total").html("검색건: " + data.pm.totalCount + "건");
			}
		});
	}

	$("#pagination").on("click", "a", function(e) {
		e.preventDefault();

		page = $(this).attr("href");
		getList();
	});
</script>