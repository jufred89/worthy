<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<h3>내 정보 변경</h3>
<div>
    <!-- 정보 변경 -->
    <form name="frm" >   
      <input type="text" name="uid" value="${vo.uid }" readonly /><br>
       <input type="password" name="upass" placeholder="변경 비밀번호"/><br>
      <input type="password" name="passcheck" placeholder="변경 비밀번호확인"/><br>
      <input type="email" name="umail" placeholder="이메일" value="${vo.umail }"/><br>
      <input type="text" name="uname" value="${vo.uname }" readonly/><br>
      <input type="text" name="address" placeholder="주소" value="${vo.address }"/><br>
      <input type="text" name="tel" placeholder="번호" value="${vo.tel }"/><br>
     
      <input type="submit" value="회원 정보 수정">
    </form>

  </div>
  <script>
  //유효성 검사
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
    
	if(upass==""){
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
    }else if(uname==""){
        $(frm.uname).focus();
        alert("이름를 입력하세요!");
        return;
     }else if(tel==""){
    	$(frm.tel).focus();
    	alert("전화번호를 입력하세요")
    	return;
    }else if(!tel_rule.test(tel)){
    	alert("전화번호사이에'-'를 입력해주세요")
    	return false;
    }if(!confirm("회원 정보를 수정하시겠습니까?")) return;
    
    frm.action="/myinfo/update";
    frm.method="post";
    frm.submit();
 });
  
  </script>