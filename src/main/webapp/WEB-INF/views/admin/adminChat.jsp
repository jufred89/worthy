<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="sub">
	<div class="subheading">채팅 목록</div>

	<div style="width:1000px; margin:0 auto;">
		<table id="chatBox"></table>
	</div>
	
	<script id="temp" type="text/x-handlebars-template">
	<tr>
		<th width=100>회원 아이디</th>
		<th width=600>최근 메시지</th>
		<th>시간</th>
	</tr>
	{{#each .}}
	<tr class="chats" onClick="window.open('/chat?chat_id={{chat_id}}','chat','width=500,height=800,top=80,left=900')">
		<td>{{chat_id}}</td>
		<td>{{chat_msg}}</td>
		<td>{{chat_regdate}}</td>
	</tr>
	{{/each}}
	</script>
</div>
<script>

	getList();
	
	function getList(){

		$.ajax({
			type:'get',
			url:'chatList.json',
			dataType:'json',
			success:function(data){
				var temp = Handlebars.compile($('#temp').html());
				$('#chatBox').html(temp(data));
			}
		});
		
	}
</script>