<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>팁 등록</h1>
<form name="frm" method="post">
	<input type="text" name="tip_title" style="margin-bottom:15px; width:722px;" placeholder="제목을 입력하세요"/><br/>
	<textarea rows="30" cols="100" name="tip_content" placeholder="내용을 입력하세요"></textarea>
	<hr/>
	<input type="submit" value="공지등록"/>
	<input type="reset" value="등록취소" onClick="location.href='/tip/list'"/>
</form>
<script>
	$(frm).on("submit",function(e){
		e.preventDefault();

		var tip_content=$(frm.tip_content).val();
		var tip_title=$(frm.tip_title).val();
		
		if(tip_title=="" || tip_content==""){
			alert("글의 제목과 내용을 입력해주세요!");
			return;
		}
		if(!confirm("레시피를 등록 하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/tip/insert",
			data:{"tip_title":tip_title,"tip_content":tip_content},
			success:function(){}
		});
		location.href="/tip/list";	
	});	
</script>