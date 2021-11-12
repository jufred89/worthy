<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<style>
#info_nav {
	height: 100px;
	align-content: center;
	justify-content: center;
	list-style: none;
	display: flex;
	margin-bottom: 0;
}

#info_nav li {
	margin: 50px;
	width: 100px;
	height: 50px;
}

#info_nav li p {
	justify-content: center;
	align-items: center;
	display: flex;
	color: gray;
	font-size: 20px;
	width: 100px;
	height: 50px;
}

#info_nav li p:hover {
	background: black;
	color: white;
}

table {
	border-collapse: collapse;
	margin-top: 10px;
	text-align: center;
	width: 960px;
	margin: 0 auto;
}

td {
	border-bottom: 1px solid black;
	padding: 10px 0px;
}

.title {
	background: gray;
	color: white;
	text-align: center;
}

.fi_title:hover {
	color: gray;
	cursor: pointer;
}

#tbl {
	position: sticky;
}

#footer {
	position: static;
}
</style>
<ul id="info_nav">
	<li><p onClick="location.href='/notice/list'">공지사항</p></li>
	<li><p onClick="location.href='/tip/list'">캠핑팁</p></li>
	<li><p onClick="location.href='/recipe/list'">레시피</p></li>
</ul>
<hr style="border: 2px dotted black; width: 960px;">



<h1>레시피 목록 페이지</h1>
<button onClick="location.href='/recipe/insert" class='receipe_title'
	style="margin: 10px;">레시피 등록</button>

<div id="condition">
	<input type="text" id="keyword" placeholder="검색어 입력"> 
	<span id="total"></span> 
		<select id="perPageNum">
			<option value="3">3개씩 보기</option>
			<option value="6">6개씩 보기</option>
			<option value="9">9개씩 보기</option>
		</select>
		<select id="searchType">
			<option value="desc">내림차순</option>
			<option value="asc">오름차순</option>
		</select>
</div>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
		<tr class="title">
			<td></td>
			<td width=90>레시피번호</td>
			<td width=170>이미지</td>
			<td width=300>제목</td>
			<td width=150>작성자</td>
			<td width=150>작성일시</td>
			<td width=100>삭제</td>
		</tr>
	{{#each list}}
		<tr class="row">
			<td class="fi_no">{{fi_no}}</td>
			<td><img src="/info/display?file={{fi_image}}" width=150 height=120 class="fi_image"/></td>
			<td class="fi_title" onClick="location.href='/recipe/read?fi_no={{fi_no}}'">{{fi_title}}</td>
			<td>{{fi_writer}}</td>
			<td class="fi_regdate">{{dateConv fi_regdate}}</td>
			<td><input type="button" class="btnDelete" value="삭제"></td>
		</tr>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("dateConv", function(fi_regdate, option){
//		console.log(this);
//		console.log(this.fi_regdate);
//		console.log(fi_regdate);
//		console.log(option);
		
		var dateObj = new Date(fi_regdate);
        var year = dateObj.getFullYear();
        var month = ("0" +(dateObj.getMonth() + 1)).slice(-2);
        var date = ("0" +(dateObj.getDate())).slice(-2);
        var hour = ("0" +(dateObj.getHours())).slice(-2);
        var min = ("0" +(dateObj.getMinutes())).slice(-2);
        var sec = ("0" +(dateObj.getSeconds())).slice(-2);
        fi_regdate = year + "-" + month + "-" + date + " " + hour + ":" + min + ":" + sec 
        return fi_regdate;    
	});
</script>
<div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script>
<script>
	var page = 1;	
	getRecipeList();
	
	//레시피 목록
	function getRecipeList() {
		var keyword = $("#keyword").val();
		var searchType = $("#searchType").val();
		var perPageNum = $("#perPageNum").val();
		$.ajax({
			type : "get",
			url : "/recipe/list.json",
			dataType : "json",
			data:{"page":page, "keyword":keyword, "searchType":searchType, "perPageNum":perPageNum},
			success : function(data) {
				$("#pagination").html(getPagination(data));
				$("#total").html("검색건: " + data.pm.totalCount + "건");
				var temp = Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
			}
		});
	}
	
	//레시피 삭제
	$("#tbl").on("click", ".row .btnDelete",function(){
		var fi_no=$(this).parent().parent().find(".fi_no").html();
		var image=$(this).parent().parent().find(".fi_image").attr("src").split("=");
		var fi_image = image[image.length-1]; //파일명
		
		if(!confirm("해당 레시피를 삭제하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/recipe/delete",
			data:{"fi_no":fi_no,"image":fi_image},
			success:function(){
				alert("삭제완료!");
			}
		})
		location.href="/recipe/list";
	});
	
	//특정 페이지 번호를 클릭한 경우
	$("#pagination").on("click", "a", function(e){
		e.preventDefault();
		page = $(this).attr("href");
		getRecipeList();
	});

	//검색창 엔터 입력
	$("#keyword").on("keypress", function(e) {
		var keyword = $(this).val();
		if (e.keyCode == 13) {
			page=1;
			getRecipeList();
		}
	});
		
		
	//한페이지 출력수
	$("#perPageNum").on("change", function(){
		page=1;
		getRecipeList();
	});
	
	//내림&오름차순 정렬
	$("#searchType").on("change", function(){
		page=1;
		getRecipeList();
	});
	
	
</script>