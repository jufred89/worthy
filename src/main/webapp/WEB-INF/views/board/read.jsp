<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>글 읽기</h1>
<form name="frm" enctype="multipart/form-data">
	<!-- 카테고리 -->
	<div>
		카테고리
		<select name="fb_category">
			<option value="fb_category">${vo.fb_category }</option>
		</select>
	</div>
	
	<!-- 제목,내용 -->
	<div class="cont">
		<span>제목</span><input type="text" name="fb_title" value="${vo.fb_title }"/>
		<span>작성자</span><input type="text" name="fb_writer" value="${vo.fb_writer }"/>	
	</div>
	<div class="cont">
		<textarea rows="20" cols="120" name="fb_content">${vo.fb_content }</textarea>
	</div>
	
	<!-- 이미지 -->
	<div class="cont">
		<div><h4>대표사진</h4></div>
		<img src="/board/display?file=${vo.fb_image }" name="fb_image" id="fb_image" width=300 height=250/>
		<br>
		
		<div><b>첨부이미지</b> <input type="file" name="file" style="display:none;"/></div>
	</div>
	
	<hr/>
	<div style="margin-top:20px;">
		<input type="submit" value="글수정"/>
		<input type="reset" value="취소"/>		
	</div>
</form>

<script>


</script>