<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	frm.content{margin:15px;}
</style>
<h1>레시피 등록</h1>
<form name="frm" method="post">
	<input type="text" name="fi_title" style="margin-bottom:15px; width:722px;" placeholder="제목을 입력하세요"/><br/>
	<textarea rows="30" cols="100" name="fi_content" placeholder="내용을 입력하세요"></textarea>
	<hr/>
	<input type="submit" value="공지등록"/>
	<input type="reset" value="등록취소" onClick="location.href='/info/recipe/list'"/>
</form>
<script>
	$(frm).on("submit",function(e){
		e.preventDefault();

		var nb_content=$(frm.nb_content).val();
		var nb_title=$(frm.nb_title).val();
		
		if(nb_title=="" || nb_content==""){
			alert("글의 제목과 내용을 입력해주세요!");
			return;
		}
		if(!confirm("공지사항을 등록 하시겠습니까?")) return;
		frm.action="/info/recipe/insert";
		frm.method="post";
		frm.submit();
		location.href="/info/recipe/list";	
	});	
</script>