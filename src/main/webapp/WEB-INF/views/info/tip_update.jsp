<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	frm.content{margin:15px;}
</style>
<h1>팁 수정</h1>
<form name="frm" method="post">
	<input type="hidden" name="tip_no" value="${vo.tip_no}"/>
	<input type="text" name="tip_title" style="margin-bottom:15px; width:722px;" value="${vo.tip_title}" placeholder="제목을 입력하세요"/><br/>
	<div id="imageBox">
		<img name="image" src="/info/display?file=${vo.tip_image}"/>
		<div id="file">
			<input type="file" name="file"/>
		</div>
	</div>
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
	//이미지 미리보기
	$(frm.file).on("change",function(){
		var file = $(frm.file)[0].files[0];
		$(frm.image).attr("src", URL.createObjectURL(file));
		$(frm.image).css("width",400);
		$(frm.image).css("height",300);
		console.log(file);
	});
</script>
