<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<style>
	#divRead{
		width:960px;
		margin:0 auto;
	}
	#recipe{
		display:inline-block;
	}
	#list{
		float:right;
		margin:15px;
	}
</style>
<h1>팁 읽기</h1>
<div id="divRead">
	<div id="recipe">
		<img src="http://placehold.it/300x300"/><h3>${vo.tip_no} : ${vo.tip_title}</h3>
		<div>${fn:replace(vo.tip_content, replaceChar, "<br/>")}</div>
	</div>
	<button id="list" onClick="location.href='/tip/list'">목록</button>
	
</div>