<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	frm.content{margin:15px;}
</style>
<h1>레시피 수정</h1>
<form name="frm" method="post">
	<input type="text" name="fi_title" style="margin-bottom:15px; width:722px;" placeholder="제목을 입력하세요"/><br/>
	<textarea rows="30" cols="100" name="fi_content" placeholder="내용을 입력하세요"></textarea>
	<hr/>
	<input type="submit" value="수정"/>
	<input type="reset" value="수정취소" onClick="location.href='/recipe/list'"/>
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
		if(!confirm("레시피를 수정 하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/recipe/update",
			data:{"fi_title":fi_title,"fi_content":fi_content},
			success:function(){
				frm.submit();
			}
		});
		location.href="/recipe/list";	
	});	
</script>