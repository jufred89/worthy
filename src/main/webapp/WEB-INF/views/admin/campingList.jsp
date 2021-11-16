<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<h3>캠핑장 목록</h3>
<div>
	<select id="searchType">
		<option value="camp_id">업체번호</option>
		<option value="camp_name">업체명</option>
		<option value="camp_addr">업체주소</option>
	</select> <input type="text" id="keyword" placeholder="검색어" /> 
	검색수 : <span id="totCount"></span>
</div>
<span>
<a href="/admin/camping/insert">캠핑장등록</a>
</span>
<hr />
<table id="campList">
</table>
<div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script>
<script id="temp" type="text/x-handlebars-template">
  		<tr>
    		<th width="100">번호</th>
    		<th width="300">업체명</th>
    		<th width="400">업체주소</th>
    		<th width="150">전화번호</th>
  		</tr>
		{{#each list}}
  		<tr onclick="location.href='/admin/camping/update?camp_id={{camp_id}}'">
    		<td>{{camp_id}}</td>
    		<td>{{camp_name}}</td>
    		<td>{{camp_addr}}</td>
    		<td>{{camp_tel}}</td>
  		</tr>
		{{/each}}
</script>
<script>
	var page = 1;
	getList();
	
	$('#keyword').on('keypress', function(e) {
		if (e.keyCode == 13) {
			page = 1;
			getList();
		}
	})
	
	function getList() {
		var keyword = $('#keyword').val();
		var searchType = $('#searchType').val();
		$.ajax({
			type : 'get',
			url : '/admin/camping/list.json',
			dataType : 'json',
			data : {
				page : page,
				keyword : keyword,
				searchType : searchType
			},
			success : function(data) {
				var temp = Handlebars.compile($('#temp').html());
				$('#campList').html(temp(data));
				$("#pagination").html(getPagination(data));
				$("#totCount").html(data.pm.totalCount);
			}
		})
	}
	
	$('#pagination').on('click', "a", function(e) {
		e.preventDefault();
		page = $(this).attr("href");
		getList();
	})
</script>