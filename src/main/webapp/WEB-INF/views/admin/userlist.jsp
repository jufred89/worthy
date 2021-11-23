<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="../resources/admin.css" />
<div id="sub">
	<div class="subheading">회원목록</div>
	<div class="userlist">
		<div>
			<select id="searchType">
				<option value="uid">아이디</option>
				<option value="uname">이름</option>
			</select>
			 <input type="text" id="keyword" placeholder="검색어" /> 
			회원수 : <span id="totCount"></span>
		</div>
	
		<table id="tbl_user">
		</table>
		<div id="pagination" class="pagination"></div>
		<script src="/resources/pagination.js"></script>
		<script id="temp" type="text/x-handlebars-template">
  			<tr>
    			<th width="100">아이디</th>
    			<th width="200">이메일</th>
    			<th width="100">이름</th>
    			<th width="150">전화번호</th>
    			<th width="300">주소</th>
  			</tr>
			{{#each list}}
  			<tr onclick="location.href='/admin/user/read?uid={{uid}}'">
    			<td>{{uid}}</td>
    			<td>{{umail}}</td>
    			<td>{{uname}}</td>
    			<td>{{tel}}</td>
    			<td>{{address}}</td>
  			</tr>
			{{/each}}
		</script>
	</div>
</div>
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
			url : '/admin/userlist.json',
			dataType : 'json',
			data : {
				page : page,
				keyword : keyword,
				searchType : searchType
			},
			success : function(data) {
				var temp = Handlebars.compile($('#temp').html());
				$('#tbl_user').html(temp(data));
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