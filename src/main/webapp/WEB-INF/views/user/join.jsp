<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="../resources/bootstrap-datepicker.js"></script>
<link rel="stylesheet" href="../resources/bootstrap-datepicker.css">
<link rel="stylesheet" href="../resources/join.css" />
<style>

.space{
height:200px;
}

#join_back{
position: relative;
margin:0;
padding:0;
	background-image: url("../resources/lightcamp.jpg");
	/* background:black; */
	background-size: cover;
	 background-position: center center;
	height: 100%;

	background-repeat: no-repeat;
 overflow-y: scroll;
  -ms-overflow-style: none;
  
}
#join_back::-webkit-scrollbar{ display:none; }

#center{
padding:0;
}
</style>
<div id="join_back">

<div class="wrapper fadeInDown">
<div class="first" style="margin:30px;position: relative;top:50px; ">
    <img alt="" src="../resources/worthycamping_logo_sample1.png" style="width:100; ">
  
    </div>
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    

    <!-- Login Form -->
    <form action="post" id="join" name="frm">
      <h1 style="margin-top:30px;"><b>JOIN</b></h1>
      <div>
      <div>
        <div class="title">아이디</div>
     
        <input type="text" id="uid" class="fadeIn second" name="uid" placeholder="아이디" style="width:250px;">
        <input type="button" value="중복체크" id="chkid" style="margin-left:5px;"/>
        
      </div>
	      
	    <div class="title">비밀번호</div>
	   
      	<input type="password" id="upass" class="fadeIn third" name="upass" placeholder="비밀번호" style="width:400px;">
      	<input type="password" id="passcheck" class="fadeIn third" name="passcheck" placeholder="비밀번호확인" style="width:400px;" >
    
      <div class="title">이메일</div>
      <input type="email" id="umail" class="fadeIn second" name="umail" placeholder="이메일" style="width:400px;">
      <div class="title">이름</div>
      <input type="text" id="uname" class="fadeIn second" name="uname" placeholder="성함" style="width:400px;">
      <div class="title">전화번호</div>
      <input type="text" id="tel" class="fadeIn second" name="tel" placeholder="연락처"style="width:400px; ">
     
     <div id="addr">
     	<div class="title" style="margin-right:0;">주소</div>
     	<div style="text-align:left;margin-left:60px;"><input type="button" onclick="search()" value="주소검색"><br></div>
     	<input type="text" id="road" name="address" placeholder="도로명주소" style="width:400px;">
     	<span id="guide" style="color:#999;display:none"></span>
    	<input type="text" id="detail" name="detail" placeholder="상세주소" style="width:400px;">
     </div>
     </div>
      <input type="submit" class="fadeIn fourth" value="Join Us" style="width:300px;">
    </form>

  

  </div>
  <div class="space"></div>
</div>
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

var chkid = 0;
$("#chkid").on("click",function(){
    var uid=$(frm.uid).val();
    
    if(uid==""){
       alert("아이디를 입력하세요");
       return;
    }
    
    $.ajax({
       type:"post",
       url: "/user/chkid",
       data: {"uid": uid},
       success : function(result){ 
         if(result > 0 ){
            alert('이미 사용중인 아이디입니다.');
         } else{
            alert('사용가능한 아이디입니다.');
            chkid =1;
         }
       }
    });
});


$(frm).on("submit", function(e){
   var email_rule = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
   var tel_rule =  /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/;
   e.preventDefault();

    var uid=$(frm.uid).val();
    var upass=$(frm.upass).val();
    var tel=$(frm.tel).val();
    var umail=$(frm.umail).val();
    var passcheck=$(frm.passcheck).val();
    var detail= $(frm.detail).val();
	var address = $(frm.address).val() + " " + detail;
    
    if(uid==""){
       alert("아이디를 입력하세요!");
       $(frm.uid).focus();
       return;
    } else if(chkid==0){
       alert("아이디 중복체크를 하세요.");
       return;
    }else if(upass==""){
       $(frm.upass).focus();
       alert("비밀번호를 입력하세요!");
       return;
    }else if(upass!=passcheck){
       $(frm.passcheck).focus();   
       alert("비밀번호가 일치하지 않습니다.");
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
    }if(!confirm("회원 등록을 하시겠습니까?")) return;
      
    alert(address);
    frm.action="/user/join";
    frm.method="post";
    frm.submit();
    location.href='/user/login'
 });
</script>
