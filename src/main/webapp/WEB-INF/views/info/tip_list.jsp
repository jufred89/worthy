<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
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
	
	.tip_title:hover {
		color: gray;
		cursor: pointer;
	}
	
		#tbl{
	position:sticky;
	}
	#footer{
	position:static;
	}
</style>
<ul id="info_nav">
	<li><p onClick="location.href='/notice/list'">공지사항</p></li>
	<li><p onClick="location.href='/tip/list'">캠핑팁</p></li>
	<li><p onClick="location.href='/recipe/list'">레시피</p></li>
</ul>
<hr style="border:2px dotted black;width:960px;">
	

	<h1>팁 목록 페이지</h1>
	<button onClick="location.href='/tip/insert" class='tip_title' style="margin:10px;">팁 등록</button>

<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
		<tr class="title">
			<td></td>
			<td>팁번호</td>
			<td>이미지</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일시</td>
			<td>삭제</td>
		</tr>
	{{#each .}}
		<tr class="row">
			<td class="tip_no">{{tip_no}}</td>
			<td><img src="http://placehold.it/150x150"/></td>
			<td class="tip_title" onClick="location.href='/tip/read?tip_no={{tip_no}}'">{{tip_title}}</td>
			<td>{{tip_writer}}</td>
			<td>{{tip_regdate}}</td>
			<td><input type="button" class="btnDelete" value="삭제"></td>
		</tr>
	{{/each}}
</script>
<script>
	//공지사항 삭제
	$("#tbl").on("click", ".row .btnDelete",function(){
		var tip_no=$(this).parent().parent().find(".tip_no").html();
		
		if(!confirm("해당 공지사항을 삭제하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/tip/delete",
			data:{"tip_no":tip_no},
			success:function(){
				alert("삭제완료!");
			}
		})
		location.href="/tip/list";
	});
	
	//레시피 목록
	getRecipeList();
	function getRecipeList() {
		$.ajax({
			type : "get",
			url : "/tlist.json",
			dataType : "json",
			success : function(data) {
				var temp = Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
			}
		});
	}
</script>