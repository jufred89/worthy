<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="../resources/info.css" />

<div style="width:400px;
	margin:0 auto; text-align:center;">
	<div id="subject">INFORMATION</div>
	<h5>캠핑정보</h5>
</div>
<ul id="info_nav">
	<li><p onClick="location.href='/notice/list'">Notice</p></li>
	<li id="selected"><p onClick="location.href='/tip/list'">Tip</p></li>
	<li><p onClick="location.href='/recipe/list'">Recipe</p></li>
</ul>



<div id="container">
	<div id="condition">
		<div id="search">
			<select id="searchType">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="all">제목+내용</option>
			</select>
			<!-- <span id="total"></span> -->
			<input type="text" id="keyword" placeholder="검색어 입력">
			<span id="total"></span>  
		</div>
		<div style="overflow:hidden; margin-top:30px;">
	<c:if test="${uid.indexOf('admin')!=-1 && uid!=null}">
				<button onClick="location.href='/tip/insert'"
				id="newInsert">팁 등록</button>
			</c:if>
			<div id="sort">
				<select id="perPageNum">
					<option value="5">5개씩 보기</option>
					<option value="10">10개씩 보기</option>
					<option value="15">15개씩 보기</option>
				</select>
			</div>
		</div>
	</div>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
		<tr class="title">
			<th></th>
			<th width=50>번호</th>
			<th width=150>이미지</th>
			<th width=540>제목</th>
			<th width=100>작성자</th>
			<th width=200>작성일시</th>
			<th width=80>좋아요</th>
			<th width=80>조회수</th>
		</tr>
	{{#each list}}
		<tr class="row">
			<td class="tip_no">{{tip_no}}</td>
			<td><img src="/tip/display?file={{tip_image}}" width=150 height=120 class="tip_image"/></td>
			<td class="tip_title" onClick="location.href='/tip/read?tip_no={{tip_no}}'">{{tip_title}}</td>
			<td>{{tip_writer}}</td>
			<td>{{dateConv tip_regdate}}</td>
			<td>{{tip_like}}</td>
			<td>{{tip_viewcnt}}</td>
		</tr>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("dateConv", function(tip_regdate, option){
//		console.log(this);
//		console.log(this.fi_regdate);
//		console.log(fi_regdate);
//		console.log(option);
		
		var dateObj = new Date(tip_regdate);
        var year = dateObj.getFullYear();
        var month = ("0" +(dateObj.getMonth() + 1)).slice(-2);
        var date = ("0" +(dateObj.getDate())).slice(-2);
        var hour = ("0" +(dateObj.getHours())).slice(-2);
        var min = ("0" +(dateObj.getMinutes())).slice(-2);
        var sec = ("0" +(dateObj.getSeconds())).slice(-2);
        tip_regdate = year + "-" + month + "-" + date + " " + hour + ":" + min + ":" + sec; 
        return tip_regdate;  
	});
</script>
<div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script>
</div>
<script>
	var page = 1;	
	getTipList();
	
	//팁 목록
	function getTipList() {
		var keyword = $("#keyword").val();
		var searchType = $("#searchType").val();
		var perPageNum = $("#perPageNum").val();	
		$.ajax({
			type : "get",
			url : "/tip/list.json",
			dataType : "json",
			data:{"page":page, "keyword":keyword, "searchType":searchType, "perPageNum":perPageNum},
			success : function(data) {
				$("#pagination").html(getPagination(data));
				$("#total").html("<h5>검색건: " + data.pm.totalCount + "건</h5>");
				var temp = Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
			}
		});
	}
	
	//특정 페이지 번호를 클릭한 경우
	$("#pagination").on("click", "a", function(e){
		e.preventDefault();
		page = $(this).attr("href");
		getTipList();
	});
	
	//검색창 엔터 입력
	$("#keyword").on("keypress", function(e) {
		var keyword = $(this).val();
		if (e.keyCode == 13) {
				page=1;
				getTipList();
		}
	});
	
	//한페이지 출력수
	$("#perPageNum").on("change", function(){
		page=1;
		getTipList();
	});
	
	//내림&오름차순 정렬
	$("#searchType").on("change", function(){
		page=1;
		getTipList();
	});
</script>