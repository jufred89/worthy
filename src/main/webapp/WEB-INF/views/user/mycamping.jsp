<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 별점 출력 -->
<style>
.star-rating {
	width: 51px;
}
.star-rating, .star-rating span {
	display: inline-block;
	height: 10px;
	overflow: hidden;
	background: url(/resources/star.png) no-repeat;
}
.star-rating span {
	background-position: left bottom;
	line-height: 0;
	vertical-align: top;
}
.star_color {
	color: red;
}
</style>
<!-- 별점 리뷰 등록 / 이동예정 -->
<style>
#camp_rstar input[type=radio] {
	display: none; /* 라디오박스 감춤 */
}

#camp_rstar label {
	font-size: 3em; /* 이모지 크기 */
	color: transparent; /* 기존 이모지 컬러 제거 */
	text-shadow: 0 0 0 #f0f0f0; /* 새 이모지 색상 부여 */
}

#camp_rstar label:hover {
	text-shadow: 0 0 0 DeepPink; /* 마우스 호버 */
}

#camp_rstar label:hover ~ label {
	text-shadow: 0 0 0 DeepPink; /* 마우스 호버 뒤에오는 이모지들 */
}

#camp_rstar {
	display: inline-block; /* 하위 별점 이미지들이 있는 영역만 자리를 차지함.*/
	direction: rtl; /* 이모지 순서 반전 */
	border: 0; /* 필드셋 테두리 제거 */
	text-align: left;
}
#camp_rstar input[type=radio]:checked ~ label {
	text-shadow: 0 0 0 DeepPink; /* 마우스 클릭 체크 */
}
#camp_rbox textarea{
	padding: 10px;
}
</style>
<style>
.slide {
	width: 1000px;
	margin: 0 auto;
}

* {
	margin: 0;
	padding: 0;
}

ul, li {
	list-style: none;
}

.slide {
	height: 300px;
	overflow: hidden;
}

.slide ul {
	width: calc(35% * 7);
	display: flex;
	animation: slide 13s infinite;
} /* slide를 8초동안 진행하며 무한반복 함 */
.slide li {
	width: calc(72%/ 7);
	height: 300px;
}

@
keyframes slide { 0% {
	margin-left: 0;
} /* 0 ~ 10  : 정지 */
20%
{
margin-left
:
0;
} /* 10 ~ 25 : 변이 */
50%
{
margin-left
:
-100%;
} /* 25 ~ 35 : 정지 */
70%
{
margin-left
:
-100%;
} /* 35 ~ 50 : 변이 */
100%
{
margin-left
:
0%;
}
}
#campReviewInsert{
	width: 200px;
	background: rgb(255,20,147);
	color: white;
	font-size: 15px;
	margin-top: 10px;
	padding: 10px;
	border-radius: 10px;
	border:none;
}
</style>
<!-- 모달창 스타일 -->
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
<style>
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

ul.tabs li.current {
	color: #222;
	border-bottom: 1px solid black;
}

.tab-content {
	display: none;
	padding: 15px;
	border-top: 1px solid gray;
}

.tab-content.current {
	display: inherit;
}

.subcontent {
	padding: 10px;
	overflow: hidden;
	box-shadow: 3px 3px 3px 3px gray;
}

.subcontent .campReservMain {
	float: left;
}

.subcontent .campReservImage {
	float: left;
}
.campReservImage{
	width:350px;
	height:350px;
}

.campReservImage img {
	border-radius: 25px;
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 25px;
}
.campReservMain{
	margin-left: 20px;
}
.campReservMain div{
	margin: 15px 0px 15px 0px;
}
.price{
	margin-top: 50px;
}
.campDetail{
	float:right;
}
</style>
<div class="container">
	<h1>여행</h1>
	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">예정된 예약</li>
		<li class="tab-link" data-tab="tab-2">이전 예약</li>
		<li class="tab-link" data-tab="tab-3">취소됨</li>
	</ul>
	<div id="tab-1" class="tab-content current">
		<c:forEach items="${campReserList}" var="crvo">
			<c:choose>
				<c:when test="${crvo.reser_checkin >= now}">
					<div class="subheading">예정된 예약</div>
					<div class="subcontent">
						<div class="campReservImage">
							<img src="/camping/display?file=${crvo.camp_image}"/>
						</div>
						<div class="campReservMain">
							<div>
								<h3>${crvo.camp_name}/${crvo.camp_room_no}</h3>
							</div>
							<div>
								<h4 style="font-weight: bold;">캠핑장 위치</h4>
								<h4>${crvo.camp_addr}</h4>
							</div>
							<div>
								<h4 style="font-weight: bold;">체크인</h4>
								<h4>${crvo.reser_checkin} 오후 2시</h4>
							</div>
							<div>
								<h4 style="font-weight: bold;">체크아웃</h4>
								<h4>${crvo.reser_checkout} 오전 11시</h4>
							</div>
							<div class="price">
								<h4 style="font-weight: bold;">결제금액</h4>
								<h3>${crvo.reser_price}원</h3>
							</div>
							<div id="campDetail">
								<button onClick="location.href='/camping/read?camp_id=${crvo.camp_id}'">캠핑장 자세히 보기</button>
							</div>
						</div>
					</div>
					<hr />
				</c:when>
			</c:choose>
		</c:forEach>
	</div>
	<div id="tab-2" class="tab-content">
		<c:forEach items="${campReserList}" var="crvo">
			<c:choose>
				<c:when test="${crvo.reser_checkin <= now}">
					<div class="subheading">이전 예약</div>
					<div class="subcontent">
						<div class="campReservImage">
							<img src="/camping/display?file=${crvo.camp_image}"/>
						</div>
						<div class="campReservMain">
							<div>
								<h3>${crvo.camp_name}/${crvo.camp_room_no}</h3>
							</div>
							<div>
								<h4 style="font-weight: bold;">캠핑장 위치</h4>
								<h4>${crvo.camp_addr}</h4>
							</div>
							<div>
								<h4 style="font-weight: bold;">체크인</h4>
								<h4>${crvo.reser_checkin} 오후 2시</h4>
							</div>
							<div>
								<h4 style="font-weight: bold;">체크아웃</h4>
								<h4>${crvo.reser_checkout} 오전 11시</h4>
							</div>
							<div class="price">
								<h4 style="font-weight: bold;">결제금액</h4>
								<h3>${crvo.reser_price}원</h3>
							</div>
							<div id="campDetail">
								<div id="reser_no" style="display:none">${crvo.reser_no}</div>
								<div id="camp_id" style="display:none">${crvo.camp_id}</div>
								<button id="popup_open_btn">캠핑장 리뷰 작성하기</button>
							</div>
						</div>
					</div>
				</c:when>
			</c:choose>
		</c:forEach>
	</div>
	<div id="tab-3" class="tab-content">
		<c:forEach items="${campReserList}" var="crvo">
			<c:choose>
				<c:when test="${crvo.reser_checkin > now}">
					<div class="subheading">취소됨</div>
					<div class="subcontent">
						<div class="campReservImage">
							<img src="/camping/display?file=${crvo.camp_image}"/>
						</div>
						<div class="campReservMain">
							<div>
								<h3>${crvo.camp_name}/${crvo.camp_room_no}</h3>
							</div>
							<div>
								<h4 style="font-weight: bold;">캠핑장 위치</h4>
								<h4>${crvo.camp_addr}</h4>
							</div>
							<div>
								<h4 style="font-weight: bold;">체크인</h4>
								<h4>${crvo.reser_checkin} 오후 2시</h4>
							</div>
							<div>
								<h4 style="font-weight: bold;">체크아웃</h4>
								<h4>${crvo.reser_checkout} 오전 11시</h4>
							</div>
							<div class="price">
								<h4 style="font-weight: bold;">결제금액</h4>
								<h3>${crvo.reser_price}원</h3>
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
	<h2>캠핑장 리뷰 작성하기</h2>
	<div id="scroll_review">
		<div>
			<div id="camp_rstar">
				<input type="radio" value="5" id="rate1" name="rating"
					class="rating" /><label for="rate1">⭐</label> <input type="radio"
					value="4" id="rate2" name="rating" class="rating" /><label
					for="rate2">⭐</label> <input type="radio" value="3" id="rate3"
					name="rating" class="rating" /><label for="rate3">⭐</label> <input
					type="radio" value="2" id="rate4" name="rating" class="rating" /><label
					for="rate4">⭐</label> <input type="radio" value="1" id="rate5"
					name="rating" class="rating" /><label for="rate5">⭐</label>
			</div>
			<div id="camp_rbox">
			<textarea rows="10" cols="40" id="camp_review"
				placeholder="내용을 입력해주세요"></textarea>
			</div>
			<input type="button" id="campReviewInsert" value="리뷰 등록" />
		</div>
	</div>
	<a class="modal_close_btn">닫기</a>
</div>
<!-- 모달창 부분 끝 -->
<script>
	$(document).ready(function() {

		$('ul.tabs li').click(function() {
			var tab_id = $(this).attr('data-tab');

			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');

			$(this).addClass('current');
			$("#" + tab_id).addClass('current');
		})

	})
</script>
<!-- 캠핑장 별점리뷰 스크립트 -->
<script>
	//댓글 등록
	$("#campReviewInsert").on("click", function() {
		var camp_review = $("#camp_review").val();
		var camp_rstar = $(".rating:checked").val() * 20;
		var camp_ruid = "${uid}";
		var reser_no=$("#reser_no").html();
		var camp_id=$("#camp_id").html();
		if (camp_review == "") {
			alert("내용을 입력해주세요");
			$("#camp_review").focus();
			return;
		}
		if (camp_rstar == NaN) {
			alert("별점을 선택해주세요");
			return;
		}
		if (!confirm("댓글을 등록하시겠습니까"))
			return;
		$.ajax({
			type : "post",
			url : "/camping/campReviewInsert",
			data : {
				"camp_review" : camp_review,
				"camp_rstar" : camp_rstar,
				"camp_ruid" : camp_ruid,
				"reser_no" : reser_no,
				"camp_id" : camp_id
			},
			success : function() {
				alert("등록되었습니다");
		        bg.remove();
		        modal.style.display = 'none';
			}
		});
	});
</script>
<!-- 리뷰 모달창 -->
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

document.getElementById('popup_open_btn').addEventListener('click', function() {
    // 모달창 띄우기
    modal('my_modal');
});
</script>