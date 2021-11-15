<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 별점 출력 -->
<style>
	.star-rating{
		width: 51px;
	}
	.star-rating, .star-rating span{
		display: inline-block;
		height: 10px;
		overflow: hidden;
		background: url(/resources/star.png)no-repeat;
	}
	.star-rating span{
		background-position: left bottom;
		line-height: 0;
		vertical-align: top;
	}
	.star_color{
		color: red;
	}
</style>

<!-- 별점 리뷰 등록 / 이동예정 -->
<style>
	#prod_rstar{
	    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
	    border: 0; /* 필드셋 테두리 제거 */
	}
	#prod_rstar input[type=radio]{
	    display: none; /* 라디오박스 감춤 */
	}
	#prod_rstar label{
	    font-size: 3em; /* 이모지 크기 */
	    color: transparent; /* 기존 이모지 컬러 제거 */
	    text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
	}
	#prod_rstar label:hover{
  	  text-shadow: 0 0 0 DeepPink; /* 마우스 호버 */
	}
	#prod_rstar label:hover ~ label{
 	   text-shadow: 0 0 0 DeepPink; /* 마우스 호버 뒤에오는 이모지들 */
	}
	#prod_rstar{
	    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
	    direction: rtl; /* 이모지 순서 반전 */
	    border: 0; /* 필드셋 테두리 제거 */
	}
	#prod_rstar{
    	text-align: left;
	}
	#prod_rstar input[type=radio]:checked ~ label{
    	text-shadow: 0 0 0 DeepPink; /* 마우스 클릭 체크 */
	}
</style>
 <style>
 	.slide{
 		width: 1000px;
 		margin: 0 auto;
 	}
    *{margin:0;padding:0;}
    ul,li{list-style:none;}
    .slide{height:300px;overflow:hidden;} 
    .slide ul{width:calc(30% * 7);display:flex;animation:slide 10s infinite;} /* slide를 8초동안 진행하며 무한반복 함 */
    .slide li{width:calc(100% / 7);height:300px;}
    @keyframes slide {
      0% {margin-left:0;} /* 0 ~ 10  : 정지 */
      15% {margin-left:0;} /* 10 ~ 25 : 변이 */
      25% {margin-left:-25%;} /* 25 ~ 35 : 정지 */
      40% {margin-left:-25%;} /* 35 ~ 50 : 변이 */
      50% {margin-left:-50%;}
      65% {margin-left:-50%;}
      75% {margin-left:-75%;}
      90% {margin-left:-75%;}
      100% {margin-left:0;}
    }
    .slide_info{
    	line-height: em;
    }
  </style>

<a href="/shop/update?prod_id=${vo.prod_id}">수정 버튼은 관리자페이지로 옮길 예정</a>
<h1>상품 정보 페이지</h1>

<!-- 상단 썸네일 / 설명 -->
<div>
	<img src="/shop/display?file=${vo.prod_image}" />
	<div>
		<h3>${vo.prod_name }</h3>
		<p>${vo.prod_normalprice }</p>
		<p>무료배송</p>
		<p>판매자: </p>
		<p>안내사항: 판매자가 현금거래를 요구하면 거부하시고 즉시 사기 거래 신고센터에 신고하시기 바랍니다.</p>
		
		<c:if test="${vo.prod_stack_qty == 0 }">
			<div>품절</div>
		</c:if>
		<c:if test="${vo.prod_stack_qty >= 1 }">
			<div>
				<button id="minus">-</button>
				<input type="text" id="prod_count" value="1" />
				<button id="plus">+</button>
			</div>
			<div>
				<button id="cart">장바구니</button>
				<button>구매하기</button>
			</div>
		</c:if>
	</div>
</div>

<!-- 슬라이드 -->
<div>
	<div class="slide">
		<ul>
			
		</ul>
	</div>
	<script id="temp_slide" type="text/x-handlebars-template">
		{{#each slide}}
				<li>
					<div>
					<img src="/shop/display?file={{prod_image}}" width="200" />
					</div>
					<div class="slide_info">{{prod_name}}</div>
				</li>
		{{/each}}
	</script>
</div>

<!-- 메뉴 -->
<div>
	<div onclick="scrollMove('info')">상세정보</div>
	<div onclick="scrollMove('review')">리뷰</div>
</div>

<script>
	function scrollMove(num){
		 var offset = $("#scroll_" + num).offset();
	     $('html, body').animate({scrollTop : offset.top}, 400);
	}
</script>

<!-- 상세 설명 -->
<div>
	<table>
		<tr>
			<td>원산지</td>
			<td>상품상세 참조</td>
		</tr>
		<tr>
			<td>상품번호</td>
			<td>${vo.prod_id }</td>
		</tr>
		<tr>
			<td>포장단위별 내용물의 용량(중량), 수량</td>
			<td>${vo.prod_cap }</td>
		</tr>
		
	</table>
</div>

<!-- 상품 상세 이미지 -->
<div id="scroll_info">
	<img src="/shop/display?file=${avo.shop_ano}" />
</div>

<div>
	<table>
		<tr>
			<td>원산지</td>
			<td>상품상세참조</td>
		</tr>
		<tr>
			<td>상품번호</td>
			<td>${vo.prod_id }</td>
		</tr>
		<tr>
			<td>상품상태</td>
			<td>새상품</td>
		</tr>
		<tr>
			<td>소비자상담 관련 전화번호</td>
			<td>2021-1111</td>
		</tr>
		<tr>
			<td>제조년월일과 유통기한 또는 품질유지기한</td>
			<td>상품상세참조</td>
		</tr>
		<tr>
			<td>원재료명 및 함량(원산지정보)</td>
			<td>상품상세참조</td>
		</tr>
		<tr>
			<td>식품의 유형</td>
			<td>상품상세참조</td>
		</tr>
		<tr>
			<td>생산자 및 생산자의 소재지, 수입자</td>
			<td>상품상세참조</td>
		</tr>
		<tr>
			<td>수입식품여부</td>
			<td>상품상세참조</td>
		</tr>
		<tr>
			<td>포장단위별 내용물의 용량(중량), 수량</td>
			<td>${vo.prod_cap }</td>
		</tr>
		<tr>
			<td>제품명</td>
			<td>상품상세참조</td>
		</tr>
		<tr>
			<td>소비자 안전을 위한 주의사항</td>
			<td>상품상세참조</td>
		</tr>
	</table>
	<p>해당 인증 정보는 판매자가 등록한 것으로 등록 정보에 대한 일체의 책임은 판매자에게 있습니다.</p>
</div>

<!-- 리뷰 등록 이동 예정 -->
<div id="scroll_review">
	<span>리뷰</span><span id="total"></span>
	<hr/>
	<div>
		<div id="prod_rstar">
			<input type="radio" value="5" id="rate1" name="rating" class="rating" /><label for="rate1">⭐</label>
			<input type="radio" value="4" id="rate2" name="rating" class="rating" /><label for="rate2">⭐</label>
			<input type="radio" value="3" id="rate3" name="rating" class="rating" /><label for="rate3">⭐</label>
			<input type="radio" value="2" id="rate4" name="rating" class="rating" /><label for="rate4">⭐</label>
			<input type="radio" value="1" id="rate5" name="rating" class="rating" /><label for="rate5">⭐</label>
		</div>
		<textarea rows="2" cols="30" id="pre_review" placeholder="내용을 입력해주세요" ></textarea>
		<input type="button" id="pre_insert" value="리뷰 등록"/>
	</div>
	<div>
		<div id="preview"></div>
		<script id="temp" type="text/x-handlebars-template">
			{{#each list}}
				<div class="item">
					<div>{{prod_ruid}}</div>
					<div>
						<span class="star-rating">
							<span style="width: {{prod_rstar}}%; float: left;"></span>
						</span>
					</div>
					<div class="del" onClick=" del()">삭제</div>
					<div>{{prod_r_regdate_f}}</div>
					<div>{{prod_review}}</div>
					<input type="hidden" class="prod_rno" value="{{prod_rno}}" />
				</div>
			{{/each}}
		</script>
		<div id="pagination" class="pagination"></div>
		<script src="/resources/pagination.js"></script>
	</div>
</div>

<div>
	<button id="upBtn">위로</button>
</div>

<script>
	$("#upBtn").on("click", function(){
		$("html, body").scrollTop(0);
	});
</script>

<script>
	var count = 1;
	var prod_rid = "${vo.prod_id}";
	var page = 1;
	getPreview();
	getSlide();
	
	//장바구니 담기
	$("#cart").on("click", function(){
		var cart_pid = "${vo.prod_id}";
		var cart_uid = "${uid}";
		var cart_pqty = $("#prod_count").val();
		var normalprice = "${vo.prod_normalprice}";
		var cart_price = normalprice * cart_pqty;
		var cart_pimage = "${vo.prod_image}";
		var cart_pname = "${vo.prod_name}";
		
		//alert(cart_pid +" / "+ cart_uid +" / "+ cart_pqty  +" / "+ cart_price);
		
		$.ajax({
			type: "post",
			url: "/shop/cart_insert",
			data: {"cart_pid" : cart_pid, "cart_uid" : cart_uid, "cart_pqty" : cart_pqty,
				"cart_price" : cart_price, "cart_pimage" : cart_pimage, "cart_pname" : cart_pname},
			success: function(){
				if(!confirm("장바구니로 이동")) return;
				location.href="/mycart";
			}
			
		});
		
	});
	
	//댓글 삭제
	function del(){
		//alert("확인");
		
		var prod_rno = $(".prod_rno").val();
		//alert(prod_rno);
		
		if(!confirm("정말로 삭제하시겠습니까")) return;
		
		$.ajax({
			type: "post",
			url: "/shop/pre_delete",
			data: {"prod_rno" : prod_rno},
			success: function(){
				alert("삭제되었습니다");
				getPreview();
			}
		});
	};
	
	//-버튼
	$("#minus").on("click", function(){
		var prod_count = $("#prod_count").val();
		
		//alert(prod_count);
		
		if(prod_count == 1){
			$("#minus").attr("disabled", true);
		}else{
			count--;
			$("#prod_count").val(count);
		}
	});
	
	//+버튼
	$("#plus").on("click", function(){
		var prod_count = $("#prod_count").val();
		var prod_stack_qty = "${vo.prod_stack_qty}";
		
		//alert(prod_stack_qty);
		
		if(prod_count == prod_stack_qty){
			$("#plus").attr("disabled", true);
		}else{
			count++;
			$("#prod_count").val(count);
		}
	});
	
	//슬라이드
	function getSlide(){
		$.ajax({
			type: "get",
			url: "/shop/prod_slide.json",
			dataType: "json",
			success: function(data){
				var temp_slide = Handlebars.compile($("#temp_slide").html());
				$(".slide ul").html(temp_slide(data));
			}
		});
	}
	

	//댓글 등록
	$("#pre_insert").on("click", function(){
		
		var prod_review = $("#pre_review").val();
		var prod_rstar = $(".rating:checked").val() * 20;
		var prod_ruid = "${uid}";
		
		//alert(prod_review);
		//alert(prod_rstar);

		if(prod_review == ""){
			alert("내용을 입력해주세요");
			$("#pre_review").focus();
			return;
		}
		
		if(prod_rstar == NaN){
			alert("별점을 선택해주세요");
			return;
		}
		
		if(!confirm("댓글을 등록하시겠습니까")) return;
		
		$.ajax({
			type: "post",
			url: "/shop/pre_insert",
			data: {"prod_ruid" : prod_ruid, "prod_rstar" : prod_rstar, "prod_review" : prod_review, "prod_rid" : prod_rid},
			success: function(){
				alert("등록되었습니다");
				$("#pre_review").val("");
				getPreview();
			}
		});
		
	});
	
	//댓글 목록
	function getPreview(){
		$.ajax({
			type: "get",
			url: "/shop/pre_list.json",
			data: {"page" : page, "prod_rid" : prod_rid},
			dataType: "json",
			success: function(data){
				var temp = Handlebars.compile($("#temp").html());
				$("#preview").html(temp(data));
				$("#pagination").html(getPagination(data));
				
				$("#total").html("(" + data.pm.totalCount + ")");
				
			}
		});
	}
	
	$("#pagination").on("click", "a", function(e) {
		e.preventDefault();

		page = $(this).attr("href");
		getPreview();
	});
</script>
