<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<h1>캠핑장을 찾아보세요.</h1>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script src="/resources/pagination.js"></script>
<script src="../resources/bootstrap-datepicker.js"></script>
<script src="../resources/home.css"></script>
<style>
#campList {
	width: 1600px;
	margin: 0px auto;
	overflow: hidden;
	position:absolute;
	left: 50%;
	transform: translate(-50%);
}

.camp_box {
	height: 450px;
	width: 400px;
	float: left;
	margin-bottom: 10px;
}

.camp_box:hover {
	cursor: pointer;
}

.image-box {
	width: 350px;
	height: 350px;
	overflow: hidden;
	margin: 0 auto;
	border-radius: 25px;
}

.image-thumbnail {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.cname-box {
	font-size: 20px;
	font-weight: bold;
}

.caddr-box {
	font-size: 15px;
}

.cprice-box {
	font-size: 15px;
}

#campListHead {
	margin: 30px;
}

#campListHead h3 {
	text-align: center;
}

/* 캠핑 스타일, 시설  시작*/
#campStyleFacilityparent{
	position: relative;
}
#campStyleList {
	width: 500px;
	margin: 0px auto;
	padding: 10px;
	absolute:
}

#campFacilityList {
	width: 500px;
	margin: 10px auto;
	padding: 20px;
	font-weight: bold;
}

#campFacilityList input[type=checkbox] {
	margin: 5px 5px 5px 5px;
	width: 15px;
	height: 15px;
}

#search_box {
	width: 1200px;
	margin: 0px auto;
	padding: 10px;
	display: flex;
	justify-content: center;
	align-content: center;
}

#search_box input[type='text'] {
	width: 250px;
	height: 50px;
	box-sizing: border-box;
	border: 1px solid black;
	border-radius: 10px;
	padding: 20px;
	font-weight: bold;
}
/* 캠핑 스타일, 시설  끝*/

/* 지역 선택 CSS 시작 */
#pop {
	display: none;
	position: absolute;
	background: black;
	border-radius: .4em;
	width: 250px;
	height: 270px;
	color: white;
	margin-top: 20px;
	z-index: 120;
}

#pop:after {
	content: '';
	position: absolute;
	top: 0;
	left: 50%;
	width: 0;
	height: 0;
	border: 20px solid transparent;
	border-bottom-color: black;
	border-top: 0;
	margin-left: -20px;
	margin-top: -20px;
}

#pop ul {
	flex-flow: wrap;
	list-style: none;
	display: flex;
	justify-content: center;
	align-content: center;
	padding: 10px;
}

#pop ul li {
	width: 50px;
	height: 50px;
	display: flex;
	justify-content: center;
	align-items: center;
}

#pop ul li:hover {
	background: white;
	color: black;
}
/* 지역 선택 CSS 끝*/
</style>
<div id="campListHead">
<!-- 
	<c:if test="${camp_addr eq null}">
	<h3>전국에서 ${reser_checkin }에서 ${reser_checkout }까지 예약 가능한 숙소입니다.</h3>
	</c:if>
	<c:if test="${camp_addr ne null}">
	<h3>${camp_addr }에서 ${reser_checkin }에서 ${reser_checkout }까지 예약 가능한 숙소입니다.</h3>
	</c:if>
	<c:if test="${reser_checkin eq null && reser_checkout eq null}">
	<h3>원하시는 숙소를 검색해보세요.</h3>
	</c:if>
 -->
	<c:choose>
		<c:when test="${camp_addr eq '' && reser_checkin ne '' && reser_checkout ne ''}">
			<h3>전국에서 ${reser_checkin }에서 ${reser_checkout }까지 예약 가능한 숙소입니다.</h3>
		</c:when>
		<c:when test="${camp_addr ne '' && reser_checkin ne '' && reser_checkout ne ''}">
			<h3>${camp_addr }에서 ${reser_checkin }에서 ${reser_checkout }까지 예약 가능한 숙소입니다.</h3>
		</c:when>
		<c:when test="${camp_addr eq '' && reser_checkin eq '' && reser_checkout eq ''}">
			<h3>어디로 언제 여행을 떠나실까요?</h3>			
		</c:when>
	</c:choose>
</div>
<div id="search_box">
	<div class="input-group input-daterange where"
		style="margin-right: 5px;">
		<input type="text" name="camp_addr" placeholder="어디로?"
			autocomplete=off id="where" value="${camp_addr}" class="where">
		<div id='pop' class='pop'>
			<ul>
				<li>서울</li>
				<li>제주</li>
				<li>강원</li>
				<li>부산</li>
				<li>경기</li>
				<li>충북</li>
				<li>충남</li>
				<li>세종</li>
				<li>경상</li>
				<li>광주</li>
				<li>전북</li>
				<li>전남</li>
				<li>경북</li>
				<li>경남</li>
				<li>인천</li>
				<li>대전</li>
				<li>대구</li>
				<li>울산</li>
				<li></li>
				<li></li>
			</ul>
		</div>
	</div>
	<div class="input-group input-daterange" id="time">
		<input type="text" id="start" class="form-control" autocomplete=off
			name="reser_checkin" placeholder="언제부터?" value="${reser_checkin}" style="margin-right: 5px;"><input
			type="text" id="end" class="form-control" name="reser_checkout"
			autocomplete=off value="${reser_checkout}" placeholder="언제까지?">
	</div>
</div>
<div id="campStyleFacilityparent">
	<div id="campStyleList">
		<h4>캠핑장 스타일</h4>
		<hr />
		<c:forEach items="${styleList}" var="item_style">
			<input type="radio" name="style_no" value="${item_style.style_no}" />
			<label for="a1"><span>${item_style.style_name}</span></label>
		</c:forEach>
	</div>
	<div id="campFacilityList">
		<h4>캠핑장 시설</h4>
		<hr />
		<c:forEach items="${facilityList}" var="item_facility">
			<c:if test="${item_facility.facility_no ne 0}">
				<input onclick="CountChecked(this)" type="checkbox"
					name="facility_no" value="${item_facility.facility_no}">${item_facility.facility_name}
	</c:if>
		</c:forEach>
	</div>
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
		if(camp_addr==null){
			var camp_addr=$('input[name="camp_addr"]').val();
		}
		if(reser_checkin==null){
			var reser_checkin=$('input[name="reser_checkin"]').val();
		}
		if(reser_checkout==null){
			var reser_checkout=$('input[name="reser_checkout"]').val();
		}
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
		alert(camp_addr)
		alert(reser_checkin)
		alert(reser_checkout)
		getList();
	})
	// 캠핑장 목록 가지고 오기
	function getList() {
			var camp_addr=$('input[name="camp_addr"]').val();
			var reser_checkin=$('input[name="reser_checkin"]').val();
			var reser_checkout=$('input[name="reser_checkout"]').val();
			var style_no = $('input:radio[name="style_no"]:checked').val();
			var facility_no = []; // 배열 선언
			$('input:checkbox[name=facility_no]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
				facility_no.push(this.value);
			});
			$("#campListHead h3").html(camp_addr+"에서 "+reser_checkin+"부터 "+reser_checkout+"까지 예약 가능한 숙소입니다.");
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
<!-- 어리도 값이 없을 경우 픽터 스크립트 -->
<script>
	$("#where").mouseup(function() {
		$('#pop').css('display', 'block')
	})
	$(document).mouseup(function(e) {
		var where = $("#where")
		var pop = $("#pop");
		if (!$(e.target).hasClass("where")) {
			$('#pop').css('display', 'none')
		}
	});
	$('#pop').on('click', 'ul li', function() {
		var where = $(this).parent().parent().parent().find($('#where'))
		where.val($(this).text())
		$('#pop').css('display', 'none')
	})
</script>
<!-- 날짜 픽커 -->
<script type="text/javascript">
	$("div.input-daterange").each(function() {
		var $inputs = $(this).find('input');

		// $inputs.datepicker("setDate", new Date());
		if ($inputs.length >= 2) {
			var $from = $inputs.eq(0);
			var $to = $inputs.eq(1);
			$from.on('changeDate', function(e) {
				var d = new Date(e.date.valueOf());
				$to.datepicker('setStartDate', d); // 종료일은 시작일보다 빠를 수 없다.
			});
			$to.on('changeDate', function(e) {
				var d = new Date(e.date.valueOf());
				$from.datepicker('setEndDate', d); // 시작일은 종료일보다 늦을 수 없다.
			});
		}
	})

	var today = null;
	var year = null;
	var month = null;
	var firstDay = null;
	var lastDay = null;
	var $tdDay = null;
	var $tdSche = null;

	var startValue = $('#start').val()

	$(document).ready(function() {
		drawCalendar();
		initDate();
		drawDays();
		$("#movePrevMonth").on("click", function() {
			movePrevMonth();
		});
		$("#moveNextMonth").on("click", function() {
			moveNextMonth();
		});
		ClickDay();
		//start value값이 change
		$('#start').on('change', function() {

			var startValue = $('#start').val()
			var arr = startValue.split("-");
			var startMonth = $('#cal_top_month').text()
			var date = $('.day2').text()
			if (startMonth == arr[1] && arr[2] == date) {
				$(this)
			}
		})
	});

	//color
	function dateColor() {
		var startValue = $('#start').val()

	}

	//calendar 그리기
	function drawCalendar() {
		var setTableHTML = "";
		setTableHTML += '<table class="calendar">';
		setTableHTML += '<tr><th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th></tr>';
		for (var i = 0; i < 5; i++) {
			setTableHTML += '<tr height="50">';
			for (var j = 0; j < 7; j++) {
				setTableHTML += '<td class="day2" style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap" >';
				setTableHTML += '    <div class="cal-day" ></div>';
				setTableHTML += '    <div class="cal-schedule"></div>';
				setTableHTML += '</td>';
			}
			setTableHTML += '</tr>';
		}
		setTableHTML += '</table>';
		$("#cal_tab").html(setTableHTML);
	}

	//날짜 초기화
	function initDate() {
		$tdDay = $("td div.cal-day")
		$tdSche = $("td div.cal-schedule")
		dayCount = 0;
		today = new Date();
		year = today.getFullYear();
		month = today.getMonth() + 1;
		firstDay = new Date(year, month - 1, 1);
		lastDay = new Date(year, month, 0);
	}

	//calendar 날짜표시
	function drawDays() {

		$("#cal_top_year").text(year);
		$("#cal_top_month").text(month);
		for (var i = firstDay.getDay(); i < firstDay.getDay()
				+ lastDay.getDate(); i++) {
			$tdDay.eq(i).text(++dayCount);
		}
		for (var i = 0; i < 42; i += 7) {
			$tdDay.eq(i).css("color", "red");
		}
		for (var i = 6; i < 42; i += 7) {
			$tdDay.eq(i).css("color", "blue");
		}
	}

	//calendar 월 이동
	function movePrevMonth() {
		month--;
		if (month <= 0) {
			month = 12;
			year--;
		}
		if (month < 10) {
			month = String("0" + month);
		}
		getNewInfo();
	}

	function moveNextMonth() {
		month++;
		if (month > 12) {
			month = 1;
			year++;
		}
		if (month < 10) {
			month = String("0" + month);
		}
		getNewInfo();
	}

	function getNewInfo() {
		for (var i = 0; i < 42; i++) {
			$tdDay.eq(i).text("");
		}
		dayCount = 0;
		firstDay = new Date(year, month - 1, 1);
		lastDay = new Date(year, month, 0);
		drawDays();
	}
	function ClickDay() {
		$('.day2').on('click', function() {
			var date = $(this).text();
			alert(typeof (date))
		})
	}
</script>