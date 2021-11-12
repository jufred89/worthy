<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<h3>캠핑장 등록</h3>
<style>
	.tbl_body1{
	margin: 0px auto;
	margin-bottom: 20px;
	}
	.tbl_head{
	width: 200px;
	padding: 5px;
	}
	.tbl_data{
	width: 400px;
	}
	.tbl_data input{
	width: 100%;
	border:none;
	}
	.tbl_body2{
	width:600px;
	margin: 0px auto;
	margin-bottom: 20px;
	}
	.tbl_head2{
	padding: 5px;
	}
	.tbl_data2{
	padding: 5px;
	}
	.tbl_body3{
	width:600px;
	margin: 0px auto;
	margin-bottom: 20px;
	}
	.tbl_head3{
	padding: 5px;
	}
	.tbl_data3{
	padding: 5px;
	}
	.tbl_data3 input{
	width: 100%;
	border:none;
	}
</style>
<hr />
	<form name="frm" action="/camping/insert" method="post" enctype="multipart/form-data">
	<img src="http://placehold.it/300x250" id="image" width=400>
	<input type="file" name="file" style="display:none;"/>
<hr />
	<table class="tbl_body1" border="1">
		<tr>
			<th class="tbl_head">캠핑장 번호</th>
			<td class="tbl_data"><input type="text" name="camp_id" value="${camp_id}" readonly/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 이름</th>
			<td class="tbl_data"><input type="text" name="camp_name" placeholder="캠핑장 이름"/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 운영사</th>
			<td class="tbl_data"><input type="text" name="camp_maker" placeholder="캠핑장 운영사"/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 주소</th>
			<td class="tbl_data"><input type="text" name="camp_addr" placeholder="캠핑장 주소" onclick="search()"/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 전화번호</th>
			<td class="tbl_data"><input type="text" name="camp_tel" placeholder="캠핑장 전화번호"/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 설명</th>
			<td class="tbl_data"><input type="text" name="camp_detail" placeholder="캠핑장 설명"/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 기타 편의사항</th>
			<td class="tbl_data"><input type="text" name="camp_memo" placeholder="캠핑장 기타 편의사항"/></td>
		</tr>
		<tr>
			<th class="tbl_head">캠핑장 가격</th>
			<td class="tbl_data"><input type="text" name="camp_price" placeholder="캠핑장 가격"/></td>
		</tr>
	</table>
	<table class="tbl_body2" border="1">
		<tr>
			<th class="tbl_head2">캠프 시설</th>
		</tr>
		<tr>
			<td id="campFacilityList" class="tbl_data2">
			</td>
		</tr>
	</table>
	<table class="tbl_body3" border="1" id="campStyleList">
		<tr>
			<th class="tbl_head3" colspan="3">캠프 스타일</th>
		</tr>
	</table>
	<input type="submit" value="캠핑장 등록"/>
	<input type="reset" value="등록 취소"/>
</form>
<!-- 캠핑 시설명 목록 가지고 오기 -->
<script id="temp1" type="text/x-handlebars-template">
		{{#each .}}
			<input type="checkbox" name="facility_no" value="{{facility_no}}">&nbsp{{facility_name}}
		{{/each}}
</script>
<!-- 캠핑 스타일명 목록 가지고 오기 -->
<script id="temp2" type="text/x-handlebars-template">
		{{#each .}}
			<tr>
				<td class="tbl_data3"><input class="style_no" type="checkbox" name="style_no" value="{{style_no}}"></td>
				<td class="tbl_data3">{{style_name}}</td>
				<td class="tbl_data3"><input class="style_qty" type="text" name="style_qty" placeholder="숫자만 입력하세요."/></td>
			</tr>
		{{/each}}
</script>
<script>
	getCampFacility();
	getCampStyle();
	
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
	
	// 특정 캠핑 시설명 목록 가지고 오기
	function getCampFacility(){
		$.ajax({
			type:"get",
			url:"/camping/campFacilitylist.json",
			dataType:"json",
			success:function(data){
				var temp1 = Handlebars.compile($('#temp1').html());
				$('#campFacilityList').html(temp1(data));
			}
		})
	}
	
	// 특정 캠핑 스타일명 목록 가지고 오기
	function getCampStyle(){
		$.ajax({
			type:"get",
			url:"/camping/campStylelist.json",
			dataType:"json",
			success:function(data){
				var temp2 = Handlebars.compile($('#temp2').html());
				$('#campStyleList').append(temp2(data));
			}
		})
	}
	
	// submit시 유효성 체크
	$(frm).on("submit",function(e){
		e.preventDefault();
		
		// 데이터 값 가지고 오기
		var camp_id=$(frm.camp_id).val();
		var camp_name=$(frm.camp_name).val();
		var camp_maker=$(frm.cam_maker).val();
		var camp_addr=$(frm.camp_id).val();
		var camp_tel=$(frm.camp_tel).val();
		var camp_detail=$(frm.camp_detail).val();
		var camp_price=$(frm.camp_price).val();
		var file = $(frm.file).val();

        // 데이터 값 null 확인
		if(camp_name==""||camp_maker==""||camp_addr==""||camp_tel==""||camp_detail==""||file==""){
			alert("입력란을 확인해주세요.");
			return;
		}
		
		// 시설 데이터 체크
		var obj = $("[name=facility_no]");
        var facility_no = new Array(); // 배열 선언
 
        $('input:checkbox[name=facility_no]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
        	facility_no.push(this.value);
        });
        
       	if(facility_no.length===0){
       		alert("캠핑 시설란을 확인해주세요.");
       		return;
       	}
       	
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
		
       	if(style_no.length===0 || style_qty.length===0){
       		alert("캠핑 스타일란을 확인해주세요.");
       		return;
       	}

		// 가격 숫자 유효성 체크
		if (camp_price == '' || camp_price.replace(/[0-9]/g, '')) {
			alert('가격을 숫자로 입력하세요.');
			$(frm.price).focus();
			return;
		}
		
		if(!confirm("상품을 등록하시겠습니까?"))return;
		frm.action="/camping/insert"
		frm.method="post"
		frm.submit();

	});
</script>