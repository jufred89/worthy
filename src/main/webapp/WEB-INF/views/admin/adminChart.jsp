<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawVisualization);

	function drawVisualization() {
		// Some raw data (not necessarily accurate)
		var data = google.visualization.arrayToDataTable(chartData); <<<---

		var options = {
			title : '강좌 점수 그래프',
			vAxis : {
				title : '점수'
			},
			hAxis : {
				title : '강좌명'
			},
			seriesType : 'bars'
		};

		var chart = new google.visualization.ComboChart(document
				.getElementById('chart_div'));
		chart.draw(data, options);
	}
</script>
</head>
<body>
	<div id="chart_div" style="width: 900px; height: 500px;"></div>
</body>
</html>