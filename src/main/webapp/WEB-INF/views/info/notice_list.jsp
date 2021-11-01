<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<style>
	table {
		border-collapse: collapse;
		margin-top: 10px;
		text-align:center;
		width:960px;
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
	a{
		color:black;
		font-weight:bold;
		text-decoration:none;
	}
	a:hover{
		color:red;
	}
</style>
<a href="/info/notice/list">공지사항</a>
<a href="/info/tip/list">캠핑팁</a>
<a href="/info/recipe/list">레시피</a>
<h1>공지사항</h1>
<a href="/info/notice/insert">공지사항 등록</a>

<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
			<tr class="title">
				<td>글번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일시</td>
				<td>삭제</td>
			</tr>
		{{#each .}}
			<tr class="row">
				<td class="nb_no">{{nb_no}}</td>
				<td class="nb_title" onClick="location.href='/info/notice/read?nb_no={{nb_no}}'">{{nb_title}}</td>
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
			url:"/info/notice/delete",
			data:{"nb_no":nb_no},
			success:function(){
				alert("삭제완료!");
			}
		})
		location.href="/info/notice/list";
	})
	
	//공지사항 목록
	getNoticeList();
	function getNoticeList() {
		$.ajax({
			type : "get",
			url : "/info/nlist.json",
			dataType : "json",
			success : function(data) {
				var temp = Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
			}
		});
	}
</script>