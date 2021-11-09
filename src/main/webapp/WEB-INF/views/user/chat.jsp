<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>1:1 문의</title>
<link rel="stylesheet" href="/resources/chat.css" />
﻿<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>﻿
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<style>
	#close{
		float:right;
		margin-right:15px;
	}
</style>
</head>
<body>
<div class="chat_wrap">
		<div class="header">1:1문의 ( ${chat_room} ) <span id="close">채팅닫기</span></div>
		<div id="chat"></div>
      <script id="temp" type="text/x-handlebars-template">
      {{#each .}}
           	<div class="{{printLeftRight chat_id}}">
          		<div class="chat_id">{{chat_id}}</div>
          		<div class="chat_msg">{{chat_msg}}
					<a href="{{chat_no}}" style="display:{{printDel chat_id}}"> X</a>
				</div>
        	  	<div class="chat_regdate">{{chat_regdate}}</div>
       		</div>
      {{/each}}
      </script>
       	
      	<script>
         var uid = "${uid}";
         Handlebars.registerHelper("printLeftRight", function(chat_id) {
            if (uid != chat_id) {
               return "left";
            } else {
               return "right";
            }
         });
         
         Handlebars.registerHelper("printDel", function(chat_id) {
             if (uid != chat_id) {
                return "none";
             } else {
                return "";
             }
          });
      	</script>
      <div class="input-div">
         <textarea id="txtMessage" placeholder="메세지를 입력한 후 엔터키를 누르세요!"></textarea>
      </div>
   </div>

</body>
<script>
	var chat_room = "${chat_room}";
	getList();
	var uid = "${uid}";
	

	   //메시지 삭제
	   $('#chat').on('click','.chat_msg a',function(e){
		   e.preventDefault(); 
		   var chat_no = $(this).attr('href');
		   if(!confirm(chat_no+'을 삭제하실래요?')) return;

		   $.ajax({
				  type:"post",
				  url:"chat/delete",
				  data:{"chat_no":chat_no},
				  success: function(){
					  sock.send("delete");
				  }
			 });

	   });
	
	$('#txtMessage').on("keydown",function(e){
		if(e.keyCode==13 && !e.shiftKey){
			e.preventDefault();
			var message = $('#txtMessage').val();
			if(message==""){
				alert("메시지를 입력하세요!");
				return;
			}
			
			$('#txtMessage').val("");

			$.ajax({
        		type:"post",
        	 	url:"chat/insert",
        	 	data:{"chat_id":uid, "chat_msg":message, "chat_room":chat_room},
        	 	success: function(data){
        			//서버로 메시지 보내기
        			sock.send(uid+"|"+message);

        	 }
   	      });

			
		}
	});
	
	//웹소켓생성
	var sock = new SockJS("http://localhost:8088/echo");

	//서버로부터 메시지를 받기
	sock.onmessage = onMessage;
	function onMessage(msg){
		getList();
	}
	
	// 채팅 데이터 불러오기
    function getList() {
        $.ajax({
           type : "get",
           url : "/chat.json",
           dataType : "json",
           data:{"chat_room":chat_room},
           success : function(data) {
              var template = Handlebars.compile($("#temp").html());
              $("#chat").html(template(data));
            //스크롤바 아래 고정
              window.scrollTo(0, $('#chat').prop('scrollHeight'));

           }
        });
     } 

	// 채팅창 닫기
	$('#close').on('click',function(){
		window.close();
	});
</script>
</html>