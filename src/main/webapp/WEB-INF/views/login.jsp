<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../resources/login.css" />
<div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="first" style="margin:50px;">
    <h1>Worthy로 들어오세요!</h1>
    </div>

    <!-- Login Form -->
    <form id="login">
      <input type="text" id="login" class="fadeIn second" name="login" placeholder="id">
      <input type="text" id="password" class="fadeIn third" name="login" placeholder="password">
      <input type="submit" class="fadeIn fourth" value="Log In">
    </form>

    <!-- Remind Passowrd -->
    <div id="formFooter">
      <a class="btn btn-default" href="/join">회원가입</a>
    </div>

  </div>
</div>