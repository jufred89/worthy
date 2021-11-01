<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#read img{
		border-radius: 10px;
	}
</style>    
   
<h1>상품 정보 페이지</h1>

<div id="read">
	<img src="/shop/display?file=${vo.prod_image}" />
	<div>
		<h2>${vo.prod_name }</h2>
		<p>${vo.prod_detail }</p>
		<span>총 상품금액</span><span>${vo.prod_normalprice }</span>
	</div>
</div>
<div>
	상품 추천 슬라이드
</div>
<div>
	상품 상세 설명
</div>
<div>
	상품 이미지
</div>
