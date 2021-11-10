<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	frm.content{margin:15px;}
	#imageBox{margin-bottom:25px;margin:0 auto;width:730px;}
	#file{margin:15px; border:1px dashed gray; padding:8px;}
</style>
<h1>레시피 등록</h1>
<form name="frm" action="/recipe/insert" method="POST" enctype="multipart/form-data">
	<input type="text" name="fi_title" style="margin-bottom:15px; width:722px;" placeholder="제목을 입력하세요"/><br/>
	<div id="imageBox">
		<img name="image" src="http://placehold.it/150x120"/>
		<div id="file">
			<input type="file" name="file"/>
		</div>
	</div>
	<textarea rows="30" cols="100" name="fi_content" placeholder="내용을 입력하세요"></textarea>
	<hr/>
	<input type="submit" value="레시피등록"/>
	<input type="reset" value="등록취소" onClick="location.href='/recipe/list'"/>
</form>
<script>
	$(frm).on("submit",function(e){
		e.preventDefault();

		var fi_content=$(frm.fi_content).val();
		var fi_title=$(frm.fi_title).val();
		
		var file = $(frm.file).val();
		//var fileValue = $(frm.fi_image).val().split("\\");
		//var fi_image = fileValue[fileValue.length-1]; //파일명
		
		if(fi_title=="" || fi_content==""){
			alert("글의 제목과 내용을 입력해주세요!");
			return;
		}
//		if(file ==""){
//			alert("파일을 등록해주세요!");
//			return;
//		}
		if(!confirm("레시피를 등록 하시겠습니까?")) return;
		frm.submit();
	});
	
	//이미지 미리보기
	$(frm.file).on("change",function(){
		var file = $(frm.file)[0].files[0];
		$(frm.image).attr("src", URL.createObjectURL(file));
		$(frm.image).css("width",150);
		$(frm.image).css("height",120);
		console.log(file);
	});
</script>