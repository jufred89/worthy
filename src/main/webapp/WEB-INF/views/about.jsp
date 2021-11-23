<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>




<style>
#pop {
	display: none;
	position: relative;
	background: black;
	border-radius: .4em;
	width: 250px;
	height: 270px;
	color: white;
	margin-top: 20px;
	z-index: 99;
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

#background_image {
	position: relative;
	background-image: url("../resources/back4.jpg");
	/* background:black; */
	background-size: cover;
	background-position: center center;
	height: 1500px;
	width: 100% background-repeat: no-repeat;
}

#search_box {
	display: flex;
	justify-content: center;
	align-content: center;
}

#background_image h1 {
	margin-bottom: 20px;
	color: white;
	font-weight: bold;
	font-size: 270%;
	color: white;
}

#where:focus {
	outline: none;
}

#search_box input[type='text'] {
	width: 250px;
	height: 50px;
	box-sizing: border-box;
	border: none;
	border-radius: 10px;
	padding: 20px;
	font-weight: bold;
}

#search_btn {
	background-image: url("../resources/search.png");
	background-repeat: no-repeat;
	background-size: 20px;
	background-position: 50%;
	height: 50px;
	width: 70px;
	border-radius: 10px;
	border: none;
}

#time input {
	margin-right: 5px;
}

#sub_back {
	position: absolute;
	top: 600px;
	left: 0;
	right: 0;
	display: flex;
	justify-content: center;
	align-content: center;
}

#slider {
	box-sizing: border-box;
	border: 5px solid silver;
	border-radius: 7px;
	box-shadow: 0 0 20px #ccc inset;
	overflow: hidden;
	width: 1250px;
	height: 250px;
	position: relative;
}

#items {
	position: absolute;
	left: 0;
	display: flex;
	justify-content: center;
	align-content: center;
}

#infoMain {
	position: absolute;
	opacity: 0.9;
	bottom: 0px;
	left: 0;
	right: 0;
	display: flex;
	justify-content: center;
	align-content: center;
	background: lightgray;
	text-align: left;
}

#infoMain div {
	margin: 20px 40px;
	width: 300px;
}

ul {
	list-style: none;
	padding: 0;
}

ul li {
	width: 100%;
	display: flex;
	justify-content: left;
	align-items: center;
	cursor: pointer;
}

ul li:hover {
	color: blue;
}

#pre-next-image {
	width: 100%;
	z-index: 10;
	position: absolute;
	top: 50%;
	transform: translate(0%, -50%);
	display: flex;
	justify-content: space-between;
	align-content: center;
}

#pre-next-image div {
	display: flex;
	justify-content: center;
	align-content: center;
	width: 50px;
	height: 50px;
	border-radius: 100%;
}

#prev {
	background-image: url("../resources/left.png");
	background-size: cover;
	background-repeat: no-repeat;
	background-position: center;
}

#next {
	background-image: url("../resources/right.png");
	background-size: cover;
	background-repeat: no-repeat;
	background-position: center;
}

#footer {
	position: static;
}

.visible {
	display: block;
}

.item {
	width: 250px;
	height: 250px;
	overflow: hidden;
	margin: 0 auto;
}

.image-thumbnail {
	width: 100%;
	height: 100%;
	object-fit: cover;
	vertical-align: middle;
}
</style>
<c:if test="${uid.indexOf('admin')==-1 || uid==null}">
	<div id="background_image">
		<div style="height: 70px;"></div>

		<h1>어디로 떠날까요?</h1>
		<div id="search_box">
			<div class="input-group input-daterange where" style="margin-right: 5px;">
				<input type="text" name="camp_addr" placeholder="어디로?" autocomplete=off id="where" class="where">
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
					name="reser_checkin" placeholder="언제부터?" value=""> <input
					type="text" id="end" class="form-control" name="reser_checkout" autocomplete=off
					placeholder="언제까지?"> 

			</div>

<input type="button" id="search_btn">

		</div>

		<h1 style="position: absolute; top: 500px; left: 0; right: 0;"><span style="color: #ff0000">New</span>
			& Update</h1>
		<div id="sub_back">
			<div id="slider" >
				<div id="items" ></div>
				<script id="temp" type="text/x-handlebars-template">
            {{#each .}}
               <div class="item" style="padding:0;" title="{{camp_name}}">
				<div class="jb-wrap" onclick="location.href='/camping/read?camp_id={{camp_id}}'">
					<img class="image-thumbnail" src="/camping/display?file={{camp_image}}"/>
				</div>
				<div class="jb-text">
					<p>HELLO</p>	
				</div>
               </div>
            {{/each}}
         </script>
         <div id="pre-next-image" style=""> 


<div id="prev" class="" style="margin-left:10px;"></div>
<div id="next" class="" style="margin-right:10px;"></div>
</div>


			</div>
					
		</div>
		
		<div id="infoMain">
		         <div id="notice_title"></div>
				<script id="temp3" type="text/x-handlebars-template">
<img src="../resources/notice.png" width=50 height=50/><a href="/notice/list"><span class="glyphicon glyphicon-plus more" style="float:right;" title="더보기"></span></a>
<h2>공지사항</h2>
               <ul class="item">
            {{#each .}}
            <li onClick="location.href='/notice/read?nb_no={{nb_no}}'" >{{nb_title}}</li>
            {{/each}}

               </ul>

         </script>
		<div id="tip_title"></div>
				<script id="temp1" type="text/x-handlebars-template">
<img src="../resources/light.png" width=50 height=50/><a href="/tip/list"><span class="glyphicon glyphicon-plus more" style="float:right;" title="더보기"></span></a>
<h2>캡핑 팁</h2>
 <ul class="item">
            {{#each .}}
              
            <li onClick="location.href='/tip/read?tip_no={{tip_no}}'" >{{tip_title}}</li>
               
            {{/each}}
</ul>
         </script>
         <div id="food_title"></div>
				<script id="temp2" type="text/x-handlebars-template">
<img src="../resources/food.png" width=50 height=50/><a href="/recipe/list"><span class="glyphicon glyphicon-plus more" style="float:right;" title="더보기"></span></a>
<h2 >캡핑음식</h2>
               <ul class="item">
            {{#each .}}
            <li onClick="location.href='/recipe/read?fi_no={{fi_no}}'">{{fi_title}}</li>
            {{/each}}
               </ul>
         </script>

         <div id="board_title"></div>
				<script id="temp4" type="text/x-handlebars-template">
<img src="../resources/talking.png" width=50 height=50/><a href="/board/list"><span class="glyphicon glyphicon-plus more" style="float:right;" title="더보기"></span></a>
<h2>자유게시판</h2>
               <ul class="item">
            {{#each .}}
            <li onClick="location.href='/tip/read?tip_no={{tip_no}}'" >{{fb_title}}</li>
            {{/each}}
               </ul>
         </script>
	</div>
	</div>
</c:if>


<script>
//슬라이드 반복 실행
 var repeat=setInterval( function(){ $('#next').click(); }, 4500);

$('#next').on('click', function(){
    clearInterval(repeat);  //슬라이드 반복 중지
    $('#items .item:first').animate({ marginLeft:-200 }, 300, function(){
        $(this).appendTo($('#items')).css({marginLeft:0});
    });
    repeat=setInterval(function(){ $('#next').click(); }, 4500);  //슬라이드 반복 실행
});

$('#prev').on('click', function(){
    clearInterval(repeat);  //슬라이드 반복 중지
    $('#items .item:first').animate({ marginLeft: 200 }, 300, function(){
        $(this).before($('#items .item:last')).css({marginLeft:0});
    });
    repeat=setInterval(function(){ $('#next').click(); }, 4500);  //슬라이드 반복 실행
}); 

	
//more버튼툴팁
$("#test").mouseup(function(){
	$('#test2').show()
})
$('.more').tooltip()
	//item생성 후 items에 추가
	$.ajax({
		type : "get",
		url : "/campSlide.json",
		dataType : "json",
		success : function(data) {
			var temp = Handlebars.compile($("#temp").html());
			$("#items").html(temp(data));
		}
	});
	//item생성 후 items에 추가
	$.ajax({
		type : "get",
		url : "/tip_list.json",
		dataType : "json",
		success : function(data) {
			var temp = Handlebars.compile($("#temp1").html());
			$("#tip_title").html(temp(data));
		}
	});
	//item생성 후 items에 추가
	$.ajax({
		type : "get",
		url : "/food_list.json",
		dataType : "json",
		success : function(data) {
			var temp = Handlebars.compile($("#temp2").html());
			$("#food_title").html(temp(data));
		}
	});
	//item생성 후 items에 추가
	$.ajax({
		type : "get",
		url : "/board/board_list.json",
		dataType : "json",
		success : function(data) {
			var temp = Handlebars.compile($("#temp4").html());
			$("#board_title").html(temp(data));
		}
	});
	//item생성 후 items에 추가
	$.ajax({
		type : "get",
		url : "/notice/notice_list.json",
		dataType : "json",
		success : function(data) {
			var temp = Handlebars.compile($("#temp3").html());
			$("#notice_title").html(temp(data));
		}
	});
	$("#where").mouseup(function() {
		
		$('#pop').css('display', 'block')
		
	})


/*  	$('html').click(function(e) {
		
	});  */ 
 	// 외부영역 클릭 시 팝업 닫기
 	$(document).mouseup(function (e){
		var where=$("#where")
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
	$('#start,#end').datepicker({
		format : "yyyy-mm-dd",
		startDate : '0d',
		autoShow : true,
		language : "ko"

	})
	$('#search_btn')
			.on(
					'click',
					function(e) {

						var camp_addr = $('#search_box input[name=camp_addr]')
								.val()
						var reser_checkin = $(
								'#search_box input[name=reser_checkin]').val()
						var reser_checkout = $(
								'#search_box input[name=reser_checkout]').val()
						alert(camp_addr + "/" + reser_checkin + "/"
								+ reser_checkout)
						location.href = "/camping/list?camp_addr=" + camp_addr
								+ "&reser_checkin=" + reser_checkin
								+ "&reser_checkout=" + reser_checkout

					})

	$("div#time").each(function() {
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
</script>