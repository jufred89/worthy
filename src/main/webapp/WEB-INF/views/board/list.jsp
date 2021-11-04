<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#condition{margin-top:30px;}
	input{padding:5px 110px; margin-left:10px;}
	select{padding:5px;}
	#desc{float:right; margin-right:50px;}
	#desc ul, #desc li{all: unset;}
	#desc ul{list-style: none; margin-right:30px;}
	#desc ul li{display: inline-block; margin-left:10px;}
	#tbl_board{width:900px; margin:20px auto;}
	td{ border:1px solid black; padding:10px 20px;}
</style>
<h1>FreeBoard</h1>
<a href="/board/insert">글 등록</a>

<div id="condition">
	<select>
		<option selected>카테고리</option>
		<option>팝니다</option>
		<option>삽니다</option>
		<option>가입인사</option>
		<option>캠핑톡</option>
	</select>
	<input type="text"/>
</div>
<div style="overflow:hidden;">
	<div id="desc">
		<ul>
			<li>최신순</li>
			<li>인기순</li>
			<li>댓글순</li>			
		</ul>
	</div>
</div>
<table id="tbl_board"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr>
		<th width=50>No.</th>
		<th>카테고리</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th width=50>좋아요</th>
		<th width=50>조회수</th>
	</tr>
	{{#each .}}
	<tr class="rows" onClick="location.href='/board/read?fb_no={{fb_no}}'">
		<td>{{fb_no}}</td>
		<td>{{fb_category}}</td>
		<td>{{fb_title}}</td>
		<td>{{fb_writer}}</td>
		<td>{{fb_regdate}}</td>
		<td>{{fb_like}}</td>
		<td>{{fb_viewcnt}}</td>
	</tr>
	{{/each}}
</script>

<script>
	getList();
	
	function getList(){
		$.ajax({
			type:'get',
			url:'/board/list.json',
			dataType:'json',
			success:function(data){
				var temp = Handlebars.compile($('#temp').html());
				$('#tbl_board').html(temp(data));
			}
		});
		
	}
</script>