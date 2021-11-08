<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="../resources/join.css" />
<div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="first" style="margin:50px;">
    <h2>Worthy Family가 되어주세요!</h2>
    </div>

    <!-- Login Form -->
    <form action="post" id="join" name="frm">
   	  <div>
     	 <input type="text" id="uid" class="fadeIn second" name="uid" placeholder="아이디" >
    	 <input type="button" value="중복체크" id="chkid"/>
      </div>
      <input type="password" id="upass" class="fadeIn third" name="upass" placeholder="비밀번호">
      <input type="password" id="passcheck" class="fadeIn third" name="passcheck" placeholder="비밀번호확인">
      <input type="email" id="umail" class="fadeIn second" name="umail" placeholder="이메일" >
      <input type="text" id="uname" class="fadeIn second" name="uname" placeholder="성함" >
      <input type="text" id="tel" class="fadeIn second" name="tel" placeholder="연락처" >
      
      <input type="text" id="address" class="fadeIn second" name="address" placeholder="주소" >
     
      <input type="submit" class="fadeIn fourth" value="Join Us">
    </form>

  

  </div>
</div>
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
    var uname=$(frm.uname).val();
    var address=$(frm.address).val();
    var tel=$(frm.tel).val();
    var umail=$(frm.umail).val();
    var passcheck=$(frm.passcheck).val();
    
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
    }else if(uname==""){
       $(frm.uname).focus();
       alert("이름를 입력하세요!");
       return;
    }if(!confirm("회원 등록을 하시겠습니까?")) return;
   
    frm.action="/user/join";
    frm.method="post";
    frm.submit();
 });
</script>
