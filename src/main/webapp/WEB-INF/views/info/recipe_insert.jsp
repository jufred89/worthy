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
	<input type="reset" value="등록취소" onClick="location.href='/recipe/list'"/>
</form>
<script>
	$(frm).on("submit",function(e){
		e.preventDefault();

		var fi_content=$(frm.fi_content).val();
		var fi_title=$(frm.fi_title).val();
		
		if(fi_title=="" || fi_content==""){
			alert("글의 제목과 내용을 입력해주세요!");
			return;
		}
		if(!confirm("레시피를 등록 하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/recipe/insert",
			data:{"fi_title":fi_title,"fi_content":fi_content},
			success:function(){}
		});
		location.href="/recipe/list";	
	});	
</script>