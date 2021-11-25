<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<div id="sub">
	<div class="subheading">캠핑매출현황</div>
	<hr />
	<div id="chart_div" style="width: 1000px; height: 500px;"></div>
</div>
</body>
<script>
getList();
var chartData = new Array();

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