<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	#mycamping{
		width:80%;
		margin:0 auto;
	}
	#info{
		float:left;
		margin-top:90px;
	}
	#infoimg{
		float:left;
		margin:30px 0 0 100px;
	}
</style>
	<div id="mycamping">
		<h3>예약 정보</h3>
		<div>다가올 예약</div>
			<img src='/resources/img-mypage.png' width=400px/>
			<div>
				다가올 예약이 없습니다. 새로운 캠핑장을 찾아 떠나보세요!
				<div>
					<button id="btnSearch">FIND CAMPING</button>
				</div>
			</div>
				
			<h3 style="margin-top:200px;">관심 캠핑장</h3>
			<div style="overflow:hidden">
				<div id="info">
					<div id="title">캠핑장 이름</div>
					<div id="location">캠핑장 위치</div>
					<div id="price">가격</div>
					<div>
						<button>예약하기</button>
					</div>
				</div>
				<div id="infoimg">
					<img src='http://placehold.it/400x250'/>
				</div>
			</div>
		</div>