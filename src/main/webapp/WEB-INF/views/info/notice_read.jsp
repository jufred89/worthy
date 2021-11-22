<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<link rel="stylesheet" href="../resources/info.css" />

<div style="width:400px;
	margin:0 auto; text-align:center;">
	<div id="subject">INFORMATION</div>
	<h5>공지사항</h5>
</div>
<div id="divRead">
	<img id="mainImg" src="/notice/display?file=${vo.nb_image}" width=500 height=400/>
	<div id="att">
		<c:if test="${att!=null}">
			<c:forEach items="${att}" var="list">
					<img src="/notice/display?file=/${vo.nb_no}/${list}" width=150 height=100/>
			</c:forEach>		
		</c:if>
	</div>
	<div class="divider"></div>
	<div id="notice">
		<div style="overflow:hidden; margin-bottom:30px;">
			<div id="notice_logo">NOTICE</div>
		</div>
		<div id="nb_title">${vo.nb_title}</div>
		<div id="nb_content">${fn:replace(vo.nb_content, replaceChar, "<br/>")}</div>
	</div>
	<div>

		<div>
			<h5>캠핑정보가 도움이 되셨다면 좋아요를 눌러주세요!</h5>
			<c:if test="${uid!=null}">
				<c:if test="${likeCheck==0 }">
					<img src="/resources/heart.png" title="좋아요" width=35 id="noticeLikey"/>
				</c:if>
				<c:if test="${likeCheck!=0 }">
					<img src="/resources/heart_colored.png" title="좋아요취소" width=35 id="noticeLikey"/>
				</c:if>
			</c:if>
			<h4 id="likeCnt">좋아요 : ${vo.nb_like}</h4>
		</div>
			<div>
				<div id="noticeUpDel">
					<button id="update" class="blackBtn" onClick="location.href='/notice/update?nb_no=${vo.nb_no}'">수정</button>
					<input type="button" id="btnDelete" class="whiteBtn" value="삭제">
				</div>
				<button id="list" class="whiteBtn" onClick="location.href='/notice/list'">목록</button>
			</div>
		
	</div>
</div>
<script>

	
	var uid="${uid}";
	var likeCheck = "${likeCheck}";
	var nb_no = ${vo.nb_no};
	//해당 글을 작성한 유저만 수정&삭제 가능
	$("#noticeUpDel").html(function(){
		if("${vo.nb_writer}"!=uid){
			$("#noticeUpDel").css('display','none');
		}
	});
	
	//공지사항 삭제
	$("#btnDelete").on("click",function(){
		var image="${vo.nb_image}";
		
		if(!confirm("해당 공지사항을 삭제하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/notice/delete",
			data:{"nb_no":nb_no,"image":image},
			success:function(){
				alert("삭제완료!");
				location.reload();
			}
		})		
		location.href="/notice/list";
	});
	
	//좋아요 버튼 클릭한 경우
	$('#noticeLikey').on('click',function(){
		$.ajax({
			type:'post',
			url:'/notice/like',
			data:{"likeCheck":likeCheck,"uid":uid,"nb_no":nb_no},
			success: function(){
				location.href="/notice/read?nb_no="+nb_no;
				location.reload();
			}	
		});
	});
</script>
