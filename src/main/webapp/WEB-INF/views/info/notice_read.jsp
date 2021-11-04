<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<style>
	#divRead{
		width:960px;
		margin:0 auto;
	}
	#list{
		float:right;
		margin:15px;
	}
</style>
<h1>공지사항 읽기</h1>
<div id="divRead">
	<h3>${vo.nb_no} . ${vo.nb_title}</h3>
	<div>${fn:replace(vo.nb_content, replaceChar, "<br/>")}</div>
	
	<button id="list" onClick="location.href='/notice/list'">목록</button>
</div>
