<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<h1>캠핑장을 찾아보세요.</h1>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script src="/resources/pagination.js"></script>
<style>
	#campList{
		width:1600px;
		margin: 0px auto;
		overflow: hidden;
	}
	.camp_box{
		height: 450px;
		width: 400px;
		float: left;
		margin-bottom: 10px;
	}
	.camp_box:hover{
		cursor:pointer;
	}
	.image-box {
	    width:350px;
	    height:350px;
	    overflow:hidden;
	    margin:0 auto;
	    border-radius:25px;
	}
	.image-thumbnail {
	    width:100%;
	    height:100%;
	    object-fit:cover;
	}
	.cname-box{
		font-size: 20px;
		font-weight: bold;
	}
	.caddr-box{
		font-size: 15px;
	}
	.cprice-box{
		font-size: 15px;
	}
</style>
<div>
	<c:if test="${camp_addr eq null}">
	<h3>전국에서 ${reser_checkin }에서 ${reser_checkout }까지 예약 가능한 숙소입니다.</h3>
	</c:if>
	<c:if test="${camp_addr ne null}">
	<h3>${camp_addr }에서 ${reser_checkin }에서 ${reser_checkout }까지 예약 가능한 숙소입니다.</h3>
	</c:if>
</div>
<div>
	<h4>캠핑장 스타일</h4>
	<c:forEach items="${styleList}" var="item_style">
		<input type="radio" name="style_no" value="${item_style.style_no}" />${item_style.style_name}
	</c:forEach>
</div>
<div>
	<h4>캠핑장 시설</h4>
	<c:forEach items="${facilityList}" var="item_facility">
	<c:if test="${item_facility.facility_no ne 0}">
	<input onclick="CountChecked(this)" type="checkbox" name="facility_no" value="${item_facility.facility_no}">${item_facility.facility_name}
	</c:if>
	</c:forEach>
</div>
<button id="detail_search">상세 검색하기</button>
<hr />
<div id="campList"></div>
<script id="temp" type="text/x-handlebars-template">
		{{#each .}}
		<div class="camp_box" camp_id={{camp_id}}>
			<div class="image-box"><img class="image-thumbnail" src="/camping/display?file={{camp_image}}"/></div>
			<div class="cname-box">{{camp_name}}</div>
			<div class="caddr-box">{{camp_addr}}</div>
			<div class="ctqty-box">예약가능 사이트 {{nulltozero camp_tqty reserve_cnt}}개</div>
			<div class="cprice-box">₩ {{camp_minprice}} ~ {{camp_maxprice}} 원 / 박</div>
		</div>
		{{/each}}
</script>
<script>
	var camp_addr = '${camp_addr}';
	var reser_checkin = '${reser_checkin}';
	var reser_checkout = '${reser_checkout}';
	var style_no = $('input:radio[name="style_no"]:checked').val();
	getList();

	// 상세 검색하기 버튼 클릭시 조건 검색 리스트 가지고 오기
	$("#detail_search").on("click", function() {
		// 캠핑장 스타일 선택
		var style_no = $('input:radio[name="style_no"]:checked').val();
		// 시설 데이터
		var facility_no = []; // 배열 선언
		$('input:checkbox[name=facility_no]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
			facility_no.push(this.value);
		});
		if (style_no == null) {
			alert("캠핑 스타일을 선택해주세요.")
			return;
		}
		if (facility_no.length === 0) {
			alert("캠핑 시설란을 확인해주세요.");
			return;
		}
		getList();
	})
	// 캠핑장 목록 가지고 오기
	function getList() {
			var style_no = $('input:radio[name="style_no"]:checked').val();
			var facility_no = []; // 배열 선언
			$('input:checkbox[name=facility_no]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
				facility_no.push(this.value);
			});
			$.ajax({
				type : 'get',
				url : '/camping/searchlist.json',
				dataType : 'json',
				data : {
					camp_addr : camp_addr,
					reser_checkin : reser_checkin,
					reser_checkout : reser_checkout,
					style_no : style_no,
					facility_no : facility_no
				},
				success : function(data) {
					var temp = Handlebars.compile($('#temp').html());
					$('#campList').html(temp(data));
				}
			})
	}
	// 예약가능한 갯수와 예약된 갯수 연산 레지스터헬퍼
	Handlebars.registerHelper("nulltozero", function(camp_tqty, reserve_cnt) {
		if (reserve_cnt == null) {
			return camp_tqty
		} else {
			return camp_tqty - reserve_cnt
		}
	});
	// 캠핑 아이디 및 원하는 예약 날짜 가지고 리드 페이지로 가지고 가기
	$("#campList").on(
			"click",
			".camp_box",
			function() {
				var camp_id = $(this).attr("camp_id");
				location.href = "/camping/read?camp_id=" + camp_id
						+ "&reser_checkin=" + reser_checkin
						+ "&reser_checkout=" + reser_checkout
			})
</script>
<!-- 체크박스 갯수 제한 -->
<script type="text/javascript">
	var maxCount = 5; // 카운트 최대값은 2
	var count = 0; // 카운트, 0으로 초기화 설정

	function CountChecked(field) { // field객체를 인자로 하는 CountChecked 함수 정의
		if (field.checked) { // 만약 field의 속성이 checked 라면(사용자가 클릭해서 체크상태가 된다면)
			count += 1; // count 1 증가
		} else { // 아니라면 (field의 속성이 checked가 아니라면)
			count -= 1; // count 1 감소
		}

		if (count > maxCount) { // 만약 count 값이 maxCount 값보다 큰 경우라면
			alert("최대 5개까지만 선택가능합니다!"); // alert 창을 띄움
			field.checked = false; // (마지막 onclick한)field 객체의 checked를 false(checked가 아닌 상태)로 만든다.
			count -= 1; // 이때 올라갔던 카운트를 취소처리해야 하므로 count를 1 감소시킨다.
		}
	}
</script>