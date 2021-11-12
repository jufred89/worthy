<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<h1>팁 읽기</h1>
<div id="divRead">
	<div id="tip">
		<img src="/info/display?file=${vo.tip_image}" width=500 height=400/><h3>${vo.tip_no} : ${vo.tip_title}</h3>
		<span id="regdate">${vo.tip_regdate}</span>
		<div>${fn:replace(vo.tip_content, replaceChar, "<br/>")}</div>
	</div>
	<div>
		<button id="list" onClick="location.href='/tip/list'">목록</button>
		<div id="upDel">
			<button id="update" onClick="location.href='/tip/update?tip_no=${vo.tip_no}'">수정</button>
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
		<h4 id="likeCnt">좋아요 : ${vo.tip_like}</h4>
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
	$("#upDel").html(function(){
		if("${vo.tip_writer}"!=uid){
			$("#upDel").css('display','none');
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
	$('#btnLike').on('click',function(){
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