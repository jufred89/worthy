<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="sub">
	<div class="subheading">회원 정보</div>
<form name="frm" action="/user/update" method="post" >
	<table id="tbl_body1">
		<tr>
			<th class="tbl_head">아이디</th>
			<td colspan="3"class="tbl_data"><input type="text" name="uid" value="${vo.uid}" readonly size="80px" /></td>
		</tr>
		<tr>
			<th class="tbl_head">이메일</th>
			<td colspan="3" class="tbl_data"><input type="text" name="umail" value="${vo.umail}" size="80px"/></td>
		</tr>
		<tr>
			<th class="tbl_head">전화번호</th>
			<td colspan="3" class="tbl_data"><input type="text" name="tel" value="${vo.tel}" size="80px"/></td>
		</tr>
		<tr>
			<th class="tbl_head">주소</th>
			<td class="tbl_data"><input type="text" id ="road" name="address" value="${vo.address}"size="46px"/></td>
			<td><input type="button" onclick="search()" value="주소검색"></td>
			<span id="guide" style="color:#999;display:none"></span>
			<td class="tbl_data"><input type="text" id ="detail" name="detail" value="${vo.detail}"/></td>
		</tr>
		<tr>
			<th class="tbl_head">이름</th>
			<td colspan="3" class="tbl_data"><input type="text" name="uname" value="${vo.uname}" size="80px"/></td>
		</tr>

	</table>
	<input type="submit" class="blackBtn" value="회원정보수정"/>
	<input type="reset" class="whiteBtn" value="수정 취소"/>
</form>
</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function search() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("road").value = roadAddr;
                

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<script>

$(frm).on("submit", function(e){
	   var email_rule = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	   var tel_rule =  /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;
	   e.preventDefault();

	    var uid=$(frm.uid).val();
	    var tel=$(frm.tel).val();
	    var umail=$(frm.umail).val();
	    var uname=$(frm.uname).val();
	    var detail= $(frm.detail).val();
		var address = $(frm.address).val() + " " + detail;
		
	    if(uid==""){
	       alert("아이디를 입력하세요!");
	       $(frm.uid).focus();
	       return;
	    }else if(umail==""){
	        $(frm.umail).focus();
	        alert("메일주소를 입력하세요!");
	        return;
	    }else if(!email_rule.test(umail)){
	            alert("이메일을 형식에 맞게 입력해주세요.");
	          return false;
	    }else if(tel==""){
	       $(frm.tel).focus();
	       alert("전화번호를 입력하세요")
	       return;
	    }else if(!tel_rule.test(tel)){
	       alert("전화번호사이에'-'를 입력해주세요")
	       return false;
	    }else if(address=="  "){
	      alert("주소를 입력해주세요")          
	       return;
	    }else if(uname==""){
	       $(frm.uname).focus();
	       alert("이름를 입력하세요!");
	       return;
	    }if(!confirm("회원 정보를 수정 하시겠습니까?")) return;
	 
	    frm.action="/admin/user/update";
	    frm.method="post";
	    frm.submit();
	 });
</script>