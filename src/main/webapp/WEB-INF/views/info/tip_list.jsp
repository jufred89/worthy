<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="../resources/info.css"/>

<a href="/notice/list">공지사항</a>
<a href="/tip/list">캠핑팁</a>
<a href="/recipe/list">레시피</a>
<h1>팁 목록</h1>
<a href="/notice/insert">팁 등록</a>

<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
			<tr class="title">
				<td></td>
				<td>팁번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일시</td>
				<td>삭제</td>
			</tr>
		{{#each .}}
			<tr class="row">
				<td class="tip_no">{{tip_no}}</td>
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
		var nb_no=$(this).parent().parent().find(".tip_no").html();
		
		if(!confirm("해당 팁을 삭제하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/tip/delete",
			data:{"nb_no":nb_no},
			success:function(){
				alert("삭제완료!");
			}
		});
		location.href="/tip/list";
	});
	
	//팁 목록
	getTipList();
	function getTipList() {
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