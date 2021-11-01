<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>상품 정보 페이지</h1>

<div>
	<img src="http://placehold.it/300x300" />
	<div>
		<h2>${vo.prod_name }</h2>
		<p>${vo.prod_detail }</p>
		<span>총 상품금액</span><span>${vo.prod_normalprice }</span>
	</div>
</div>
