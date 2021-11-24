<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<style>


	input[name=style_no]{
	width:20px;
	}
	#files{
		overflow: hidden;
		margin: 20px;
	}
	#files .attachBox{
		float: left;
		margin-left: auto;
		margin-right:auto;
		padding: 10px;
	}
	#image{
		box-shadow:2px 2px 2px 2px #f2f2f2;

	}
	input[type=radio]{
		margin: 5px 10px 5px 10px;
		width:13px;
		height:13px;
	}
	input[type=checkbox]{
		margin: 5px 10px 5px 10px;
		width:13px;
		height:13px;
	}
</style>
<div id="sub">
	<div class="subheading">캠핑장 정보</div>
	<form name="frm" enctype="multipart/form-data">
		<h4>대표이미지</h4>
		<img src="/camping/display?file=${cvo.camp_image}" id="image" width=300>
		<!-- 기존 이미지 -->
		<input type="hidden" name="camp_image" value="${cvo.camp_image}" style="display:none"/> 
		<input type="file" name="file" style="display:none;"/>
		<div>
		<h4>첨부이미지</h4>
		<input type="file" name="files"  acceept="image/*" multiple/>
		</div>
		<div id="files">
			<c:forEach items="${attList}" var="camp_image">
			<div class="attachBox">
				<img src="/camping/display?file=${camp_image}" width=150 height=150 />
				<a href="${camp_image}">삭제</a>
			</div>
			</c:forEach>
		</div>
	<div class="divider"></div>
	<table class="tbl_body1">
		<tr>
			<th class="tbl_head">캠핑장 번호</th>
			<td class="tbl_data"><input type="text" name="camp_id" value="${cvo.camp_id}" readonly/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 이름</th>
			<td class="tbl_data"><input type="text" name="camp_name" value="${cvo.camp_name}"/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 운영사</th>
			<td class="tbl_data"><input type="text" name="camp_maker" value="${cvo.camp_maker}"/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 주소</th>
			<td class="tbl_data"><input type="text" name="camp_addr" value="${cvo.camp_addr}" onclick="search()"/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 전화번호</th>
			<td class="tbl_data"><input type="text" name="camp_tel" value="${cvo.camp_tel}"/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 설명</th>
			<td class="tbl_data"><textarea name="camp_detail" cols="80" rows="8">${cvo.camp_detail}</textarea></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 기타 편의사항</th>
			<td class="tbl_data"><input type="text" name="camp_memo" value="${cvo.camp_memo}"/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 예약 가능여부</th>
			<td class="tbl_data">
			<c:choose> 
				<c:when test="${cvo.camp_status eq 0}">
					<input type="radio" name="camp_status" value="${cvo.camp_status}" checked/>&nbsp예약가능
					<input type="radio" name="camp_status" value="1"/>&nbsp예약불가능
				</c:when> 
				<c:otherwise>
					<input type="radio" name="camp_status" value="0"/>&nbsp예약가능
					<input type="radio" name="camp_status" value="${cvo.camp_status}" checked/>&nbsp예약불가능
				</c:otherwise>
			</c:choose> 
			</td>
		</tr>
	</table>
	<table class="tbl_body2">
		<tr>
			<th class="tbl_head2">캠프 시설</th>
		</tr>
		<tr>
			<td class="tbl_data2">
			<c:forEach items="${facilityList}" var="facilityItem" >
				<button class="facilities">${facilityItem.facility_name}</button>
			</c:forEach>
			</td>
		</tr>
		<tr>
			<th class="tbl_head2">캠프 시설 수정하기</th>
		</tr>
		<tr>
			<td class="tbl_data2">
			<c:forEach items="${fList}" var="fItem" >
				<c:if test="${fItem.facility_no ne 0}">
					<input type="checkbox" name="facility_no" value="${fItem.facility_no}">&nbsp${fItem.facility_name}
				</c:if>
			</c:forEach>
			</td>
		</tr>
	</table>
	<table class="tbl_body3" id="campStyleList">
		<tr>
			<th class="tbl_head3" colspan="4">캠프 스타일</th>
		</tr>
		<c:forEach items="${styleList}" var="styleItem">
			<tr>
				<td class="tbl_data3" colspan="4">${styleItem.style_name} ${styleItem.style_qty}개 (${styleItem.style_price} 원 / 박)</td>
			</tr>
		</c:forEach>
		<tr>
			<th class="tbl_head3" colspan="4">캠프 스타일 수정하기</th>
		</tr>
		<c:forEach items="${sList}" var="sItem">
			<tr class="campStyleItem">
				<td class="tbl_data3"><input class="style_no" type="checkbox" name="style_no" value="${sItem.style_no}"></td>
				<td class="tbl_data3">${sItem.style_name}</td>
				<td class="tbl_data3"><input class="style_qty" type="text" name="style_qty" placeholder="숫자만 입력하세요."/></td>
				<td class="tbl_data3"><input class="style_price" type="text" name="style_price" placeholder="가격을 입력하세요."/></td>
			</tr>
		</c:forEach>
	</table>
	<input type="submit" class="blackBtn" value="캠핑장 수정"/>
	<input type="reset" class="whiteBtn" value="등록 취소"/>
</form>
</div>
<script>
	// 주소 검색 버튼을 눌렀을때
	function search(){
		new daum.Postcode({
			oncomplete:function(data){
				$(frm.camp_addr).val(data.address);
			}
		}).open();
	};
	
	// 이미지 테그 클릭시
	$("#image").on("click",function(){
		$(frm.file).click();
	})
	
	// 이미지를 삽입하거나 변경시
	$(frm.file).on("change",function(e){
		var file=$(this)[0].files[0];
		$("#image").attr("src",URL.createObjectURL(file));
	})
	
	// 첨부파일 삭제
	$("#files").on('click','.attachBox a',function(e){
		e.preventDefault();
		if(!confirm("첨부파일을 삭제하시겠습니까?"))return;
		var box=$(this).parent();
		var camp_image=$(this).attr("href");
		$.ajax({
			type:'post',
			url:'/camping/attDelete',
			data:{camp_image:camp_image},
			success:function(){
				alert("삭제되었습니다.");
				box.remove();
			}
		})
	});
	
	// 첨부파일을 추가할 경우
	$(frm.files).on('change',function(){
		var camp_id="${cvo.camp_id}";
		var file=$(this)[0].files[0];
		if(file==null) return;
		if(!confirm("파일을 첨부하시겠습니까?")) return;
		var formData = new FormData();
		formData.append("file",file);
		formData.append("camp_id",camp_id);
		$.ajax({
			type:"post",
			url:"/camping/attInsert",
			data:formData,
			processData:false,
			contentType:false,
			success:function(data){
				var str='<div class="attachBox">'
				str+='<img src="/camping/display?file='+data+'" width=250 />'
				str+='<a href="'+data+'">삭제</a>'
				str+='</div>'
				$('#files').append(str);
			}
		})
	});
	
	// submit시 유효성 체크
	$(frm).on("submit",function(e){
		e.preventDefault();
		
		// 데이터 값 가지고 오기
		var camp_id=$(frm.camp_id).val();
		var camp_name=$(frm.camp_name).val();
		var camp_maker=$(frm.camp_maker).val();
		var camp_addr=$(frm.camp_addr).val();
		var camp_tel=$(frm.camp_tel).val();
		var camp_detail=$(frm.camp_detail).val();
		var camp_memo=$(frm.camp_memo).val();
		var camp_image=$(frm.camp_image).val();
		var file = $(frm.file).val();
		var camp_status=$("input:radio[name=camp_status]:checked").val();
		
		// 시설 데이터 체크
		var obj = $("[name=facility_no]");
        var facility_no = new Array(); // 배열 선언
 
        $('input:checkbox[name=facility_no]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
        	facility_no.push(this.value);
        });
       	
       	// 캠핑 스타일 체크
       	var style_no = new Array(); // 배열 선언
		$('input:checkbox[name=style_no]:checked').each(function(){ // 체크된 체크박스의 value 값을 가지고 온다.
			style_no.push(this.value);
		});
       	
       	// 캠핑 스타일 갯수
       	var style_qty = new Array(); // 배열 선언
       	$('input[name=style_qty]').each(function(){
		    var style_val=$(this).val();
			if(style_val>0){
				style_qty.push(style_val);
			}
    	});
       	
       	// 캠핑 스타일별 가격
       	var style_price = new Array(); // 배열 선언
       	$('input[name=style_price]').each(function(){
		    var sprice=$(this).val();
			if(sprice>0){
				style_price.push(sprice);
			}
    	});
		
		if(!confirm("상품을 수정하시겠습니까?"))return;
		frm.action="/camping/update"
		frm.method="post"
		frm.submit();
	});
</script>