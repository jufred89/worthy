<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<style>
	#divRead{
		width:960px;
		margin:0 auto;
	}
	#recipe{
		display:inline-block;
	}
	#list{
		float:right;
		margin:15px;
	}
	#update, #btnLike, #likeCnt, #btnDelete{
		float:right;
		margin:15px;
	}
</style>
<h1>레시피 읽기</h1>
<div id="divRead">
	<div id="recipe">
		<img src="/info/display?file=${vo.fi_image}" width=500 height=400/><h3>${vo.fi_no} : ${vo.fi_title}</h3>
		<div>${fn:replace(vo.fi_content, replaceChar, "<br/>")}</div>
	</div>
	<div>
		<button id="list" onClick="location.href='/recipe/list'">목록</button>
		<div id="upDel">
			<button id="update" onClick="location.href='/recipe/update?fi_no=${vo.fi_no}'">수정</button>
			<input type="button" id="btnDelete" value="삭제">
		</div>
		<c:if test="${uid!=null}">
			<c:if test="${likeCheck==0}">
				<input type="button" id="btnLike" value="좋아요"/>
			</c:if>
			<c:if test="${likeCheck!=0}">
				<input type="button" id="btnLike" value="좋아요취소"/>
			</c:if>
		</c:if>
		<h4 id="likeCnt">좋아요 : ${vo.fi_like}</h4>
	</div>
</div>
<script>
	var uid="${uid}";
	var likeCheck = "${likeCheck}";
	var fi_no = ${vo.fi_no};
	
	
	//해당 글을 작성한 유저만 수정&삭제 가능
	$("#upDel").html(function(){
		if("${vo.fi_writer}"!=uid){
			$("#upDel").css('display','none');
		}
	});
	
	//레시피 삭제
	$("#btnDelete").on("click",function(){
		var image="${vo.fi_image}";
		
		if(!confirm("해당 레시피를 삭제하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/recipe/delete",
			data:{"fi_no":fi_no,"image":image},
			success:function(){
				alert("삭제완료!");
			}
		})
		location.href="/recipe/list";
	});
	
	//좋아요 버튼 클릭한 경우
	$('#btnLike').on('click',function(){
		$.ajax({
			type:'post',
			url:'/recipe/like',
			data:{"likeCheck":likeCheck,"uid":uid,"fi_no":fi_no},
			success: function(){
				location.href="/recipe/read?fi_no="+fi_no;
			}	
		});
	});
</script>