<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<div id="sub">
	<div class="subheading">캠핑매출현황</div>
	<hr />
	<div class="subheading">캠핑 일일 매출 현황</div>
	<div id="chart_div" style="width: 1000px; height: 500px;"></div>
	<hr />
	<div class="subheading">캠핑 월별 매출 현황</div>
	<div id="chart_div2" style="width: 1000px; height: 500px;"></div>
	<hr />
	<div class="subheading">베스트 5 캠핑장</div>
	<div id="chart_div3" style="width: 1000px; height: 500px;"></div>
	<hr />
	<div class="subheading">워스트 5 켐핑장</div>
	<div id="chart_div4" style="width: 1000px; height: 500px;"></div>
</div>
</body>
<script>
getList();
var chartData = new Array();
var chartData2 = new Array();
var chartData3 = new Array();
var chartData4 = new Array();

function getList() {
	$.ajax({
		type : 'get',
		url : '/admin/dayIncome.json',
		dataType : 'json',
		success : function(data) {
			// 차트 데이터를 가지고 와서 배열에 넣는 작업을 each로 돌림
			var arr = new Array();
			arr.push("금액");
			arr.push("일일");
			chartData.push(arr);
			$(data).each(function(){
				var arr = new Array();
				arr.push(this.day);
				arr.push(this.income);
				chartData.push(arr);
			})
		}
	})
	$.ajax({
		type : 'get',
		url : '/admin/monthIncome.json',
		dataType : 'json',
		success : function(data) {
			// 차트 데이터를 가지고 와서 배열에 넣는 작업을 each로 돌림
			var arr = new Array();
			arr.push("금액");
			arr.push("월별");
			chartData2.push(arr);
			$(data).each(function(){
				var arr = new Array();
				arr.push(this.months);
				arr.push(this.income);
				chartData2.push(arr);
			})
		}
	})
	$.ajax({
		type : 'get',
		url : '/admin/bestCamping.json',
		dataType : 'json',
		success : function(data) {
			// 차트 데이터를 가지고 와서 배열에 넣는 작업을 each로 돌림
			var arr = new Array();
			arr.push("캠핑장명");
			arr.push("금액");
			chartData3.push(arr);
			$(data).each(function(){
				var arr = new Array();
				arr.push(this.camp_name);
				arr.push(this.sumIncome);
				chartData3.push(arr);
			})
		}
	})
	$.ajax({
		type : 'get',
		url : '/admin/worstCamping.json',
		dataType : 'json',
		success : function(data) {
			// 차트 데이터를 가지고 와서 배열에 넣는 작업을 each로 돌림
			var arr = new Array();
			arr.push("캠핑장명");
			arr.push("월별");
			chartData4.push(arr);
			$(data).each(function(){
				var arr = new Array();
				arr.push(this.camp_name);
				arr.push(this.sumIncome);
				chartData4.push(arr);
			})
		}
	})
}
</script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawVisualization);

	function drawVisualization() {
		// Some raw data (not necessarily accurate)
		var data = google.visualization.arrayToDataTable(chartData);

		var options = {
			title : '캠핑 일일 매출 현황',
			vAxis : {
				title : '금액'
			},
			hAxis : {
				title : '일일'
			},
			seriesType : 'bars'
		};

		var chart = new google.visualization.ComboChart(document
				.getElementById('chart_div'));
		chart.draw(data, options);
	}
</script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawVisualization);

	function drawVisualization() {
		// Some raw data (not necessarily accurate)
		var data = google.visualization.arrayToDataTable(chartData2);

		var options = {
			title : '캠핑 월별 매출 현황',
			vAxis : {
				title : '금액'
			},
			hAxis : {
				title : '월별'
			},
			seriesType : 'bars'
		};

		var chart = new google.visualization.ComboChart(document
				.getElementById('chart_div2'));
		chart.draw(data, options);
	}
</script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawVisualization);

	function drawVisualization() {
		// Some raw data (not necessarily accurate)
		var data = google.visualization.arrayToDataTable(chartData3);

        var options = {
                title: '베스트 캠핑 5',
                pieHole: 0.4,
              };

		var chart = new google.visualization.PieChart(document
				.getElementById('chart_div3'));
		chart.draw(data, options);
	}
</script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawVisualization);

	function drawVisualization() {
		// Some raw data (not necessarily accurate)
		var data = google.visualization.arrayToDataTable(chartData4);

        var options = {
                title: '워스트 상품 5',
                pieHole: 0.4,
              };

		var chart = new google.visualization.PieChart(document
				.getElementById('chart_div4'));
		chart.draw(data, options);
	}
</script>