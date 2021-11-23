<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="sub">
	<div class="subheading">회원정보확인</div>

	<form name="frm" id="checkfrm">
		<div class="inputs">아이디</div><input type="text" value="${uid }"/><br>
		<div class="inputs">비밀번호</div><input type="password" name="upass"/><br/>	
		<div id="checkfrmBtns">
			<input type="submit" class="blackBtn" value="확인"/>
			<input type="reset" class="whiteBtn" value="취소"/>
		</div>
	</form>
</div>

<script>
	$(frm).on('submit',function(e){
		e.preventDefault();
		var upass = $(frm.upass).val();
		if(upass==""){
			alert('비밀번호를 입력해주세요');
			$(frm.upass).focus();
			return;
		}
		
		$.ajax({
			type:'post',
			url:'/checkMyinfo',
			data:{"upass":upass},
			success:function(data){
				if(data==1){
					location.href='/myinfo';
				}else{
					alert('비밀번호가 일치하지 않습니다.');
				}
			}
		});
	});
</script>