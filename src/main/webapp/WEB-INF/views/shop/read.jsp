<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<a href="/shop/update?prod_id=${vo.prod_id}">업데이트 페이지 이동 버튼 위치는 관리자페이지로 옮길 예정</a>
<h1>상품 정보 페이지</h1>

<div>
	<img src="/shop/display?file=${vo.prod_image}" />
	<div>
		<h3>${vo.prod_name }</h3>
		<p>${vo.prod_normalprice }</p>
		<p>무료배송</p>
		<div>
			<button>장바구니</button>
			<button>구매하기</button>
		</div>
	</div>
</div>
<div>
	<h3>상품 추천 슬라이드</h3>
</div>
<div>
	<table>
		<tr>
			<td class="">제품명</td>
			<td>상품 상세페이지 참조</td>
			<td class="">식품의 유형</td>
			<td>상품 상세페이지 참조</td>
		</tr>
		<tr>
			<td class="">생산자 및 소재지</td>
			<td>상품 상세페이지 참조</td>
			<td class="">제조연월일, 유통기한 또는 품질유지기한</td>
			<td>상품 상세페이지 참조</td>
		</tr>
		<tr>
			<td class="">포장단위별 내용물의 용량(중량), 수량</td>
			<td>상품 상세페이지 참조</td>
			<td class="">원재료명 및 함량</td>
			<td>상품 상세페이지 참조</td>
		</tr>
	</table>
</div>
<div>
	<h3>상품 상세 페이지(이미지)</h3>
</div>
