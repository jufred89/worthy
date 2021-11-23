<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="../resources/admin.css" />
<style>
	input[type=file]{
		display: none;
	}
	body{padding-bottom:50px;}
</style>
<div style="width:1000px; margin:0 auto;">
<div class="subHeading">상품 정보 수정</div>
	<div id="productInsert">

		<form name="frm" action="/shop/insert" method="POST" enctype="multipart/form-data" >
			<span>대표 이미지</span>
			<img id="image" src="http://placehold.it/300x300" />
			<input type="file" name="file" />
			
			<div style="text-align:left;">
				<input type="text" name="prod_id" value="${prod_id}" />
				<input type="text" name="prod_name" placeholder="상품명" /> 
				<input type="text" name="prod_comp" placeholder="판매사" />
				<input type="text" name="prod_normalprice" placeholder="상품 가격" />
				<input type="text" name="prod_saleprice" placeholder="세일 가격" /><br/>
				<textarea name="prod_detail" id="detail" placeholder="간단한 소개 "></textarea>
			</div>
			<div>
				<input type="text" name="prod_cap" placeholder="상품 중량" />
				<input type="text" name="prod_mfd" placeholder="제조일자" />
				<input type="text" name="prod_exp" placeholder="유통기한" />
			</div>
			<div style="text-align:center;">
				<span>제품 정보 이미지 등록</span>
				<img src="http://placehold.it/200x200" id="photo" />
				<input type="file" name="att_file" />
				<input type="hidden" name="shop_pid" value="${prod_id}" />
			</div>
			<input type="submit" class="blackBtn" value="등록" />
		</form>
	</div>
</div>
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
	
	//상세 이미지
	$("#photo").on("click", function() {
		$(frm.att_file).click();
	});

	//이미지 미리보기
	$(frm.att_file).on("change", function() {
		var file = $(frm.att_file)[0].files[0];
		$("#photo").attr("src", URL.createObjectURL(file));
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
	
		if(!confirm("등록하시겠습니까")) return;
		
		frm.submit();
	});

</script>
