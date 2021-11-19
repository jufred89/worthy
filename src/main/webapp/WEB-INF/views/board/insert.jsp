<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
<link rel="stylesheet" href="../resources/board.css" />
<style>
	form{text-align:left; width:900px; margin:0 auto;}
	.cont{margin:30px;}
</style>
<h2><b>글작성</b></h2>

<div id="insertPage">
<form name="frm" enctype="multipart/form-data">

	<!-- 제목,내용 -->
	<div class="cont">
			<!-- 카테고리 -->
		<div id="condition">
			<div class="title">카테고리</div>
			<select name="fb_category">
				<option value="">카테고리 선택</option>
				<option value="sell">팝니다</option>
				<option value="buy">삽니다</option>
				<option value="greetings">가입인사</option>
				<option value="talk">캠핑톡</option>
			</select>
		</div>
		<div class="title">글번호</div><input type="text" name="fb_no" value="${fb_no }" /><br>
		<div class="title">제목</div><input type="text" name="fb_title"/><br>
		<div class="title">작성자</div><input type="text" name="fb_writer" value="${uid }" readonly/>	
	</div>
	
	<div class="cont">
		<textarea rows="20" cols="120" name="fb_content"></textarea>
	</div>
	
	<!-- 이미지 -->
	<div class="cont">
		<div><h4>대표사진</h4></div>
		<img src="http://placehold.it/300x250" name="fb_image" id="fb_image" width=300 height=250/>
		<br>
		<input type="file" name="file" style="display:none;"/>
		<div>첨부이미지: <input type="file" name="files" accept="image/*" multiple/></div>
		<div id="files"></div>
	</div>
	<hr/>
	<div id="readBtns">
		<input type="submit" value="글등록"/>
		<input type="reset" value="등록취소"/>		
	</div>
</form>
</div>
<script>

	// submit
	$(frm).on('submit',function(e){
		e.preventDefault();
		
		// 입력 검사
		var fb_category = $(frm.fb_category).val();
		var fb_title = $(frm.fb_title).val();
		var fb_writer = $(frm.fb_writer).val();
		var fb_content = $(frm.fb_content).val();
		var file = $(frm.file).val();
		
		if(fb_category==""){
			alert("카테고리를 선택해주세요");
			return;
		}
		
		if(fb_title==""){
			alert("글 제목을 입력하세요");
			$(frm.fb_title).focus();
			return;
		}
		if(fb_content==""){
			alert("내용을 입력하세요");
			$(frm.fb_content).focus();
			return;
		}
		if(file==""){
			alert("첨부파일을 등록하세요");
			return;
		}
		
		if(!confirm('글을 등록하실래요?')) return;

		frm.action="insert";
		frm.method="post";
		frm.submit();
		
	});
	

	
	$(frm.files).on('change',function(){
		var files = $(this)[0].files; //여러개의 파일이 모두 들어온다.
		var str="";
		$.each(files, function(index, file){
			str+= "<img src='" +URL.createObjectURL(file) +"' width=200 height=150/>";
		});
		$("#files").html(str);
	});
	
	//사진 click
	$('#fb_image').on('click',function(){
		$(frm.file).click();
	});
	
	// 대표사진 change
	$(frm.file).on("change",function(e){
		var file = $(this)[0].files[0];
		$('#fb_image').attr("src",URL.createObjectURL(file));
	});
</script>