<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	frm.content{margin:15px;}
</style>
<h1>레시피 수정</h1>
<form name="frm" method="post">
	<input type="hidden" name="fi_no" value="${vo.fi_no}"/>
	<input type="text" name="fi_title" style="margin-bottom:15px; width:722px;" value="${vo.fi_title}" placeholder="제목을 입력하세요"/><br/>
	<div id="imageBox">
		<img name="image" src="/info/display?file=${vo.fi_image}"/>
		<div id="file">
			<input type="file" name="file"/>
		</div>
	</div>
	<textarea rows="30" cols="100" name="fi_content" placeholder="내용을 입력하세요">${vo.fi_content}</textarea>
	<hr/>
	<input type="submit" value="수정"/>
	<input type="reset" value="수정취소" onClick="location.href='/recipe/list'"/>
</form>
<script>
	$(frm).on("submit",function(e){
		e.preventDefault();

		var fi_content=$(frm.fi_content).val();
		var fi_title=$(frm.fi_title).val();
		var fi_no=$(frm.fi_no).val();
		
		if(fi_title=="" || fi_content==""){
			alert("글의 제목과 내용을 입력해주세요!");
			return;
		}
		if(!confirm("레시피를 수정 하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/recipe/update",
			data:{"fi_content":fi_content,"fi_title":fi_title, "fi_no":fi_no},
			success:function(){}
		});
		location.href="/recipe/list";	
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
