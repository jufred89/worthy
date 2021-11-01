<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>어디로 떠날까요?</h1>
<button>지역별</button>
<input type="text" id="search" placeholder="원하는 지역을 입력 후 엔터를 누르세요" size=80/>
<script>
	$('#search').on('keypress',function(e){
		if(e.keyCode==13){
			location.href='/camping/list';
		}
	})
</script>
