<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>워디 : 캠핑 어디까지 가봤어?</title>

<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" href="../resources/home.css" />

<script src="../resources/bootstrap-datepicker.js"></script>
<link rel="stylesheet" href="../resources/bootstrap-datepicker.css">

</head>
<body>
	<div id="header">

<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header col-sm-2">
       <h2 onClick="location.href='/'">worthy</h2>
    </div>
    <div class="nav navbar-nav col-sm-4">
   
    <div><i class="fa fa-map-marker" aria-hidden="true"></i> <a
					data-toggle="modal" href="#myModal">어디로 떠날까요?</a></div>
      
    <div>|</div>
			<div>
				<i class="fa fa-calendar-check-o" aria-hidden="true"></i> <a
					data-toggle="modal" href="#myModal2">언제 떠날까요?</a>
			</div>
    </div>
    <div class="nav navbar-nav navbar-right col-sm-6" id="menus">
    <div>
				<a data-toggle="modal" href="#myModal3">태마검색 </a>
			</div>
			<div>
<<<<<<< HEAD
				<a href="/notice/list">캠핑정보 </a>
=======
				<a href="/info/notice/list">캠핑정보 </a>
>>>>>>> a5bd56885ef774485a075d0122f678efd122802f
			</div>
			<div>
				<a href="/shop">캠핑상점 </a>
			</div>
			<div>
				<a href="/board/list">자유게시판</a>
			</div>
			<div>|</div>
     		 <c:if test="${uid!=null}">
					<span style="float:right;">
						<a href="/mypage?uid=${uid}">${uid}</a>
						<a href="/user/logout">로그아웃</a>
					</span>
				    <div><a href="/mypage">Mypage</a></div>
			</c:if>
			<c:if test="${uid==null}">
					<a href="/user/login"><span class="glyphicon glyphicon-log-in"></span> Login</a>
					<a href="/user/join"><span class="glyphicon glyphicon-user"></span> Sign Up</a>
			</c:if>
    </div>
  </div>
</nav>
		
	

	
	</div>
	<div id="center">
		<div id="content">
			<!-- 모달창1시작 -->
			<div class="modal" id="myModal">
				<div class="modal-dialog">
					<div class="modal-content" style="height: 500px;">

						<!-- Modal Header -->
						<div class="modal-header" style="height: 55px;">
							<div class="row" style="height: 200px; margin: 0;">
								<div class="col-md-11" style="background: rgba(0, 0, 0, 0);">
									<p style="font-weight: bold;">어디로 떠날까요?</p>
								</div>
								<div class="col-md-1" style="padding: 0;">
									<button type="button" class="close" data-dismiss="modal"
										style="width: 20px; height: 20px; margin-bottom: 50px; padding: 0;">&times;</button>
								</div>
							</div>
						</div>

						<!-- Modal body -->
						<div class="modal-body" style="height: 300px;">
						<div id="search_local">
							<input type="text" id="local" style="border: 1px solid gray;width:200px;"
								placeholder="원하는 지역을 검색해보세요!" value="dahee">
								
								<i class="fa fa-search" aria-hidden="true"></i>
							<hr>
							<h3>지역</h3>
							<ul>
							<li>국내전체</li>
							<li>제주</li>
							<li>강원</li>
							<li>부산</li>
							<li>경기</li>
							<li>충청</li>
							<li>경상</li>
							<li>전라</li>
							<li>인천</li>
							<li>대전</li>
							<li>대구</li>
							<li>울산</li>
							</ul>
								</div>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
						<button type="button" class="btn btn-default btn-lg">큰 버튼</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 모달창1끝 -->

			<!-- 모달창2시작 -->
			<div class="modal" id="myModal2">
				<div class="modal-dialog">
					<div class="modal-content" style="height: 250px;">

						<!-- Modal Header -->
						<div class="modal-header" style="height: 55px;">
							<div class="row" style="height: 200px; margin: 0;">
								<div class="col-md-11" style="background: rgba(0, 0, 0, 0);">
									<p style="font-weight: bold;">언제 떠날까요?</p>
								</div>
								<div class="col-md-1" style="padding: 0;">
									<button type="button" class="close" data-dismiss="modal"
										style="width: 20px; height: 20px; margin-bottom: 50px; padding: 0;">&times;</button>
								</div>
							</div>
						</div>

						<!-- Modal body -->
						<div class="modal-body" style="height: 100px;">
<div class="input-group input-daterange">
    <input type="text" id="start" class="form-control" >
    <div class="input-group-addon">부터</div>
    <input type="text" id="end" class="form-control" >
     <div class="input-group-addon">까지</div>
</div>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
						<img src="">
						<button type="button" id="d_start" class="btn btn-default btn-lg">검색할까요?</button>
						
						</div>
					</div>
				</div>
			</div>
			<!-- 모달창2끝 -->

			<!-- 모달창2시작 -->
			<div class="modal" id="myModal3">
				<div class="modal-dialog">
					<div class="modal-content" style="height: 800px;">

						<!-- Modal Header -->
						<div class="modal-header">
							<h1 style="text-align: center">worthy</h1>
							<h2>테마검색</h2>
							<p>원하는 캠핑 스타일을 선택 후 검색버튼을 클릭하세요!</p>

						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<h3>캠핑스타일</h3>
							<button class="btn btn-default">오지/노지캠핑</button>
							<button class="btn btn-default">카라반/글램핑</button>
							<button class="btn btn-default">파박</button>
							<hr>
							<h3 style="margin-top: 30px;">자연환경</h3>
							
							<hr>
							<h3 style="margin-top: 30px;">편의시설 및 환경</h3>

						</div>

						<!-- Modal footer -->
						<div class="modal-footer"></div>
                   <button>search</button>
					</div>
				</div>
			</div>
			<!-- 모달창2끝 -->
			
			<jsp:include page="${pageName}"></jsp:include>
		</div>
	</div>
	<div id="footer"></div>
</body>
<script>

var end=1;
$('#start').on('click',function(){
	end=0;
	
});
$('#end').on('click',function(){
	end=1;
});
$('#start').datepicker({
	format: "yyyy-mm-dd",	
	startDate: '0d',	
	
    language : "ko"	
	    
	})
$("#search_local").on("click","ul li",function(){
	var s_input=$(this).parent().parent().find($("#local"))
    var s_li=$(this).text();
	s_input.val(s_li)
})

   
 $("div.input-daterange").each(function(){
    var $inputs = $(this).find('input');
   
    $inputs.datepicker("setDate", new Date());
    if ($inputs.length >= 2) {
        var $from = $inputs.eq(0);
        var $to   = $inputs.eq(1);
        $from.on('changeDate', function (e) {
            var d = new Date(e.date.valueOf());

        
            $to.datepicker('setStartDate', d); // 종료일은 시작일보다 빠를 수 없다.
        });
        $to.on('changeDate', function (e) {
            var d = new Date(e.date.valueOf());
            $from.datepicker('setEndDate', d); // 시작일은 종료일보다 늦을 수 없다.
        });
    }
    
}) 

$('#d_start').on('click',function(){
	if(end==0){
		alert('언제까지 갔다오실까요?')
		return;
	}
	if(!confirm('이 기간동안 떠나시나요?'))return;
})

</script>
</html>
