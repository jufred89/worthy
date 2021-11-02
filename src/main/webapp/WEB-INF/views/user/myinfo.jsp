<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h3>내 정보 변경</h3>
<div>
    <!-- 정보 변경 -->
    <form name="frm" >   
      <input type="text" name="id" value="user01" readonly /><br>
      <input type="email" name="email" placeholder="이메일" value="user01@gmail.com"/><br>
      <input type="text" name="name" placeholder="이름" value="홍길동"/><br>
      <input type="password" name="password" placeholder="변경 비밀번호"/><br>
      <input type="password" name="passcheck" placeholder="변경 비밀번호확인"/><br>
     
      <input type="submit" value="회원 정보 수정">
    </form>

  </div>