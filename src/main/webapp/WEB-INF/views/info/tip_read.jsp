<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<link rel="stylesheet" href="../resources/info.css" />

<div style="width:400px;
	margin:0 auto; text-align:center;">
	<div id="subject">INFORMATION</div>
	<h5>캠핑팁</h5>
</div>

<div id="divRead">
	<img id="mainImg" src="/tip/display?file=${vo.tip_image}" width=500 height=400/>
	<div id="att">
		<c:if test="${att!=null}">
			<c:forEach items="${att}" var="list">
					<img src="/tip/display?file=/${vo.tip_no}/${list}" width=150 height=100/>
			</c:forEach>		
		</c:if>
	</div>
	<div class="divider"></div>
	<div id="tip">
		<div style="overflow:hidden; margin-bottom:30px;">
			<div id="tip_logo">TIP</div>
		</div>
		<div id="nb_title">${vo.tip_no} : ${vo.tip_title}</div>
		<div id="nb_content">${fn:replace(vo.tip_content, replaceChar, "<br/>")}</div>
	</div>
	<div>
		<div>
			<h5>캠핑정보가 도움이 되셨다면 좋아요를 눌러주세요!</h5>
			<c:if test="${uid!=null}">
				<c:if test="${likeCheck==0}">
					<img src="/resources/heart.png" title="좋아요" width=35 id="likey"/>
				</c:if>
				<c:if test="${likeCheck!=0}">
					<img src="/resources/heart_colored.png" title="좋아요취소" width=35 id="likey"/>
				</c:if>
			</c:if>
			<h4 id="likeCnt">좋아요 : ${vo.tip_like}</h4>
		</div>
		
		<div>
			<div id="tipUpDel">
				<button id="update" class="blackBtn" onClick="location.href='/tip/update?tip_no=${vo.tip_no}'">수정</button>
				<input type="button" id="btnDelete" class="whiteBtn" value="삭제">
			</div>
			<button id="list" class="whiteBtn" onClick="location.href='/tip/list'">목록</button>
		</div>
	</div>
</div>
<script>
	regdate();
	function regdate(){
		var regdate = $("#regdate").html();
		var dateObj = new Date(regdate);
	    var year = dateObj.getFullYear();
	    var month = ("0" +(dateObj.getMonth() + 1)).slice(-2);
	    var date = ("0" +(dateObj.getDate())).slice(-2);
	    
		regdate = year + "-" + month + "-" + date;
		return regdate;
	}
</script>
<script>
	var uid="${uid}";
	var likeCheck = "${likeCheck}";
	var tip_no = ${vo.tip_no};
	
	//해당 글을 작성한 유저만 수정&삭제 가능
	$("#tipUpDel").html(function(){
		if("${vo.tip_writer}"!=uid){
			$("#tipUpDel").css('display','none');
		}
	});

	//팁 삭제
	$("#btnDelete").on("click", function(){
		var tip_no=${vo.tip_no};
		var image="${vo.tip_image}";
		
		if(!confirm("해당 팁을 삭제하시겠습니까?")) return;
		$.ajax({
			type:"post",
			url:"/tip/delete",
			data:{"tip_no":tip_no, "image":image},
			success:function(){
				alert("삭제완료!");
			}
		})
		location.href="/tip/list";
	});

	//좋아요 버튼 클릭한 경우
	$('#likey').on('click',function(){
		$.ajax({
			type:'post',
			url:'/tip/like',
			data:{"likeCheck":likeCheck,"uid":uid,"tip_no":tip_no},
			success: function(){
				location.href="/tip/read?tip_no="+tip_no;
			}	
		});
	});
</script>