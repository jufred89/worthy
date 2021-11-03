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

<h1>상품 등록 페이지</h1>

<form name="frm" action="/shop/insert" method="POST" enctype="multipart/form-data" >
	<img id="image" src="http://placehold.it/300x300" />
	<input type="file" name="file" />
	
	<div>
		<input type="text" name="prod_id" value="${prod_id}" />
		<input type="text" name="prod_name" placeholder="상품명" /> 
		<input type="text" name="prod_comp" placeholder="제조사" />
		<input type="text" name="prod_normalprice" placeholder="상품 가격" />
		<input type="text" name="prod_saleprice" placeholder="세일 가격" />
		<input type="text" name="prod_detail" placeholder="간단한 소개 " />
	</div>
	<input type="submit" value="등록" />
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
	
		if(!confirm("등록하시겠습니까")) return;
		
		frm.submit();
	});

</script>
