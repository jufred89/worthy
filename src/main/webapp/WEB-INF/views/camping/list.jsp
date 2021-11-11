<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<h1>캠핑장을 찾아보세요.</h1>
<h4>어디갈지 모르겠다면?</h4>
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
	<input type="text" placeholder="검색어를 입력해보세요."/> 
	<select id="searchType">
		<option value="search1">조회순</option>
		<option value="search2">최신상품순</option>
		<option value="search3">높은가격순</option>
		<option value="search4">낮은가격순</option>
	</select>
</div>
<hr />
<div id="campList"></div>
<script id="temp" type="text/x-handlebars-template">
		{{#each .}}
		<div class="camp_box" onClick="location.href='/camping/read?camp_id={{camp_id}}'">
			<div class="image-box"><img class="image-thumbnail" src="/camping/display?file={{camp_image}}"/></div>
			<div class="cname-box">{{camp_name}}</div>
			<div class="caddr-box">{{camp_addr}}</div>
			<div class="cprice-box">₩ {{camp_price}}원 / 박</div>
		</div>
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
			success : function(data) {
				var temp = Handlebars.compile($('#temp').html());
				$('#campList').html(temp(data));
			}
		})
	}
</script>