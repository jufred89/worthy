<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% pageContext.setAttribute("replaceChar", "\n"); %>
<link rel="stylesheet" href="../resources/info_read.css" />
<div id="divRead">
	<div id="readHeader">
		<h3 id="title">${vo.nb_no} . ${vo.nb_title}</h3>
		<span id="readInfo">
			<span id="writer">${vo.nb_writer}</span> &nbsp;&nbsp;<b>|</b>&nbsp;&nbsp;
			<span id="regdate">${vo.nb_regdate}</span> &nbsp;&nbsp;<b>|</b>&nbsp;&nbsp;
			<span id="likeCnt">좋아요 : ${vo.nb_like}</span> &nbsp;&nbsp;<b>|</b>&nbsp;&nbsp;
			<span id="viewcnt">조회수 : ${vo.nb_viewcnt}</span>
		</span>
	</div>
	<c:if test="${vo.nb_image!='none.jpg'}">
		<img id="mainImg" src="/notice/display?file=${vo.nb_image}"/>
	</c:if>
	<div id="att">
		<c:if test="${att!=null}">
			<c:forEach items="${att}" var="list">
					<img src="/notice/display?file=/${vo.nb_no}/${list}"/>
			</c:forEach>
		</c:if>
	</div>
		<div id="infoContent">
			${fn:replace(vo.nb_content, replaceChar, "<br/>")}
		</div>
	<div>
		<c:if test="${uid!=null}">
			<c:if test="${likeCheck==0}">
				<style>
					#btnLike:hover{
						background:#EAA2C5;
						cursor:pointer;
					}
				</style>
				<img src="../resources/heart.png" id="btnLike" width=40/>
			</c:if>
			<c:if test="${likeCheck!=0}">
				<style>
					#btnLike:hover{
						background:#bebebe;
						cursor:pointer;
					}
				</style>
				<img src="../resources/heart_colored.png" id="btnLike" width=40/>
			</c:if>
		</c:if>
		<button id="list" onClick="location.href='/notice/list'">목록</button>
		<div id="upDel">
			<button id="update" onClick="location.href='/notice/update?nb_no=${vo.nb_no}'">수정</button>
			<input type="button" id="btnDelete" value="삭제">
		</div>
	</div>
</div>
<script>
	var uid="${uid}";
	var likeCheck = "${likeCheck}";
	var nb_no = ${vo.nb_no};
	var regdate = $("#regdate").html();
	var year = regdate.slice(24,28);
	
	
	//날짜 포맷 변경
	$("#regdate").html(function(){
		//뒤에 년수 네글자 삭제
		$(this).html(regdate.slice(0,19));
		//앞쪽에 년수 삽입
		$(this).prepend(year+"-");

		//kst, 요일 삭제
		$("#regdate").html($("#regdate").html().replace("KST",""));
		$("#regdate").html($("#regdate").html().replace("Mon",""));
		$("#regdate").html($("#regdate").html().replace("Tue",""));
		$("#regdate").html($("#regdate").html().replace("Wed",""));
		$("#regdate").html($("#regdate").html().replace("Thu",""));
		$("#regdate").html($("#regdate").html().replace("Fri",""));
		$("#regdate").html($("#regdate").html().replace("Sat",""));
		$("#regdate").html($("#regdate").html().replace("Sun",""));
		
		//달 영어표기 숫자로 치환
		if($(this).html().includes("Jan")){
			
			return $(this).html().replace("Jan","01-");
		}if($(this).html().includes("Feb")){
			return $(this).html().replace("Feb","02-");
		}if($(this).html().includes("Mar")){
			return $(this).html().replace("Mar","03-");
		}if($(this).html().includes("Apr")){
			return $(this).html().replace("Apr","04-");
		}if($(this).html().includes("May")){
			return $(this).html().replace("May","05-");
		}if($(this).html().includes("Jun")){
			return $(this).html().replace("Jun","06-");
		}if($(this).html().includes("Jul")){
			return $(this).html().replace("Jul","07-");
		}if($(this).html().includes("Aug")){
			return $(this).html().replace("Aug","08-");
		}if($(this).html().includes("Sep")){
			return $(this).html().replace("Sep","09-");
		}if($(this).html().includes("Oct")){
			return $(this).html().replace("Oct","10-");
		}if($(this).html().includes("Nov")){
			return $(this).html().replace("Nov","11-");
		}if($(this).html().includes("Dec")){
			return $(this).html().replace("Dec","12-");
		}
	});
	
	//해당 글을 작성한 유저만 수정&삭제 가능
	$("#upDel").html(function(){
		if("${vo.nb_writer}"!=uid){
			$("#upDel").css('display','none');
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
	$('#btnLike').on('click',function(){
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
