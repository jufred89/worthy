<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	frm.content{margin:15px;}
	#imageBox{margin-bottom:25px;margin:0 auto;width:730px;}
	#file{margin:15px; border:1px dashed gray; padding:8px;}
</style>
<h1>공지사항 수정</h1>
<form name="frm" method="post">
	<input type="hidden" name="nb_no" value="${vo.nb_no}"/>
	<input type="text" name="nb_title" style="margin-bottom:15px; width:722px;" value="${vo.nb_title}" placeholder="제목을 입력하세요"/><br/>
	<div id="imageBox">
		<img name="image" src="/info/display?file=${vo.nb_image}"/>
		<div id="file">
			<input type="file" name="file"/>
		</div>
	</div>
	<textarea rows="10" cols="100" name="nb_content" placeholder="내용을 입력하세요">${vo.nb_content}</textarea>
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
	
	//이미지 미리보기
	$(frm.file).on("change",function(){
		var file = $(frm.file)[0].files[0];
		$(frm.image).attr("src", URL.createObjectURL(file));
		$(frm.image).css("width",400);
		$(frm.image).css("height",300);
		console.log(file);
	});
</script>
