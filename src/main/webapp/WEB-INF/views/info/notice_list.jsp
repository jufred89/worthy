<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="../resources/info.css"/>

<a href="/notice/list">공지사항</a>
<a href="/tip/list">캠핑팁</a>
<a href="/recipe/list">레시피</a>
<h1>공지사항</h1>
<a href="/notice/insert">공지사항 등록</a>

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
		});
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