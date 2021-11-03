<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<style>
	input[type=file]{
		display: none;
	}
</style>

<h1>상품 정보 수정 페이지</h1>

<form name="frm" action="/shop/update" method="POST" enctype="multipart/form-data" >
	<img id="image" src="/shop/display?file=${vo.prod_image}" />
	<input type="file" name="file" />
	<input type="hidden" name="oldImage" value="${vo.prod_image}" />
	
	<div id="insert_info">
		<input type="text" name="prod_id" value="${vo.prod_id}" />
		<input type="text" name="prod_name" value="${vo.prod_name}" /> 
		<input type="text" name="prod_comp" value="${vo.prod_comp}" />
		<input type="text" name="prod_normalprice" value="${vo.prod_normalprice}" />
		<input type="text" name="prod_saleprice" value="${vo.prod_saleprice}" />
		<input type="text" name="prod_detail" value="${vo.prod_detail}" />
	</div>
	<input type="submit" value="수정" />
</form>
<script>
	//이미지 박스 클릭
	$("#image").on("click", function() {
		$(frm.file).click();
	});

	//이미지 미리보기
	$(frm.file).on("change", function() {
		var file = $(frm.file)[0].files[0];
		$("#image").attr("src", URL.createObjectURL(file));
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
	
		if(!confirm("수정하시겠습니까")) return;
		
		frm.submit();
	});

</script>
