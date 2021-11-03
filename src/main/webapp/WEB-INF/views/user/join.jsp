<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
   
      <input type="text" id="uid" class="fadeIn second" name="uid" placeholder="아이디" >
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
	$(frm).on("submit", function(e){
		e.preventDefault();
		var uid=$(login.uid).val();
		var upass=$(login.upass).val();
		
		if(uid=="" || upass==""){
			alert("아이디와 비밀번호를 입력하세요!");
			return;
		}
		
		$.ajax({
			type: "post",
			url: "/user/join",
			data: {"uid": uid, "upass":upass,"umail":umail,"uname":uname,"tel":tel,"address":address},
			success: function(data){
				if(data==0){
					alert("아이디가 존재하지 않습니다!");
				}else if(data==2){
					alert("비밀번호가 일치하지 않습니다!")
				}else{
					var dest="${dest}";
					if(dest==null || dest=="") dest="/";
					location.href="/";
				}
			}
		});
	});

</script>
