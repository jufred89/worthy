<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	@font-face {
    font-family: 'IBMPlexSansKR-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-07@1.0/IBMPlexSansKR-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

#cancel{
 font-family: 'IBMPlexSansKR-Regular';
 text-align:center;
 margin-top:130px;
}

.blackBtn{
	font-size:85%;
	padding:8px 26px;
	background-color:black;
	color:white;
	border:none;
	margin-top:25px;
}

</style>
</head>
<body>
	<div id="cancel">
		<h1>Cancel</h1>
		<h3>결제가 취소되었습니다.</h3>
		<button class="blackBtn" 
				onclick="opener.parent.location.reload(); self.close() ">닫기</button>
	</div>

	
</body>
</html>