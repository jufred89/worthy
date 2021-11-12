<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<h1>캠핑장 정보</h1>
<!-- 캠핑장 정보 부분 -->
<div>
	<a href="/camping/update?camp_id=${cvo.camp_id}">캠핑장 수정</a>
	<div>
		<h1>${cvo.camp_name}</h1>
		<h3 id="from_addr">${cvo.camp_addr}</h3>
	</div>
	<div>
		<img src="http://placehold.it/510x510" /> <img
			src="http://placehold.it/250x250" /> <img
			src="http://placehold.it/250x250" /> <img
			src="http://placehold.it/250x250" /> <img
			src="http://placehold.it/250x250" />
	</div>
	<div>${cvo.camp_price}</div>
	<div>${cvo.camp_memo}</div>
	<div>${cvo.camp_detail}</div>
</div>
<!-- 캠핑장 스타일 목록 -->
<h3>캠핑장 스타일</h3>
<div id="styleList"></div>
<h3>캠핑장 시설</h3>
<!-- 시설 목록 부분 -->
<div id="facilityList"></div>
<!-- 주소 기반 지도 -->
<div id="map" style="width: 500px; height: 400px;"></div>
<!-- 캠핑장스타일, 시설 목록 template -->
<script id="temp2" type="text/x-handlebars-template">
		{{#each .}}
		<div>
			<div>{{style_name}} | {{style_qty}}개</div>
		</div>
		{{/each}}
</script>
<script id="temp3" type="text/x-handlebars-template">
		{{#each .}}
		<div>
			<div>{{facility_name}}</div>
		</div>
		{{/each}}
</script>
<script>
	var camp_id = '${cvo.camp_id}';
	getStyleList();
	getFacilityList();
	function getStyleList() {
		$.ajax({
			type : 'get',
			url : '/camping/cslist.json',
			dataType : 'json',
			data : {
				camp_id : camp_id
			},
			success : function(data) {
				var temp = Handlebars.compile($('#temp2').html());
				$('#styleList').html(temp(data));
			}
		})
	}
	function getFacilityList() {
		$.ajax({
			type : 'get',
			url : '/camping/cflist.json',
			dataType : 'json',
			data : {
				camp_id : camp_id
			},
			success : function(data) {
				var temp = Handlebars.compile($('#temp3').html());
				$('#facilityList').html(temp(data));
			}
		})
	}
</script>
<!-- 주소로 좌표값 가져오기 T맵 좌표값이 달라서 주소로 다음지도로 좌표값 불러오기 -->
<!-- 다음 지도 API .js -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=437cd2932e9baa6f039994ed90c57549&libraries=services"></script>
<script>
		var camping_addr="${cvo.camp_addr}"
		var camping_name="${cvo.camp_name}"
		if(camping_addr!=null){
			console.log(camping_addr);
			var mapContainer = document.getElementById('map') // 지도를 표시할 div 
		    var mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
	
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			var geocoder = new kakao.maps.services.Geocoder();

			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(camping_addr, function(result, status) {
	
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });
	
					var iwContent = '<div style="width:200px;text-align:center;padding:2px 0;">'
						iwContent+=	'<h4 style="font-weight:bold">'+camping_name+'</h4>'+'<hr/>'
						iwContent+=	'<h5>'+camping_addr+'</h4>'
						iwContent+='</div>'
					    iwRemoveable = true
			        
			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
					    content : iwContent,
					    removable : iwRemoveable
			        });
						
					// 마커에 클릭이벤트를 등록합니다
					kakao.maps.event.addListener(marker, 'click', function() {
						// 마커 위에 인포윈도우를 표시합니다
						infowindow.open(map, marker);  
					});
	
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
			        map.setCenter(coords);
			    } 
			});
		}
</script>