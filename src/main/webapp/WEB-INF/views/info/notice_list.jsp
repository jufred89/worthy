<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script src="../resources/bootstrap-datepicker.js"></script>
<link rel="stylesheet" href="../resources/bootstrap-datepicker.css">
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
	}
</style>

<ul id="info_nav">
	<li><p onClick="location.href='/notice/list'">공지사항</p></li>
	<li><p onClick="location.href='/tip/list'">캠핑팁</p></li>
	<li><p onClick="location.href='/recipe/list'">레시피</p></li>
</ul>
	<hr style="border:2px dotted black;width:960px;">
	<h1>공지사항</h1>
	<button onClick="location.href='/notice/insert'" class='nb_title' style="margin:10px;">공지사항 등록</button>



<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
		<tr class="title">
			<td></td>
			<td>글번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일시</td>
			<td>삭제</td>
		</tr>
	{{#each .}}
		<tr class="row">
			<td class="nb_no">{{nb_no}}</td>
			<td class="nb_title" onClick="location.href='/notice/read?nb_no={{nb_no}}'">{{nb_title}}</td>
			<td>{{nb_writer}}</td>
			<td>{{nb_regdate}}</td>
			<td><input type="button" class="btnDelete" value="삭제"></td>
		</tr>
	{{/each}}
</script>
<script>
	//공지사항 삭제
	$("#tbl").on("click", ".row .btnDelete",function(){
		var nb_no=$(this).parent().parent().find(".nb_no").html();
		
		if(!confirm("해당 공지사항을 삭제하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/notice/delete",
			data:{"nb_no":nb_no},
			success:function(){
				alert("삭제완료!");
			}
		})
		location.href="/notice/list";
	});
	
	//공지사항 목록
	getNoticeList();
	function getNoticeList() {
		$.ajax({
			type : "get",
			url : "/nlist.json",
			dataType : "json",
			success : function(data) {
				var temp = Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
			}
		});
	}
</script>