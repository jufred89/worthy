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
	.subheading{
   text-align:left;
   font-size:150%;
   margin:20px;
   font-weight:bold;
}
</style>
<div style="width:1000px; margin:0 auto;">
	<div class="subHeading">상품 정보 수정</div>
	<div id="productUpdate">
		<form name="frm" action="/shop/update" method="POST" enctype="multipart/form-data" >
			<img id="image" src="/shop/display?file=${vo.prod_image}" width=300 height=300 />
			<input type="file" name="file" />
			<input type="hidden" name="oldImage" value="${vo.prod_image}" />
			
			<div id="insert_info">
				<div class="title">상품ID</div><input type="text" name="prod_id" value="${vo.prod_id}" /><br/>
				<div class="title">상품이름</div><input type="text" name="prod_name" value="${vo.prod_name}" /> <br/>
				<div class="title">상품회사</div><input type="text" name="prod_comp" value="${vo.prod_comp}" /><br/>
				<div class="title">상품원가</div><input type="text" name="prod_normalprice" value="${vo.prod_normalprice}" /><br/>
				<div class="title">상품할인가</div><input type="text" name="prod_saleprice" value="${vo.prod_saleprice}" /><br/>
				<div class="title">상품상세</div><input type="text" name="prod_detail" value="${vo.prod_detail}" /><br/>
			</div>
			<div id="detail">
				<input type="text" name="prod_cap" value="${vo.prod_cap}" placeholder="상품 중량" /><br/>
				<input type="text" name="prod_mfd" value="${vo.prod_mfd}" placeholder="제조일자" /><br/>
				<input type="text" name="prod_exp" value="${vo.prod_exp}" placeholder="유통기한" /><br/>
			</div>
			<div style="padding:20px;">
				<img src="/shop/display?file=${avo.shop_ano}" id="photo" width=100 height=100/>
				<input type="file" name="att_file" />
				<input type="hidden" name="shop_pid" value="${vo.prod_id}" />
				<input type="hidden" name="att_oldImage" value="${avo.shop_ano}" />
			</div>
			<input type="submit" class="blackBtn" value="수정" />
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
	
		if(!confirm("수정하시겠습니까")) return;
		
		frm.submit();
	});

</script>
