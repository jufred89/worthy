<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<h1>캠핑장 정보</h1>
<div>
	<div>
		<h1>${cvo.camp_name}</h1>
		<h3>${cvo.camp_addr}</h3>
	</div>
	<div>
		<img src="http://placehold.it/510x510" /> 
		<img src="http://placehold.it/250x250" />
		<img src="http://placehold.it/250x250" />
		<img src="http://placehold.it/250x250" />
		<img src="http://placehold.it/250x250" />
	</div>
	<div>${cvo.camp_price}</div>
	<div>${cvo.camp_memo}</div>
	<div>${cvo.camp_detail}</div>
</div>
<div id="styleList"></div>
<div id="facilityList"></div>
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
	var camp_id='${cvo.camp_id}';
	getStyleList();
	getFacilityList();
	function getStyleList() {
		$.ajax({
			type : 'get',
			url : '/camping/cslist.json',
			dataType : 'json',
			data:{camp_id:camp_id},
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
			data:{camp_id:camp_id},
			success : function(data) {
				var temp = Handlebars.compile($('#temp3').html());
				$('#facilityList').html(temp(data));
			}
		})
	}
</script>