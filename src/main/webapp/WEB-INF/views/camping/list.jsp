<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<h1>캠핑장 목록</h1>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script src="/resources/pagination.js"></script>
<img src="http://placehold.it/200x200"
	onClick="location.href='/camping/read'" />
<div id="total"></div>
<div id="campList"></div>
<script id="temp" type="text/x-handlebars-template">
		{{#each item}}
			<div>
				{{facltNm}}
				{{addr1}}
				{{addr2}}
				{{lctCl}}
				{{induty}}
				{{mapX}}
				{{mapY}}
				{{tel}}
				{{animalCmgCl}}
				{{themaEnvrnCl}}
				{{gnrlSiteCo}}
				{{autoSiteCo}}
				{{glampSiteCo}}
				{{caravSiteCo}}
				{{toiletCo}}
				{{eqpmnLendCl}}
				{{intro}}
				{{toiletCo}}
				{{swrmCo}}
				{{wtrplCo}}
			</div>
			<img src="{{firstImageUrl}}"/>
		{{/each}}
</script>

<script>
	var page = 1;
	getList();
	function getList() {
		$.ajax({
			type : 'get',
			url : '/camping/list.json',
			dataType : 'json',
			data:{
				page:page
			},
			success : function(data) {
				var temp = Handlebars.compile($('#temp').html());
				$('#campList').html(temp(data.response.body.items));
				$('#total').html("검색 결과 : " + data.response.body.totalCount);
			}
		})
	}
</script>