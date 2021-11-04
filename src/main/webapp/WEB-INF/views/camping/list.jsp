<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<h1>캠핑장을 찾아보세요.</h1>
<h4>어디갈지 모르겠다면?</h4>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script src="/resources/pagination.js"></script>
<div>
	<input type="text" placeholder="검색어를 입력해보세요."/> 
	<select id="searchType">
		<option value="search1">조회순</option>
		<option value="search2">최신상품순</option>
		<option value="search3">높은가격순</option>
		<option value="search4">낮은가격순</option>
	</select>
</div>
<hr />
<div id="campList"></div>
<script id="temp" type="text/x-handlebars-template">
		{{#each .}}
		<div onClick="location.href='/camping/read?camp_id={{camp_id}}'">
			<div><img src="http://placehold.it/340x340"/></div>
			<div>{{camp_name}}</div>
			<div>{{camp_addr}}</div>
			<div>{{camp_price}}</div>
		</div>
		{{/each}}
</script>
<script>
	var page = 1;
	getList();
	function getList() {
		$.ajax({
			type : 'get',
			url : '/camping/list.json',
			dataType : 'json',
			success : function(data) {
				var temp = Handlebars.compile($('#temp').html());
				$('#campList').html(temp(data));
			}
		})
	}
</script>