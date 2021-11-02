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



</head>
<body>
	<div id="header">


		<div class="col-xs-4 col-sm-2">
			<h2 onClick="location.href='/'">worthy</h2>
		</div>

		<div class="col-xs-4 col-sm-4" id="menu">
			<div>
				<i class="fa fa-map-marker" aria-hidden="true"></i> <a
					data-toggle="modal" href="#myModal">어디로 떠날까요?</a>

			</div>
			<div>|</div>
			<div>
				<i class="fa fa-calendar-check-o" aria-hidden="true"></i> <a
					data-toggle="modal" href="#myModal2">언제 떠날까요?</a>
			</div>

		</div>

		<div class="col-xs-4 col-sm-6" id="search">
			<div>
				<a data-toggle="modal" href="#myModal3">태마검색 </a>
			</div>
			<div>
				<a href="/notice/list">캠핑정보 </a>
			</div>
			<div>
				<a href="/shop">캠핑상점 </a>
			</div>
			<div>|</div>
			<div>
				<a href="/login">login </a>
			</div>
			<div>
				<a href="/join">join </a>
			</div>
		</div>
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
							<input type="text" style="border: 1px solid gray;"
								placeholder="원하는 지역을 검색해보세요!">
						</div>
						<!-- Modal footer -->
						<div class="modal-footer"></div>
					</div>
				</div>
			</div>
			<!-- 모달창1끝 -->

			<!-- 모달창2시작 -->
			<div class="modal" id="myModal2">
				<div class="modal-dialog">
					<div class="modal-content" style="height: 500px;">

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
						<div class="modal-body" style="height: 300px;">

							<input id="fromDate" type="text"> <input id="toDate"
								type="text">
						</div>
						<!-- Modal footer -->
						<div class="modal-footer"></div>
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
							<button class="btn btn-default">오지/노지캠핑</button>
							<button class="btn btn-default">오지/노지캠핑</button>
							<button class="btn btn-default">오지/노지캠핑</button>
							<hr>
							<h3 style="margin-top: 30px;">편의시설 및 환경</h3>

						</div>

						<!-- Modal footer -->
						<div class="modal-footer"></div>

					</div>
				</div>
			</div>
			<!-- 모달창2끝 -->
			
			<jsp:include page="${pageName}"></jsp:include>
		</div>
	</div>
	<div id="footer"></div>
</body>

</html>
