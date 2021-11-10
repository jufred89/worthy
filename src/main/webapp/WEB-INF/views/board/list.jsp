<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#condition{margin-top:30px;}
	input{width:500px; padding:5px 10px; margin-left:10px;}
	select{padding:7px;}
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
	<select id="searchType">
		<option value="">카테고리</option>
		<option value="sell">팝니다</option>
		<option value="buy">삽니다</option>
		<option value="greetings">가입인사</option>
		<option value="talk">캠핑톡</option>
	</select>
	<input type="text" id="keyword" placeholder="검색어 입력"/>
</div>
<b>검색 수: <span id="total"></span></b>


<div style="overflow:hidden;">
	<div id="desc">
		<a href="fb_no" class="on">최신순</a>
		<a href="fb_like">인기순</a>
		<a href="replycnt">댓글순</a>
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
	{{#each list}}
	<tr class="rows" onClick="location.href='/board/read?fb_no={{fb_no}}'">
		<td>{{fb_no}}</td>
		<td>{{fb_category}}</td>
		<td>{{fb_title}}({{replycnt}})</td>
		<td>{{fb_writer}}</td>
		<td>{{fb_regdate}}</td>
		<td>{{fb_like}}</td>
		<td>{{fb_viewcnt}}</td>
	</tr>
	{{/each}}
</script>
<div style="text-align:center">
	<div id="pagination" class="pagination"></div>
</div>
<script src="/resources/pagination.js"></script>

<script>
	var page = 1;
	getList();

	//정렬 순서
	$("#desc a").on("click", function(e){
		e.preventDefault();
		
		$("#desc").find("a").removeClass("on");
		$(this).addClass("on");
		$("#desc a").attr("style", "color: #23527c;")
		$(".on").attr("style", "color: red; font-weight: bold");
		
		page=1;
		getList();
	});
	
	//검색창에서 엔터를 누른 경우
		$('#keyword').on('keypress',function(e){
		if(e.keyCode==13){
			page=1;
			getList();	
		}
	});
	
	function getList(){
		var keyword = $('#keyword').val();
		var searchType = $('#searchType').val();
		var desc = $(".on").attr("href");
		
		$.ajax({
			type:'get',
			url:'/board/list.json',
			dataType:'json',
			data:{"page":page,"keyword":keyword,"searchType":searchType,"desc":desc},
			success:function(data){
				var temp = Handlebars.compile($('#temp').html());
				$('#tbl_board').html(temp(data));
				$('#pagination').html(getPagination(data));
				$('#total').html(data.pm.totalCount);
			}
		});
		
	}
	
	$('#pagination').on('click','a',function(e){
		e.preventDefault();
		page = $(this).attr('href');
		getList();
	});
</script>