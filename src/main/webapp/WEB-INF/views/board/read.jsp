<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	#page{
		width:1200px;
		margin: 0 auto;
		text-align:left;
	}
	.box{
		background-color: #ecf5fe;
		margin:15px;
		padding:10px;
		width:900px;
	}
	.rno{
		font-size:70%;
		font-weight:bold;
	}
	.replyer{
		font-size:105%;
		font-weight:bold;
		color:#0077c0;
	}
	
	.replydate{
		font-size:80%;
		color:gray;
		margin-left:10px;
	}
	.reply{
		margin-top:5px;
	}

	.write{
		margin-bottom:20px;
		border: 1px solid #dadada;
		padding:15px;
	}
	#uid,#btnReplyInsert,#txtReply{
		margin-left:5px;
	}
	
</style>
<div id="page">
	<h1>글 읽기</h1>
	<form name="frm" enctype="multipart/form-data">
		<div>
			카테고리
			<select name="fb_category">
				<option value="${vo.fb_category }">${vo.fb_category }</option>
			</select>
		</div>
		
	
		<div class="cont">
			<span>글번호</span><input type="text" name="fb_no" value="${vo.fb_no }" readonly/><br>
			<span>제목</span><input type="text" name="fb_title" value="${vo.fb_title }"/><br>
			<span>작성자</span><input type="text" name="fb_writer" value="${vo.fb_writer }" readonly/>	
		</div>
		<div class="cont">
			<textarea rows="20" cols="120" name="fb_content">${vo.fb_content }</textarea>
		</div>
		
		
		<!-- 대표사진 -->
		<div class="cont">
			<div><h4>대표사진</h4></div>
			<img src="/board/display?file=${vo.fb_image }" name="fb_image" id="fb_image" width=320 height=250/>
			<!-- 이미지를 변경하지 않았을 때 기존 이미지 사용 -->
			<input type="hidden" name="oldImage" value="${vo.fb_image }"/>
			<br>
			<!-- 대표 이미지 첨부 -->
			<div><b>첨부이미지</b> <input type="file" name="file" style="display:none;"/></div>
		</div>
		
		
		<!-- 첨부파일 -->
		<div style="width:900px; margin:0 auto;">
			첨부파일추가 <input type="file" name="attFile"/>
			<!-- 첨부파일 리스트 출력 -->
			<div id="attachments" style="overflow:hidden;">
				<c:forEach items="${attList }" var="attach">
					<img src="display?file=/${vo.fb_no }/${attach }" width=200 height=150/>
					<a href="${attach }">삭제</a>
				</c:forEach>
			</div>
			<hr/>

			<!-- 수정, 삭제, 취소 버튼 -->
			<div style="margin-top:20px;">
			<c:if test="${uid == vo.fb_writer}">
				<input type="submit" value="글수정"/>
				<input type="button" id="btnDelete" value="삭제"/>
			</c:if>
				<input type="reset" value="취소"/>		
			</div>
		</div>
	</form>
	<hr/>
	<div>
		<c:if test="${likeCheck==0 }">
		<input type="button" id="bntLike" value="좋아요"/>
		</c:if>
		<c:if test="${likeCheck!=0 }">
		<input type="button" id="bntLike" value="좋아요취소"/>
		</c:if>
	</div>
	<hr/>
	
	<!------------------------------ 댓글 --------------------------->
	<!-------- 댓글입력 -------->
	<div class="write">
		<div id="uid"><b>${uid}</b></div>
		<textarea rows="5" cols="120" id="txtReply"></textarea><br/>
		<button id="btnReplyInsert">등록</button>
	</div>
	
	<!--------댓글목록 ------>
	<h4>댓글목록 (<span id="total"></span>개의 댓글)</h4>
	<div id="replies"></div>
	<script id="temp" type="text/x-handlebars-template">
		{{#each list}}
		<div class="box">
			<div>
				<span class="rno">[{{fb_rno}}]</span>
				<span class="replyer">{{fb_replyer}}</span>
				<span class="replydate">{{fb_replydate}}</span>
				<a href='{{fb_rno}}' class='delete' style="float:right; display:{{printDel fb_replyer}}">삭제</a>
			</div>
			<div class="reply">{{fb_reply}}</div>
		</div>
		{{/each}}
	</script>
	<div style="text-align:center">
		<div id="pagination" class="pagination"></div>
	</div>
	<script src="/resources/pagination.js"></script>
</div>
<script>
	Handlebars.registerHelper("printDel",function(fb_replyer){
		if(fb_replyer != "${uid}") return "none";
	});
</script>

<script>
	var fb_no = $(frm.fb_no).val();
	var uid="${uid}";
	var page = 1;
	var likeCheck = "${likeCheck}";
	
	getReplyList();
	
	//좋아요 버튼 클릭한 경우
	$('#bntLike').on('click',function(){
		$.ajax({
			type:'post',
			url:'like',
			data:{"likeCheck":likeCheck,"uid":uid,"fb_no":fb_no},
			success: function(){
				location.href="/board/read?fb_no="+fb_no;
			}
				
		});
	});
	
	//댓글 페이징
	$('#pagination').on('click','a',function(e){
		e.preventDefault();
		page = $(this).attr('href');
		getReplyList();
	});
	
	//댓글 삭제 버튼을 클릭한 경우
	$('#replies').on('click','.box .delete',function(e){
		e.preventDefault();
		var fb_rno = $(this).attr('href');
		if(!confirm('댓글을 삭제하시겠습니까?')) return;
		
		$.ajax({
			type:'post',
			url:'replyDelete',
			data:{"fb_rno":fb_rno},
			success:function(){
				getReplyList();
			}
		});
	});
	
	//댓글 등록 버튼을 클릭한 경우
	$('#btnReplyInsert').on('click',function(){
		var fb_reply = $('#txtReply').val();
		var fb_replyer = uid;
		
		if(fb_reply==""){
			alert('댓글 내용을 입력하세요!');
			$('#txtReply').focus();
			return;
		}
		
		if(!confirm('댓글을 등록하실래요?')) return;
		$.ajax({
			type:'post',
			url:'replyInsert',
			data:{"fb_bno":fb_no, "fb_reply":fb_reply, "fb_replyer":fb_replyer},
			success:function(){
				$('#txtReply').val("");

				getReplyList();
			}
		});
	});

	
	//댓글 리스트 가져오기
	function getReplyList(){
		$.ajax({
			type:'get',
			url:'reply.json',
			dataType:'json',
			data:{"fb_bno":fb_no, "page":page},
			success: function(data){
				var temp = Handlebars.compile($("#temp").html());
				$("#replies").html(temp(data));
				$('#total').html(data.pm.totalCount);
				$('#pagination').html(getPagination(data));
			}

		});
	}

	
	//글 삭제 버튼을 누른 경우
	$('#btnDelete').on('click',function(){
		if(!confirm('삭제하시겠습니까?')) return;
		$.ajax({
			type:'post',
			url:'delete',
			data:{"fb_no":fb_no},
			success:function(){
				alert('삭제완료');
				location.href="/board/list"
			}	
		});
	});
	
	//좋아요 버튼 클릭
	$('#btnLike').on('click',function(){
		
	});
	
	//첨부파일을 추가할 경우
	$(frm.attFile).on("change",function(){
		var file = $(frm.attFile)[0].files[0];
		if(file==null) return;
		if(!confirm('파일을 첨부하실래요?')) return;
		var formData = new FormData();
		formData.append("file",file);
		formData.append("fb_no",fb_no);
		
		$.ajax({
			type:'post',
			url:'attInsert',
			data:formData,
			processData: false,
			contentType: false,
			success: function(data){
				var str='<img src="display?file=/'+fb_no+"/"+data+'" width=200 height=150/>';
				str+='<a href="'+data+'">삭제</a>';
				
				$("#attachments").append(str);
				
				location.href="/board/read?fb_no="+fb_no;
			}
		});
		
	});
	
	//첨부파일 삭제
	$('#attachments a').on('click',function(e){
		e.preventDefault();
		if(!confirm('첨부파일을 삭제하실래요?')) return;
		var image = $(this).attr("href");
		$.ajax({
			type:'post',
			url:'attDelete',
			data: {"image":image,"fb_no":fb_no},
			success: function(){
				alert('삭제완료');
				location.href="/board/read?fb_no="+fb_no;
			}
		});
	});


	
	//사진 click
	$('#fb_image').on('click',function(){
		$(frm.file).click();
	});
	
	// 대표사진 change
	$(frm.file).on("change",function(e){
		var file = $(this)[0].files[0];
		$('#fb_image').attr("src",URL.createObjectURL(file));
	});
	
	
	
	// submit
	$(frm).on('submit',function(e){
		e.preventDefault();
		
		// 입력 검사
		var fb_category = $(frm.fb_category).val();
		var fb_title = $(frm.fb_title).val();
		var fb_writer = $(frm.fb_writer).val();
		var fb_content = $(frm.fb_content).val();
		var file = $(frm.file).val();
		var oldImage = $(frm.oldImage).val();
		
		if(fb_title==""){
			alert("글 제목을 입력하세요");
			$(frm.fb_title).focus();
			return;
		}
		if(fb_content==""){
			alert("내용을 입력하세요");
			$(frm.fb_content).focus();
			return;
		}

		if(!confirm('글을 수정하실래요?')) return;

		frm.action="update";
		frm.method="post";
		frm.submit();
	});
	
</script>