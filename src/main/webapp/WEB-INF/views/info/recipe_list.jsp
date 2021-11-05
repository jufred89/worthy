<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<style>
    #info_nav span{
    	margin:10px;
    	font-size:16px;
    }
    #info_nav span a{
	  	color:gray; 
      	text-decoration: none;
    }
</style>
<style>
	table {
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
	a{
		color:black;
		font-weight:bold;
		text-decoration:none;
	}
	a:hover{
		color:red;
	}
</style>
<div id="info_nav">
	<span><a href="/notice/list">공지사항</a></span>
	<span><a href="/tip/list">캠핑팁</a></span>
	<span><a href="/recipe/list">레시피</a></span>
	<h1>레시피 목록 페이지</h1>
	<span><a href="/recipe/insert">레시피 등록</a></span>
</div>

<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
		<tr class="title">
			<td></td>
			<td>레시피번호</td>
			<td>이미지</td>
			<td>레시피명</td>
			<td>작성자</td>
			<td>작성일시</td>
			<td>삭제</td>
		</tr>
	{{#each .}}
		<tr class="row">
			<td class="fi_no">{{fi_no}}</td>
			<td><img src="http://placehold.it/150x150"/></td>
			<td class="fi_title" onClick="location.href='/recipe/read?fi_no={{fi_no}}'">{{fi_title}}</td>
			<td>{{fi_writer}}</td>
			<td>{{fi_regdate}}</td>
			<td><input type="button" class="btnDelete" value="삭제"></td>
		</tr>
	{{/each}}
</script>
<script>
	//공지사항 삭제
	$("#tbl").on("click", ".row .btnDelete",function(){
		var fi_no=$(this).parent().parent().find(".fi_no").html();
		
		if(!confirm("해당 레시피를 삭제하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/recipe/delete",
			data:{"fi_no":fi_no},
			success:function(){
				alert("삭제완료!");
			}
		})
		location.href="/recipe/list";
	});
	
	//레시피 목록
	getRecipeList();
	function getRecipeList() {
		$.ajax({
			type : "get",
			url : "/rlist.json",
			dataType : "json",
			success : function(data) {
				var temp = Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
			}
		});
	}
</script>