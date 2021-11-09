<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	table,td{padding:7px;border:1px solid gray; border-collapse:collapase;}
</style>
<h1>채팅목록</h1>

<div style="width:700px; margin:0 auto;">
	<table id="chatBox"></table>
</div>

<script id="temp" type="text/x-handlebars-template">
	<tr>
		<th width=100>회원 아이디</th>
		<th width=400>최근 메시지</th>
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