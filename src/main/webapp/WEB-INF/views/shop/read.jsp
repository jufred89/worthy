<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<a href="/shop/update?prod_id=${vo.prod_id}">수정 버튼은 관리자페이지로 옮길 예정</a>
<h1>상품 정보 페이지</h1>

<div>
	<img src="/shop/display?file=${vo.prod_image}" />
	<div>
		<h3>${vo.prod_name }</h3>
		<p>${vo.prod_normalprice }</p>
		<p>무료배송</p>
		<p>판매자: </p>
		<p>안내사항: 판매자가 현금거래를 요구하면 거부하시고 즉시 사기 거래 신고센터에 신고하시기 바랍니다.</p>
		<div>
			<button id="minus">-</button>
			<input type="text" id="prod_count" value="1" />
			<button id="plus">+</button>
		</div>
		<div>
			<button>장바구니</button>
			<button>구매하기</button>
		</div>
	</div>
</div>
<div>
	<h3>상품 추천 슬라이드</h3>
</div>
<div>
	<table>
		<tr>
			<td class="">제품명</td>
			<td>상품상세 참조</td>
			<td class="">식품의 유형</td>
			<td>상품상세 참조</td>
		</tr>
		<tr>
			<td class="">생산자 및 소재지</td>
			<td>상품상세 참조</td>
			<td class="">제조연월일, 유통기한 또는 품질유지기한</td>
			<td>상품상세 참조</td>
		</tr>
		<tr>
			<td class="">포장단위별 내용물의 용량(중량), 수량</td>
			<td>상품상세 참조</td>
			<td class="">원재료명 및 함량</td>
			<td>상품상세 참조</td>
		</tr>
	</table>
</div>
<div>
	<img src="/shop/display?file=${avo.shop_ano}" />
</div>

<div>
	<p>리뷰</p><span>(리뷰수)</span><span id="total"></span>
	<hr/>
	<div>
		<textarea rows="2" cols="30" id="pre_review" placeholder="내용을 입력해주세요" ></textarea>
		<input type="button" id="pre_insert" value="리뷰 등록"/>
	</div>
	<div>
		<div id="preview"></div>
		<script id="temp" type="text/handlebars-template">
			{{#each list}}
				<div>
					<div>{{prod_ruid}}</div>
					<div>{{prod_review}}</div>
				</div>
			{{/each}}
		</script>
		<div id="pagination" class="pagination"></div>
		<script src="/resources/pagination.js"></script>
	</div>
</div>

<script>
	var count = 1;
	var rid = "${vo.prod_id}";
	var page = 1;
	getPreview();
	
	//-버튼
	$("#minus").on("click", function(){
		count--;
		$("#prod_count").val(count);
	});
	
	//+버튼
	$("#plus").on("click", function(){
		count++;
		$("#prod_count").val(count);
	});
	
	$("#pre_insert").on("click", function(){
		
		var prod_review = $("#pre_review").val();
		
		//alert(prod_review);
		
		if(prod_review == ""){
			alert("내용을 입력해주세요");
			$("#pre_review").focus();
			return;
		}
		
		if(!confirm("댓글을 등록하시겠습니까")) return;
			
		$.ajax({
			type: "post",
			url: "/shop/pre_insert",
			data: {"prod_ruid" : "user01", "prod_rstar" : 0, "prod_review" : prod_review, "prod_rid" : rid},
			success: function(){
				alert("등록되었습니다");
				getPreview();
			}
		});
		
	});
	
	function getPreview(){
		$.ajax({
			type: "get",
			url: "/shop/pre_list.json",
			data: {"page" : page, "prod_rid" : rid},
			dataType: "json",
			success: function(data){
				var temp = Handlebars.compile($("#temp").html());
				$("#preview").html(temp(data));
				$("#pagination").html(getPagination(data));
				
				$("#total").html(data.pm.totalCount);
			}
		});
	}
	
	$("#pagination").on("click", "a", function(e) {
		e.preventDefault();

		page = $(this).attr("href");
		getPreview();
	});
</script>
