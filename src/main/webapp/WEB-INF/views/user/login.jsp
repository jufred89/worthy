<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>

<link rel="stylesheet" href="../resources/login.css" />
<div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="first" style="margin:50px;">
    <h1>Worthy로 들어오세요!</h1>
    </div>

    <!-- Login Form -->
    <form action="post" id="login" name="frm">
      <input type="text" id="uid" class="fadeIn second" name="login" placeholder="id">
      <input type="text" id="upass" class="fadeIn third" name="login" placeholder="password">
      <input type="checkbox" name="chkLogin"/>
      <h4>로그인 상태 유지</h4>
      <input type="submit" class="fadeIn fourth" value="Log In">
    </form>

    <!-- Remind Passowrd -->
    <div id="formFooter">
      <a class="btn btn-default" href="/join">회원가입</a>
    </div>

  </div>
</div>
<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		var uid=$(frm.uid).val();
		var upass=$(frm.upass).val();
		var isLogin=$(frm.chkLogin).is(":checked") ? true: false;
		
		if(uid=="" || upass==""){
			alert("아이디와 비밀번호를 입력하세요!");
			return;
		}
		
		$.ajax({
			type: "post",
			url: "/user/login",
			data: {"uid": uid, "upass":upass, "isLogin": isLogin},
			success: function(data){
				if(data==0){
					alert("아이디가 존재하지 않습니다!");
				}else if(data==2){
					alert("비밀번호가 일치하지 않습니다!")
				}else{
					var dest="${dest}";
					if(dest==null || dest=="") dest="/";
					location.href=dest;
				}
			}
		});
	});

</script>