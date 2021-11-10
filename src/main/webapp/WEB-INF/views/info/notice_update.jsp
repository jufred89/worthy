<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	frm.content{margin:15px;}
</style>
<h1>공지사항 수정</h1>
<form name="frm" method="post">
	<input type="hidden" name="nb_no" value="${vo.nb_no}"/>
	<input type="text" name="nb_title" style="margin-bottom:15px; width:722px;" value="${vo.nb_title}" placeholder="제목을 입력하세요"/><br/>
	<textarea rows="30" cols="100" name="nb_content" placeholder="내용을 입력하세요">${vo.nb_content}</textarea>
	<hr/>
	<input type="submit" value="수정"/>
	<input type="reset" value="수정취소" onClick="location.href='/notice/list'"/>
</form>
<script>
	$(frm).on("submit",function(e){
		e.preventDefault();

		var nb_content=$(frm.nb_content).val();
		var nb_title=$(frm.nb_title).val();
		var nb_no=$(frm.nb_no).val();
		
		if(nb_title=="" || nb_content==""){
			alert("글의 제목과 내용을 입력해주세요!");
			return;
		}
		if(!confirm("공지사항을 수정 하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/notice/update",
			data:{"nb_content":nb_content,"nb_title":nb_title, "nb_no":nb_no},
			success:function(){}
		});
		location.href="/notice/list";	
	});	
</script>
