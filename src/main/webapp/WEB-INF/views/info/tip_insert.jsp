<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	frm.content{margin:15px;}
	#imageBox{margin:0 auto;width:730px;margin-bottom:15px;}
	#file{display:none;}
</style>
<h1>팁 등록</h1>
<form name="frm" action="/tip/insert" method="POST" enctype="multipart/form-data">
	<input type="text" name="tip_no" value="${tip_no}" style="display:none;" />
	<input type="text" name="tip_title" style="margin-bottom:15px; width:722px;" placeholder="제목을 입력하세요"/><br/>
	<div id="imageBox">
		<img name="image" src="http://placehold.it/400x300"/>
		<div id="file">
			<input type="file" name="file"/>
		</div>
		<div><input type="file" name="files" accept="image/*" multiple/></div>
    <div id="files"></div>
	</div>
	<textarea rows="10" cols="100" name="tip_content" placeholder="내용을 입력하세요"></textarea>
	<hr/>
	<input type="submit" value="팁등록"/>
	<input type="reset" value="등록취소" onClick="location.href='/tip/list'"/>
</form>
<script>

	//팁 등록
	$(frm).on("submit",function(e){
		e.preventDefault();

		var tip_content=$(frm.tip_content).val();
		var tip_title=$(frm.tip_title).val();
		
		var file = $(frm.file).val();
		//var fileValue = $(frm.fi_image).val().split("\\");
		//var fi_image = fileValue[fileValue.length-1]; //파일명
		
		if(tip_title=="" || tip_content==""){
			alert("글의 제목과 내용을 입력해주세요!");
			return;
		}

		if(!confirm("팁을 등록 하시겠습니까?")) return;
		frm.submit();	
	});	
	
	//파일첨부 클릭시
	$(frm.files).on("change", function(){
		var files=$(this)[0].files;
		var str="";
		$.each(files, function(index, file){
			str += "<img src='" + URL.createObjectURL(file) + "'";
			str += "style='width:200px;height:150px;display:inline;margin:15px;' name='fi_ano'/>";
		});
		$("#files").append(str);
	});
	
	//대표이미지 클릭시
	$(frm.image).on("click", function(){
		$(frm.file).click();
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