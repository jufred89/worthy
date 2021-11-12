<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	frm.content{margin:15px;}
</style>
<h1>팁 수정</h1>
<form name="frm" method="post">
	<input type="hidden" name="tip_no" value="${vo.tip_no}"/>
	<input type="text" name="tip_title" style="margin-bottom:15px; width:722px;" value="${vo.tip_title}" placeholder="제목을 입력하세요"/><br/>
	<textarea rows="30" cols="100" name="tip_content" placeholder="내용을 입력하세요">${vo.tip_content}</textarea>
	<hr/>
	<input type="submit" value="수정"/>
	<input type="reset" value="수정취소" onClick="location.href='/tip/list'"/>
</form>
<script>
	$(frm).on("submit",function(e){
		e.preventDefault();

		var tip_content=$(frm.tip_content).val();
		var tip_title=$(frm.tip_title).val();
		var tip_no=$(frm.tip_no).val();
		
		if(tip_title=="" || tip_content==""){
			alert("글의 제목과 내용을 입력해주세요!");
			return;
		}
		if(!confirm("공지사항을 수정 하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/tip/update",
			data:{"tip_content":tip_content,"tip_title":tip_title, "tip_no":tip_no},
			success:function(){}
		});
		location.href="/tip/list";	
	});	
</script>
