<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>회원정보확인</h1>
<form name="frm">
	<span>아이디</span><input type="text" value="${uid }"/><br>
	<span>비밀번호</span><input type="password" name="upass"/><br/>
	<input type="submit" value="확인"/>
	<input type="reset" value="취소"/>
</form>

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