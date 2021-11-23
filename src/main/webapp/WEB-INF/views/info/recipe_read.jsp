<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<link rel="stylesheet" href="../resources/info.css" />

<div style="width:400px;
	margin:0 auto; text-align:center;">
	<div id="subject">INFORMATION</div>
	<h5>캠핑팁</h5>
</div>
<div id="divRead">
	<img id="mainImg" src="/recipe/display?file=${vo.fi_image}" width=500 height=400/>
	<div id="att">
		<c:if test="${att!=null}">
			<c:forEach items="${att}" var="list">
					<img src="/recipe/display?file=/${vo.fi_no}/${list}" width=150 height=100/>
			</c:forEach>		
		</c:if>
	</div>
	<div id="recipe">
		<div style="overflow:hidden; margin-bottom:30px;">
			<div id="recipe_logo">RECIPE</div>
		</div>
		<div id="nb_title">${vo.fi_title}</div>
		<div id="nb_content">${fn:replace(vo.fi_content, replaceChar, "<br/>")}</div>
	</div>
	<div>
		

		<div>
			<h5>캠핑정보가 도움이 되셨다면 좋아요를 눌러주세요!</h5>
			<c:if test="${uid!=null}">
				<c:if test="${likeCheck==0}">
					<img src="/resources/heart.png" title="좋아요" width=35 id="recipeLike"/>
				</c:if>
				<c:if test="${likeCheck!=0}">
					<img src="/resources/heart_colored.png" title="좋아요취소" width=35 id="recipeLike"/>
				</c:if>
			</c:if>
			<h4 id="likeCnt">좋아요 : ${vo.fi_like}</h4>
		</div>
		
		<div>
			<div id="upDel">
				<button id="update" class="blackBtn" onClick="location.href='/recipe/update?fi_no=${vo.fi_no}'">수정</button>
				<input type="button" class="whiteBtn" id="btnDelete" onClick="location.href='/recipe/list'" value="삭제">
			</div>
			<button id="list" class="whiteBtn" onClick="location.href='/recipe/list'">목록</button>
		</div>
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
	$('#recipeLike').on('click',function(){
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