<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 모달창 -->
<style>
    #my_modal {
        display: none;
        width: 700px;
        height:450px;
        padding: 20px 60px;
        background-color: #fefefe;
        border: 1px solid #888;
        border-radius: 20px;
    }
    #my_modal .modal_close_btn {
        position: absolute;
        top: 10px;
        right: 10px;
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
#condition {
	position: relative;
	height: 50px;
}

#condition input[type=text] {
	position: absolute;
	left: 0%;
}

.fa-search {
	color: #c2c2c3;
	position: absolute;
	left: 55%;
	top: 15px;
}

.container {
	width: 100%;
	text-align: left;
}

.container h1 {
	text-align: left;
	margin-left: 20px;
	margin-bottom: 20px;
}

ul.tabs {
	margin: 0px;
	padding: 0px;
}

ul.tabs li {
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	border-bottom: 1px solid black;
	color: #222;
}

.tab-content{
	display: none;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}
</style>

<div class="container">
	<div class="subheading">주문내역</div>
	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">상품준비중</li>
		<li class="tab-link" data-tab="tab-2">배송중</li>
		<li class="tab-link" data-tab="tab-3">배송완료</li>
		<li class="tab-link" data-tab="tab-4">구매확정</li>
	</ul>
	<div id="tab-1" class="tab-content current">
		<c:forEach items="${shop_list }" var="shop">
			<c:choose>
			<c:when test="${shop.pay_status == 2}">
				<h3>${shop.f_pay_date}</h3>
				<div class="orderbox">
					<span class="status">상품준비중</span> 
					<input type="hidden" class="hidden_status" value="" />
					<div style="overflow: hidden; margin-top: 10px;">
						<div class="image">
							<img src="/shop/display?file=${shop.cart_pimage}" width="130" height="130" />
						</div>
						<div class="orderinfo">
							<div class="pname">${shop.cart_pname}</div>
							<div class="title">
								<span class="cart_price"></span>|<span class="quantity">${shop.cart_pqty}</span>
							</div>
							<div class="orderId">
								<span>${shop.order_id}</span>
							</div>
							<div class="price">
								<span>${shop.cart_price}</span>
							</div>
						</div>
						<div class="orderBtn">
              <button class="whiteBtn" id="orderCancel">주문취소</button>
						</div>
					</div>
				</div>
			</c:when>
			</c:choose>
		</c:forEach>
	</div>
	<div id="tab-2" class="tab-content">
		<c:forEach items="${shop_list }" var="shop">
			<c:choose>
			<c:when test="${shop.pay_status == 3}">
				<h3>${shop.f_pay_date}</h3>
				<div class="orderbox">
					<span class="status">배송중</span> 
					<input type="hidden" class="hidden_status" value="" />
					<div style="overflow: hidden; margin-top: 10px;">
						<div class="image">
							<img src="/shop/display?file=${shop.cart_pimage}" width="130" height="130" />
						</div>
						<div class="orderinfo">
							<div class="pname">${shop.cart_pname}</div>
							<div class="title">
								<span class="cart_price"></span>|<span class="quantity">${shop.cart_pqty}</span>
							</div>
							<div class="orderId">
								<span>${shop.order_id}</span>
							</div>
							<div class="price">
								<span>${shop.cart_price}</span>
							</div>
						</div>
						<div class="orderBtn">
						</div>
					</div>
				</div>
			</c:when>
			</c:choose>
		</c:forEach>
	</div>
	<div  id="tab-3" class="tab-content">
		<c:forEach items="${shop_list }" var="shop">
			<c:choose>
			<c:when test="${shop.pay_status == 4}">
				<h3>${shop.f_pay_date}</h3>
				<div class="orderbox">
					<span class="status">배송완료</span> 
					<input type="hidden" class="hidden_status" value="" />
					<div style="overflow: hidden; margin-top: 10px;">
						<div class="image">
							<img src="/shop/display?file=${shop.cart_pimage}" width="130" height="130" />
						</div>
						<div class="orderinfo">
							<div class="pname">${shop.cart_pname}</div>
							<div class="title">
								<span class="cart_price"></span>|<span class="quantity">${shop.cart_pqty}</span>
							</div>
							<div class="orderId">
								<span>${shop.order_id}</span>
							</div>
							<div class="price">
								<span>${shop.cart_price}</span>
							</div>
						</div>
						<div class="orderBtn">
							<div>
								<button class="whiteBtn">구매확정</button>
								<input type="hidden" value="${shop.cart_no}" class="cart_no" />
							</div>
						</div>
					</div>
				</div>
			</c:when>
			</c:choose>
		</c:forEach>
	</div>
	<div id="tab-4" class="tab-content">
		<c:forEach items="${shop_list }" var="shop">
			<c:choose>
			<c:when test="${shop.pay_status == 5}">
				<h3>${shop.f_pay_date}</h3>
				<div class="orderbox">
					<span class="status">구매확정</span> 
					<input type="hidden" class="hidden_status" value="" />
					<div style="overflow: hidden; margin-top: 10px;">
						<div class="image">
							<img src="/shop/display?file=${shop.cart_pimage}" width="130" height="130" />
						</div>
						<div class="orderinfo">
							<div class="pname">${shop.cart_pname}</div>
							<div class="title">
								<span class="cart_price"></span>|<span class="quantity">${shop.cart_pqty}</span>
							</div>
							<div class="orderId">
								<span>${shop.order_id}</span>
							</div>
							<div class="price">
								<span>${shop.cart_price}</span>
							</div>
						</div>
						<div class="orderBtn">
							<div>
								<button class="blackBtn">리뷰작성</button>
								<input type="hidden" class="hidden_rid" value="${shop.cart_pid }" />
							</div>
						</div>
				</div>
			</c:when>
			</c:choose>
		</c:forEach>
	</div>
</div>
<!-- 모달창 부분 시작 -->
<div id="my_modal">
	<h2>상품 리뷰 작성하기</h2>
	<div id="scroll_review">
		<div>
			<div id="prod_rstar">
				<input type="radio" value="5" id="rate1" name="rating" class="rating" /><label for="rate1">⭐</label>
				<input type="radio" value="4" id="rate2" name="rating" class="rating" /><label for="rate2">⭐</label>
				<input type="radio" value="3" id="rate3" name="rating" class="rating" /><label for="rate3">⭐</label>
				<input type="radio" value="2" id="rate4" name="rating" class="rating" /><label for="rate4">⭐</label>
				<input type="radio" value="1" id="rate5" name="rating" class="rating" /><label for="rate5">⭐</label>
			</div>
			<div id="pre_rbox">
			<textarea rows="10" cols="40" id="pre_review"
				placeholder="내용을 입력해주세요"></textarea>
			</div>
			<input type="button" id="pre_insert" value="리뷰 등록" />
			<input type="hidden" id="hidden_rid" value="" />
		</div>
	</div>
	<a class="modal_close_btn">닫기</a>
</div>
<!-- 모달창 부분 끝 -->
<script>
price_multiply();

$("#myshop").on("click", ".orderBtn .blackBtn", function(){
	var prod_rid = $(this).parent().find(".pid").val();
	//alert(prod_rid);
	$("#hidden_rid").val(prod_rid);
});

//구매 확정
$("#tab-3").on("click", ".whiteBtn", function(){
	var par = $(this).parent().parent().parent();
	var cart_no = $(this).parent().find(".cart_no").val();
	var order_id = par.find(".orderId span").html();
	
	//alert(cart_no + " / " + order_id);
	
	if(!confirm("구매를 확정하시겠습니까")) return;
	
	$.ajax({
		type: "get",
		url: "/shop/status_update",
		data: {"cart_no" : cart_no, "order_id" : order_id},
		success: function(){
			alert("확인");
		}
	});
});

//rid
$("#tab-4").on("click", ".blackBtn", function(){
	var prod_rid = $(this).parent().find(".hidden_rid").val();
	//alert(prod_rid);
	$("#hidden_rid").val(prod_rid);
});
	
//댓글 등록
$("#pre_insert").on("click", function(){
	var prod_review = $(this).parent().find("#pre_review").val();
	var prod_rstar = $(this).parent().find(".rating:checked").val() * 20;
	var prod_ruid = "${uid}";
	//var prod_rid = $(this).parent().parent().parent().parent().find(".pid").val();
	var prod_rid = $(this).parent().find("#hidden_rid").val();		
	
	//alert(prod_review + " / " + prod_rstar + " / " + prod_rid);

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
			$(".rating").attr("checked", false);
			$("#my_modal").modal("hide");
		}
	});
});

function price_multiply(){
	$(".orderinfo").each(function(){
		var cart_price = $(this).find(".price span").html();
		var cart_quantity = $(this).find(".quantity").html();
		var normalprice = cart_price/cart_quantity;
		
		//alert(normalprice);
		$(this).parent().find(".cart_price").html(normalprice);
		
	});
}

$(document).ready(function(){
	
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	});
});
</script>

<script>
function modal(id) {
    var zIndex = 9999;
    var modal = document.getElementById(id);

    // 모달 div 뒤에 희끄무레한 레이어
    var bg = document.createElement('div');
    bg.setStyle({
        position: 'fixed',
        zIndex: zIndex,
        left: '0px',
        top: '0px',
        width: '100%',
        height: '100%',
        overflow: 'auto',
        // 레이어 색갈은 여기서 바꾸면 됨
        backgroundColor: 'rgba(0,0,0,0.4)'
    });
    document.body.append(bg);

    // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
    modal.querySelector('.modal_close_btn').addEventListener('click', function() {
        bg.remove();
        modal.style.display = 'none';
    });

    modal.setStyle({
        position: 'fixed',
        display: 'block',
        boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

        // 시꺼먼 레이어 보다 한칸 위에 보이기
        zIndex: zIndex + 1,

        // div center 정렬
        top: '50%',
        left: '50%',
        transform: 'translate(-50%, -50%)',
        msTransform: 'translate(-50%, -50%)',
        webkitTransform: 'translate(-50%, -50%)'
    });
}

// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
Element.prototype.setStyle = function(styles) {
    for (var k in styles) this.style[k] = styles[k];
    return this;
};



$('#tab-4').on('click', ".blackBtn", function() {
    // 모달창 띄우기
    modal('my_modal');
});
</script>
<script>
	$('#orderCancel').on('click',function(){
		if(!confirm('주문을 취소하시겠습니까?')) return;
		
		$.ajax({
			type:'post',
			url: '/shop/orderCancel',
			data:{"pay_no":115},
			success:function(){
				alert('주문이 취소되었습니다.');
			}
		})
	});
</script>