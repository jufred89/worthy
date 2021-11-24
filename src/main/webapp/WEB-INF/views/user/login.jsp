<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../resources/bootstrap-datepicker.js"></script>
<link rel="stylesheet" href="../resources/bootstrap-datepicker.css">

<link rel="stylesheet" href="../resources/login.css" />
<style>
#center{
padding:0;
}
 #login_back{

 position: relative;
	background-image: url("../resources/nightcamp.jpg");
	/* background:black; */
	background-size: 100% 100%;
	 background-position: center center;
	height: 100%;
	
	background-repeat: no-repeat;

	
} 
.space{
height:200px;
}
</style>
<div id="login_back">
<div class="wrapper fadeInDown">
<div class="first" style="margin:30px;position: relative;top:50px; ">
    <img alt="" src="../resources/logowhite2.png" style="width:100; ">
   
  
    </div>

  <div id="formContent">
    <!-- Tabs Titles -->
	<h2>LOGIN</h2>
    <!-- Icon -->

    <!-- Login Form -->
    <form action="post" id="login" name="frm">
      <input type="text" id="uid" class="fadeIn second" name="uid" placeholder="ID">
      <input type="password" id="upass" class="fadeIn third" name="upass" placeholder="Password">
      <h5><label>로그인 상태유지</label><input type="checkbox" name="chkLogin"/></h5> 
      <input type="submit" class="fadeIn fourth" value="Log In">
    </form>

    <!-- Remind Passowrd -->
    <div id="formFooter">
      <a class="btn btn-default" href="/join">회원가입</a>
    </div>
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
				}else if(data==3){
					location.href='/admin';
					
				}else{
				
					var dest="${dest}";
					if(dest==null || dest=="") dest="/";
					
				location.href=dest;
				}
			}
		});
	});
	

</script>