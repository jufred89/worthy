<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<style>
    #info_nav span{
    	margin:10px;
    	font-size:18px;
    }
    #info_nav div a{
    	margin:10px;
    	font-size:16px;
    	color:gray; 
      	text-decoration: none;
    }
    #info_nav span a{
	  	color:gray; 
      	text-decoration: none;
    }
    #condition{
    	width:960px;
    	margin:0 auto;
    	padding:5px;
    	margin-bottom:5px;
    	overflow:hidden;
    }
    #condition input[type=text]{
    	float:left;
    	size:20px;
    }
    #condition select{
    	float:right;
    	margin-botton:10px;
    	margin-left:15px;
    	width:150px;
    	padding:5px;
    	border-radius:5px 5px 5px;
    }
    #total{float:left; margin-left:3px;}
</style>
<style>
	#tbl {
		border-collapse: collapse;
		margin-top: 10px;
		text-align:center;
		width:960px;
		margin:0 auto;
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
	#tbl a{
		color:black;
		font-weight:bold;
		text-decoration:none;
	}
	#tbl a:hover{
		color:red;
	}
	a{border:none;}
	#pagination {
	  margin-top:15px;
	  text-align: center;
	  float:none;
	}
	
	#pagination a {
	  color: black;
	  float: left;
	  padding: 8px 16px;
	  text-decoration: none;
	}
	
	#pagination a.active {
	  background-color: gray;
	  color: white;
	}
	
	#pagination a:hover:not(.active) {
	   background-color: #ddd;
	}
</style>
<div id="info_nav">
	<span><a href="/notice/list">공지사항</a></span>
	<span><a href="/tip/list">캠핑팁</a></span>
	<span><a href="/recipe/list">레시피</a></span>
	<h1>레시피</h1>
	<c:if test="${uid!=null}">
		<button onClick="location.href='/recipe/insert'">레시피 등록</button>
	</c:if>
</div>

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
			<td width=80>번호</td>
			<td width=160>이미지</td>
			<td width=400>제목</td>
			<td width=110>작성자</td>
			<td width=100>작성일시</td>
			<td width=80>좋아요</td>
			<td width=80>조회수</td>
		</tr>
	{{#each list}}
		<tr class="row">
			<td class="fi_no">{{fi_no}}</td>
			<td><img src="/info/display?file={{fi_image}}" width=150 height=120 class="fi_image"/></td>
			<td class="fi_title" onClick="location.href='/recipe/read?fi_no={{fi_no}}'">{{fi_title}}</td>
			<td>{{fi_writer}}</td>
			<td class="fi_regdate">{{dateConv fi_regdate}}</td>
			<td>{{fi_like}}</td>
			<td>{{fi_viewcnt}}</td>
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
        fi_regdate = year + "-" + month + "-" + date;// + " " + hour + ":" + min + ":" + sec 
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