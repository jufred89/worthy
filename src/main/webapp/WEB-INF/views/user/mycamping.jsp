<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.container {
	width: 100%;
	text-align: left;
}
.container h1{
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
.subcontent{
	background: yellow;
	padding: 10px;
	overflow: hidden;
}
.subcontent .campReservMain{
	float: left;
}
.subcontent .campReservImage{
	float: left;
}
.campReservImage img{
	border-radius:25px;
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
				<c:when test="${crvo.reser_checkin > now}">
					<div class="subheading">예정된 예약</div>
					<div class="subcontent">
						<div class="campReservImage">
							<img src="http://placehold.it/300x300" width=300/>						
						</div>
						<div class="campReservMain">
							<div><h3>${crvo.camp_name}</h3></div>
							<div><h3>${crvo.camp_addr}</h3></div>
							<div><h3>${crvo.reser_checkin}</h3></div>
							<div><h3>${crvo.reser_checkout}</h3></div>
							<div><h3>${crvo.reser_price}</h3></div>
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
				<c:when test="${crvo.reser_checkin < now}">
					<div class="subheading">이전 예약</div>
					<div class="subcontent"></div>
				</c:when>
			</c:choose>
		</c:forEach>
	</div>
	<div id="tab-3" class="tab-content">
		<c:forEach items="${campReserList}" var="crvo">
		<c:choose>
			<c:when test="${crvo.reser_checkin > '2021-12-06'}"> 
				<div class="subheading">취소됨</div>
				<div class="subcontent"></div>
			</c:when>
		</c:choose>
	</c:forEach>
	</div>

</div>
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