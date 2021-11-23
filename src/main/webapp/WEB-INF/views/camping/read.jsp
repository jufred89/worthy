<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<style>
#campBody {
	width: 1500px;
	margin: 0px auto;
	padding:30px;
}

#campingReadBox1 {
	width: 1500px;
	margin: 10px auto;
	padding: 10px;
	overflow: hidden;
}

#campingReadBox1 h1 {
	font-weight: bold;
	text-align: left;
}
h1{font-size:30px;}
h2{font-size:20px;}
h3{font-size:18px;}
h4{font-size:17px;}
h5{font-size:15px;}
#campMainImage {
	width: 700px;
	height: 570px;
	float: left;
}

.campImage {
	width: 385px;
	height: 290px;
	float: left;
}

.image-thumbnail {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 25px;
}

.image-thumbnail2 {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 25px;
}

#campInformationBox {
	width: 70%;
	margin: 0px auto;
	padding: 20px;
	float: left;
}

#campInformationBox h2 {
	text-align: left;
	font-weight: bold;
}

#campInformationBox h4 {
	text-align: left;
	padding: 10px;
	line-height: 160%
}

#campingStyleRead {
	margin: 0px auto;
	padding: 20px;
}

#campingFacilityRead {
	padding: 20px;
	height:300px;
}

#campingStyleRead h2 {
	text-align: left;
	font-weight: bold;
}

#campingFacilityRead h2 {
	text-align: left;
	font-weight: bold;
}

#campSubBox {
	overflow: hidden;
}

#reserve_box {
	border: 1px solid rgb(230, 230, 230);
	float: right;
	width: 25%;
	height: 53%;
	padding: 50px;
	border-radius: 30px;
	background: rgb(242, 242, 242);
	margin:30px;
}

#reserve_box span {
	font-size: 20px;
	font-weight: bold;
	text-align: left;
	display: block;
}
#reserve_box h4, #reserve_box input[type=radio] {
	font-size: 18px;
	font-weight: normal;
	text-align: left;
	margin-bottom: 40px;
	margin-left:10px;
}

#reserve_box button {
	width: 210px;
	background: black;
	color: white;
	font-size: 18px;
	margin-top: 50px;
	padding: 10px;
	border-radius: 20px;
	box-shadow: 5px 5px 5px gray;
}

#available_reser {
	font-size: 18px;
	text-align: left;
}

#available_reser div {
	padding: 10px 0px 10px 0px;
}

#available_reser input[type=radio] {
	width:15px;
	height:15px;
	margin: 5px;
}
#mapBox{
	margin-bottom:40px;
}
#mapBox h2 {
	text-align: left;
	font-weight: bold;
	padding: 20px;
}
#pageLike{
	text-align: right;
	margin-right: 30px;
	margin-bottom:10px;
	cursor: pointer;
}
#campingReviews{
	overflow: hidden;
}
#campingReviews h2{
	text-align: left;
	font-weight: bold;
	padding: 20px;
}
.campingReviewer{
	float: left;
	width: 33%;
	height: 150px;
	padding: 10px;
	overflow: hidden;
	background: rgb(242, 242, 242);
}
.campingReviewerImage{
	float: left;
	margin: 10px;
}
.campingReviewerImage img{
	border-radius:35px;
	border: 3px solid black;
}
.campingReviewTop{
	float: left;
	text-align: left;
	padding: 5px;
}
.campingReviewBottom{
	clear: left;
	text-align: left;
	padding: 5px;
}
.camp_ruid{
	font-size: 20px;
	margin: 10px;
}
.main_common{
	padding:8px;
    display: inline-block;
    width: 100px;
    height: 100px;
    border: 1px solid gray;
    border-radius:5px;
    margin: 2px;
    float: left;
}
.main_common2{
}
#facilityList{
	width: 1000px;
    background: yellow;
}
#styleList{
	width: 1000px;
}
</style>


<!-- 캠핑장 정보 부분 -->
<div id="campBody">
	<div id="campingReadBox1">
		<div>
			<h1>${cvo.camp_name}</h1>
			<h3 id="from_addr">${cvo.camp_addr}</h3>
			<div id="pageLike">
				<c:if test="${likeCheck==0 }">
					<img src="/resources/heart.png" title="좋아요" width=40 id="bntLike" />
				</c:if>
				<c:if test="${likeCheck!=0 }">
					<img src="/resources/heart_colored.png" title="좋아요취소" width=40
						id="bntLike" />
				</c:if>
			</div>
		</div>
		<div id="campMainImage">
			<img class="image-thumbnail"
				src="/camping/display?file=${cvo.camp_image}" />
		</div>
		<div id="campSubImages">
			<c:forEach items="${attList}" var="camp_image">
				<div class="campImage">
					<img class="image-thumbnail2"
						src="/camping/display?file=${camp_image}" width=250
						style="padding: 10px;" />
				</div>
			</c:forEach>
		</div>
	</div>
	<div id="campSubBox">
		<div id="campInformationBox">
			<div>
				<h2>캠핑장내 기타 편의사항</h2>
				<h4>${cvo.camp_memo}</h4>
			</div>
			<div>
				<h2>캠핑장에 관해서</h2>
				<h4>${cvo.camp_detail}</h4>
			</div>
		</div>
		<div id="reserve_box">
			<span>체크인</span>
			<h4>${reser_checkin}</h4>
			<span>체크아웃</span>
			<h4>${reser_checkout}</h4>
			<span>기간</span>
			<div id="cal_daytrip"></div>
			<!-- 해당 캠핑장의 예약된 객실을 제외한 예약 가능한 객실 목록 -->
			<span>예약가능한객실</span>
			<div id="available_reser">
				<c:forEach items="${reserList}" var="rvo">
					<c:if test="${rvo.style_qty-rvo.reser_count eq 0}">
						<div>
							<input type="radio" name="camp_style_list"
								value="${rvo.style_no}" price="${rvo.style_price}" disabled
								dir="ltr" />${rvo.style_name}|${rvo.style_qty-rvo.reser_count}개|${rvo.style_price}
						</div>
					</c:if>
					<c:if test="${rvo.style_qty-rvo.reser_count ne 0}">
						<div>
							<input type="radio" name="camp_style_list"
								value="${rvo.style_no}" price="${rvo.style_price}" dir="ltr" />${rvo.style_name}|${rvo.style_qty-rvo.reser_count}개|${rvo.style_price}
						</div>
					</c:if>
				</c:forEach>
			</div>
			<!-- 예약페이지로 넘어가기 -->
			<button onclick="reservePage()">예약하기</button>
		</div>
		<div id="campInformationBox2">
			<!-- 캠핑장 스타일 목록 -->
			<div id="campingStyleRead">
				<h2>캠핑장 스타일</h2>
				<div id="styleList">
					<c:forEach items="${styleList}" var="svo">
					<c:if test="${svo.style_name=='카라반'}">
						<div class="main_common2">
							<img src="/resources/kind/글램핑시설.png" width=70px/>
							<h4>${svo.style_name}|${svo.style_qty}개|${svo.style_price}원</h4>
						</div>
					</c:if>
					<c:if test="${svo.style_name=='일반야영장'}">
						<div class="main_common2">
							<img src="/resources/kind/일반야영장.png" width=70px/>
							<h4>${svo.style_name}|${svo.style_qty}개|${svo.style_price}원</h4>
						</div>
					</c:if>
					<c:if test="${svo.style_name=='자동차야영장'}">
						<div class="main_common2">
							<img src="/resources/kind/오토캠핑.png" width=70px/>
							<h4>${svo.style_name}|${svo.style_qty}개|${svo.style_price}원</h4>
						</div>
					</c:if>
					</c:forEach>
				</div>
			</div>
			<!-- 시설 목록 부분 -->
			<div id="campingFacilityRead">
				<h2>캠핑장 시설</h2>
				<div id="facilityList">
					<c:forEach items="${facilityList}" var="fvo">
					<c:if test="${fvo.facility_name=='전기'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/전기.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='운동시설'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/운동시설.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='마트'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/마트.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='편의점'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/편의점.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='화장실'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/화장실.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='샤워시설'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/샤워시설.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='개수대'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/개수대.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='무선인터넷'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/무선인터넷.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='장작판매'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/장작판매.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='온수'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/온수.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='트렘폴린'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/트렘폴린.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='물놀이장'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/물놀이장.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='놀이터'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/놀이터.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='산책로'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/산책로.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					<c:if test="${fvo.facility_name=='운동장'}">
						<div class="main_common">
							<img src="/resources/kind_comporable/운동장.png" width=50px/>
							<h4>${fvo.facility_name}</h4>
						</div>
					</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<div id="campingReviews">
		<h2>캠핑장 리뷰</h2>
		<c:forEach items="${campReviewList}" var="crlvo">
		<div class="campingReviewer">
			<div class="campingReviewerImage">
				<img src="/resources/person.png" width=70 height=70 />
			</div>
			<div class="campingReviewTop">
				<div class="camp_ruid">${crlvo.camp_ruid}</div>
				<div class="camp_reviewdate">${crlvo.camp_reviewdate_f}</div>
			</div>
			<div class="campingReviewBottom">
				<div>${crlvo.camp_review}</div>
			</div>
		</div>
		</c:forEach>
	</div>
	<!-- 주소 기반 지도 -->
	<div id="mapBox">
		<h2>캠핑장 위치</h2>
		<div id="map" style="width: 100%; height: 400px; z-index: -1;"></div>
	</div>
</div>
<script>
	var camp_id = '${cvo.camp_id}';
	var reser_checkin = '${reser_checkin}';
	var reser_checkout = '${reser_checkout}';
	caldaytrip();
	// 몇 박 몇일인지 계산하기
	function caldaytrip() {
		var start_date = new Date(reser_checkin);
		var end_date = new Date(reser_checkout);
		var cal_daytrip = (end_date - start_date) / (1000 * 60 * 60 * 24);
		$("#cal_daytrip").html("<h4>" + cal_daytrip + "박" + "</h4>");
	}
	// 예약가능한 갯수와 예약된 갯수 연산 레지스터헬퍼
	Handlebars.registerHelper("availablereser",
			function(style_qty, reser_count) {
				if (reser_count == null) {
					return style_qty
				} else {
					return style_qty - reser_count
				}
			});
	// 예약페이지로 이동
	function reservePage() {
		var style_no = $("input[name='camp_style_list']:checked").val();
		var style_price = $("input[name='camp_style_list']:checked").attr(
				"price");
		if (style_no == null) {
			alert("스타일을 선택해주세요.")
			return;
		}
		location.href = "/camping/checkout?camp_id=" + camp_id + "&style_no="
				+ style_no + "&style_price=" + style_price + "&reser_checkin="
				+ reser_checkin + "&reser_checkout=" + reser_checkout
	}
</script>
<!-- 캠핑 졸아요 버튼 클릭시 -->
<script>
//좋아요 버튼 클릭한 경우
$('#pageLike').on('click',function(){
	var likeCheck = "${likeCheck}";
	alert(uid)
	alert(camp_id)
	alert(reser_checkin)
	alert(reser_checkout)
	alert(likeCheck)
	$.ajax({
		type:'post',
		url:'/camping/like',
		data:{"likeCheck":likeCheck,"uid":uid,"camp_id":camp_id},
		success: function(){
			location.href="/camping/read?camp_id="+camp_id+"&reser_checkin="+reser_checkin+"&reser_checkout="+reser_checkout;
		}
	});
});
</script>
<!-- 주소로 좌표값 가져오기 T맵 좌표값이 달라서 주소로 다음지도로 좌표값 불러오기 -->
<!-- 다음 지도 API .js -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=437cd2932e9baa6f039994ed90c57549&libraries=services"></script>
<script>
	var camping_addr = "${cvo.camp_addr}"
	var camping_name = "${cvo.camp_name}"
	if (camping_addr != null) {
		console.log(camping_addr);
		var mapContainer = document.getElementById('map') // 지도를 표시할 div 
		var mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder
				.addressSearch(
						camping_addr,
						function(result, status) {

							// 정상적으로 검색이 완료됐으면 
							if (status === kakao.maps.services.Status.OK) {
								var coords = new kakao.maps.LatLng(result[0].y,
										result[0].x);

								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new kakao.maps.Marker({
									map : map,
									position : coords
								});

								var iwContent = '<div style="width:250px;text-align:center;padding:2px 0;">'
								iwContent += '<h4 style="font-weight:bold">'
										+ camping_name + '</h4>' + '<hr/>'
								iwContent += '<h5>' + camping_addr + '</h4>'
								iwContent += '</div>'
								iwRemoveable = true

								// 인포윈도우로 장소에 대한 설명을 표시합니다
								var infowindow = new kakao.maps.InfoWindow({
									content : iwContent,
									removable : iwRemoveable
								});

								// 마커에 클릭이벤트를 등록합니다
								kakao.maps.event.addListener(marker, 'click',
										function() {
											// 마커 위에 인포윈도우를 표시합니다
											infowindow.open(map, marker);
										});

								// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								map.setCenter(coords);
							}
						});
	}
</script>