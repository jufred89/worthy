<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script src="../resources/bootstrap-datepicker.js"></script>
<link rel="stylesheet" href="../resources/bootstrap-datepicker.css">
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
	
	.nb_title:hover {
       
		color: gray;
		cursor: pointer;
		
	}
	#info_nav{
	height:100px;
	align-content:center;
	justify-content:center;
	list-style:none;
	display:flex;
	margin-bottom:0;

	
	}
	#info_nav li{
	margin:50px;
	width:100px;
	height:50px;
	
	
	}
	#info_nav li p{
	justify-content:center;
	align-items:center;
	display:flex;
	color:gray;
	font-size:20px;
	width:100px;
	height:50px;
	}
	#info_nav li p:hover{
	background:black;
	color:white;
   
	
	}
	#tbl{
	position:sticky;
	}
	#footer{
	position:static;
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

<ul id="info_nav">
	<li><p onClick="location.href='/notice/list'">공지사항</p></li>
	<li><p onClick="location.href='/tip/list'">캠핑팁</p></li>
	<li><p onClick="location.href='/recipe/list'">레시피</p></li>
</ul>
	<hr style="border:2px dotted black;width:960px;">
	<h1>공지사항</h1>
	<c:if test="${uid!=null}">
		<button onClick="location.href='/notice/insert'" class='nb_title'
		 style="margin:10px;">공지사항 등록</button>
	</c:if>
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
			<td class="nb_no">{{nb_no}}</td>
			<td><img src="/notice/display?file={{nb_image}}" width=150 height=120 class="nb_image"/></td>
			<td class="nb_title" onClick="location.href='/notice/read?nb_no={{nb_no}}'">{{nb_title}}</td>
			<td>{{nb_writer}}</td>
			<td class="nb_regdate">{{dateConv nb_regdate}}</td>
			<td>{{nb_like}}</td>
			<td>{{nb_viewcnt}}</td>
		</tr>
	{{/each}}
</script>
<script>
	Handlebars.registerHelper("dateConv", function(nb_regdate, option){
		var dateObj = new Date(nb_regdate);
        var year = dateObj.getFullYear();
        var month = ("0" +(dateObj.getMonth() + 1)).slice(-2);
        var date = ("0" +(dateObj.getDate())).slice(-2);
        var hour = ("0" +(dateObj.getHours())).slice(-2);
        var min = ("0" +(dateObj.getMinutes())).slice(-2);
        var sec = ("0" +(dateObj.getSeconds())).slice(-2);
        nb_regdate = year + "-" + month + "-" + date + " " + hour + ":" + min + ":" + sec 
        return nb_regdate;  
	});
</script>
<div id="pagination" class="pagination"></div>
<script src="/resources/pagination.js"></script>
<script>
	var page = 1;	
	getNoticeList();
	
	//공지사항 목록
	function getNoticeList() {
		var keyword = $("#keyword").val();
		var searchType = $("#searchType").val();
		var perPageNum = $("#perPageNum").val();	
		$.ajax({
			type : "get",
			url : "/notice/list.json",
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
		getNoticeList();
	});

	//검색창 엔터 입력
	$("#keyword").on("keypress", function(e) {
		var keyword = $(this).val();
		if (e.keyCode == 13) {
				page=1;
				getNoticeList();
		}
	});
		
	//한페이지 출력수
	$("#perPageNum").on("change", function(){
		page=1;
		getNoticeList();
	});
	
	//내림&오름차순 정렬
	$("#searchType").on("change", function(){
		page=1;
		getNoticeList();
	});
</script>