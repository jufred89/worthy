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
	#prod_dis{
	flex-flow:row wrap;
	display:flex;
	justify-content:center;
	align-content:center;
	}
	#prod_dis table tr td:nth-child(1){
	border:1px solid gray;
	padding:10px;
	width:400px;
	}
	#prod_dis table tr td:nth-child(2){
	border:1px solid gray;
	padding:10px;
	width:700px;
	}
	#prod_count{
	text-align:center;
	line-height: normal;
	width:100px;
	}

	.re_btn{
	display: flex;
	justify-content:end;
	}
	.re_btn button{
	margin:5px;
	background:black;
	color:white;
	width:50px;
	height:25px;
	}
</style>

<!-- 별점 리뷰 등록 / 이동예정 -->
<style>
#prod_header{
margin-bottom:20px;
display:flex;
justify-content:center;
align-content:center;
}
#prod_info{
margin-left:60px;
display:flex;

flex-flow:row wrap;
}
#prod_info p,#prod_info div{
width:100%;
font-size:25px;

}
#howmany{
text-align:left;
margin-bottom: 10px;
}
#prod_btn{
text-align:left;
margin-bottom: 10px;

}
#howmany button{
width:20px;
}
#howmany button:hover{

color:white;
background: black;
}
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
	#dis_table{
	display:flex;
justify-content:center;
align-content:center;
margin:10px;
	}
		.prod_rstar{
	    display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
	    border: 0; /* 필드셋 테두리 제거 */
	}
	.prod_rstar input[type=radio]{
	    display: none; /* 라디오박스 감춤 */
	}
	.prod_rstar label{
	   
	    color: transparent; /* 기존 이모지 컬러 제거 */
	    text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
	}
	.prod_rstar input[type=radio]:checked ~ label{
    	text-shadow: 0 0 0 DeepPink; /* 마우스 클릭 체크 */
	}
</style>
 <style>
 	.slide{
 		width: 1000px;
 		margin:0 auto;
 	}
    *{margin:0;padding:0;}
    ul,li{list-style:none;}
    .slide{height:300px;overflow:hidden;} 
    .slide ul{width:calc(35% * 7);display:flex;animation:slide 13s infinite;} /* slide를 8초동안 진행하며 무한반복 함 */
    .slide li{width:calc(72% / 7);height:300px;}
    @keyframes slide {
      0% {margin-left:0;} /* 0 ~ 10  : 정지 */
      20% {margin-left:0;} /* 10 ~ 25 : 변이 */
      50% {margin-left:-100%;} /* 25 ~ 35 : 정지 */
      70% {margin-left:-100%;} /* 35 ~ 50 : 변이 */
      100% {margin-left:0%;}
    }
  </style>


<div id="prod_read" style="margin:0 auto;width:1000px;">

<!-- 상단 썸네일 / 설명 -->

<div id="prod_header">
	<img src="/shop/display?file=${vo.prod_image}" width=500 height=500/>
	<div id="prod_info">
		<h2 style="font-size: 25px;font-weight:100px;"><b>${vo.prod_name}</b></h2>
		<p>${vo.prod_normalprice }￦</p>
		<p>무료배송</p>
		<p>판매자: </p>
		<p style="font-size: 12px;"><i class="fa fa-star" aria-hidden="true"></i>판매자가 현금거래를 요구하면 거부하시고 즉시 사기 거래 신고센터에 신고하시기 바랍니다.</p>
		
		<c:if test="${vo.prod_stack_qty == 0 }">
			<div>품절</div>
		</c:if>
		<c:if test="${vo.prod_stack_qty >= 1 }">
			<div id="howmany">
				<button id="minus">-</button>
				<input type="text" id="prod_count" value="1" />
				<button id="plus">+</button>
			</div>
			<div id="prod_btn">
				<button id="cart">장바구니</button>
			
			</div>
		</c:if>
	</div>
</div>

<!-- 슬라이드 -->
<div style="margin-top:80px;">
	<div class="slide">
		<ul width=1000>
			
		</ul>
	</div>
	<script id="temp_slide" type="text/x-handlebars-template">

		{{#each slide}}
				<li>
					<div style="width:230">
					<img src="/shop/display?file={{prod_image}}" width="230" onClick="location.href='/shop/read?prod_id={{prod_id}}'" />
					</div>
					<div class="prod_name">{{prod_name}}</div>
					<div class="prod_nomalprice">{{prod_normalprice}}</div>
				</li>
		{{/each}}
	</script>
</div>

<!-- 메뉴 -->
<!-- <div>
	<div onclick="scrollMove('info')">상세정보</div>
	<div onclick="scrollMove('review')">리뷰</div>
</div> -->

<script>
	function scrollMove(num){
		 var offset = $("#scroll_" + num).offset();
	     $('html, body').animate({scrollTop : offset.top}, 400);
	}
</script>

<%-- <!-- 상세 설명 -->
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
</div> --%>

<!-- 상품 상세 이미지 -->
<div id="scroll_info">
	<img src="/shop/display?file=${avo.shop_ano}" width=1000/>
</div> 
<hr>
<div id="prod_dis" >
<h2>상품상세설명</h2>
<div id="dis_table" style="width:100%;">
	<table >
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
	</div>
	<p>*해당 인증 정보는 판매자가 등록한 것으로 등록 정보에 대한 일체의 책임은 판매자에게 있습니다.</p>
</div>
<hr>
<!-- 리뷰 등록 이동 예정 -->
<h1>Review</h1>
<hr>

<div id="prod_review"></div>
<script id="temp_review" type="text/x-handlebars-template">
{{#each list}}
<div class="re_box">
<input class="rno" type="hidden" value="{{prod_rno}}"/>
<input class="ruid" type="hidden" value="{{prod_ruid}}"/>
<div class="rno" style="display:flex; width:100%;"><span class="prod_rno"  style="font-size:18px;">{{prod_rno}}:</span>
 <div class="prev_ruid" style="font-size:18px;">{{prod_ruid}}<span>님</span></div>
 <div class="prod_rstar1">{{prod_rstar}}점</div>

  <div>{{rstar_checked prod_rstar}}</div>
</div>
<div class="prod_review" style="text-align:left;margin-top:20px;font-size:16px;">{{prod_review}}</div>


<p class="prod_review" style="text-align:left;margin-top:20px;font-size:16px;">{{prod_r_regdate_f}}</p>


<div class="re_btn btnDelete"  prod_rno={{prod_rno}} style="text-align:right;" onClick="del2()"><button>삭제</button></div>
</div>

<hr style="border:0.5px dotted gray;">

{{/each}}
</script>
 <script>
        
         Handlebars.registerHelper("rstar_checked", function(prod_rstar) {
        	if(prod_rstar==0){
        		return ""
        	}else if(prod_rstar==20){
        		return "★"
        	}
        	else if(prod_rstar==40){
        		return "★★"
        	}
        	else if(prod_rstar==60){
        		return "★★★"
        	}
        	else if(prod_rstar==80){
        		return "★★★★"
        	}
        	else {
        		return "★★★★★"
        	}
         });
        
      </script> 
<div id="pagination"></div>
<script src="/resources/pagination.js"></script>
<div>
	<button id="upBtn">위로</button>
</div>
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
	  var uid = "${uid}";
	
	getPreview();
	getSlide();

	pre_list()
	
	$('#prod_review').on('click','.re_box .btnDelete',function(){
		var prod_rno=$(this).parent().find('.rno').val()
		var prod_ruid=$(this).parent().find('.ruid').val()
		var re_box=$(this).parent().parent().find('re_box')
			  var uid = "${uid}";
		
		if(prod_ruid!=uid){
			alert('댓글을 삭제할 수 없습니다!')
			return;
		}
		if(!confirm('댓글을 삭제하실래요?'))return;
		$.ajax({
			type : "post",
			url : "/shop/pre_delete",
			data:{"prod_rno":prod_rno},
		
			success : function() {
			 
				alert('삭제완료되었습니다!')
				pre_list()
			}
		});
	})

	
	//리뷰리스트
	function pre_list(){
var perPageNum=10;
		$.ajax({
			type : "get",
			url : "/shop/pre_list.json",
			dataType : "json",
			data:{"page":page,"prod_rid":prod_rid, "perPageNum":10},
			success : function(data) {
				$("#pagination").html(getPagination(data));
			
				var temp = Handlebars.compile($("#temp_review").html());
				$("#prod_review").html(temp(data));
			
			}
		});
	}
	//별점 평균
	function average(){
		var star_sum = 0;
		var total = $("#total").html();
		//alert(total);
		$("#preview .item .hidden_star").each(function(){
			var star = $(this).val();
			
			star_sum += Number(star);
		});
		var avg_sum = star_sum/total;
		//alert(avg_sum);
		$("#avg_star").css("width", avg_sum + "%");
		$("#avg_num").html((avg_sum/20).toFixed(1) + "점");
	}
	
	//장바구니 담기
	$("#cart").on("click", function(){
		var cart_pid = "${vo.prod_id}";
		var cart_uid = "${uid}";
		var cart_pqty = $("#prod_count").val();
		var normalprice = "${vo.prod_normalprice}";
		var cart_price = normalprice * cart_pqty;
		var cart_pimage = "${vo.prod_image}";
		var cart_pname = "${vo.prod_name}";
		
		alert(cart_pid +" / "+ cart_uid +" / "+ cart_pqty  +" / "+ cart_price);
		
		$.ajax({
			type: "post",
			url: "/shop/cart_insert",
			data: {"cart_pid" : cart_pid, "cart_uid" : cart_uid, "cart_pqty" : cart_pqty,
				"cart_price" : cart_price, "cart_pimage" : cart_pimage, "cart_pname" : cart_pname, "cart_status" : 1},
			success: function(){
				if(!confirm("장바구니로 이동")) return;
				location.href="/mycart";
			}
			
		});
		
	});
	
	//댓글 삭제
	
	
	$("#prod_review").on("click", ".item .del", function(){
		var prod_rno = $(this).parent().find(".prod_rno").val();
		//alert(prod_rno);

		$.ajax({
			type: "post",
			url: "/shop/pre_delete",
			data: {"prod_rno" : prod_rno},
			success: function(){
				alert("삭제되었습니다");
				getPreview();
			}
		});
	});
	
	//-버튼
	$("#minus").on("click", function(){
		var prod_count = $("#prod_count").val();
		
		//alert(prod_count);
		
		if(prod_count == 1){
			$("#minus").attr("disabled", true);
			alert('수량은 1개 이상 입력해주세요');
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
	//특정 페이지 번호를 클릭한 경우
	$("#pagination").on("click", "a", function(e){
		e.preventDefault();
		page = $(this).attr("href");
		pre_list()
	});
	
	//댓글 목록
	function getPreview(){
		$.ajax({
			type: "get",
			url: "/shop/pre_list.json",
			data: {"page" : page, "prod_rid" : prod_rid},
			dataType: "json",
			success: function(data){
				var temp = Handlebars.compile($("#temp_review").html());
				$("#prod_review").html(temp(data));
				$("#pagination").html(getPagination(data));
				
				$("#total").html(data.pm.totalCount);
				average();
			}
		});
	}
	
	$("#pagination").on("click", "a", function(e) {
		e.preventDefault();

		page = $(this).attr("href");
		getPreview();
	});
</script>
