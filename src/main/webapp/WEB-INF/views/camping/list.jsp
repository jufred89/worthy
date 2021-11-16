<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<h3>${camp_addr }에서 ${reser_checkin }에서 ${reser_checkout }까지 예약 가능한 숙소입니다.</h3>
</div>
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
	getList();
	function getList() {
		$.ajax({
			type : 'get',
			url : '/camping/searchlist.json',
			dataType : 'json',
			data:{
				camp_addr:camp_addr,
				reser_checkin:reser_checkin,
				reser_checkout:reser_checkout
			},
			success : function(data) {
				var temp = Handlebars.compile($('#temp').html());
				$('#campList').html(temp(data));
			}
		})
	}
	// 예약가능한 갯수와 예약된 갯수 연산 레지스터헬퍼
	Handlebars.registerHelper("nulltozero",function(camp_tqty,reserve_cnt){
		if(reserve_cnt==null){
			return camp_tqty
		}else{
			return camp_tqty-reserve_cnt
		}
	});
	// 캠핑 아이디 및 원하는 예약 날짜 가지고 리드 페이지로 가지고 가기
	$("#campList").on("click",".camp_box",function(){
		var camp_id = $(this).attr("camp_id");
		location.href = "/camping/read?camp_id=" + camp_id
		+ "&reser_checkin=" + reser_checkin + "&reser_checkout="+reser_checkout
	})
</script>