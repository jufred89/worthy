<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="../resources/board.css" />
<link rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
/>
<style>
	body{padding-left:18px;}
	#fb_info{height:500px;}
</style>
<div id="subject">FREE BOARD</div>
<h5>자유게시판</h5>

<div id="readPage">
	<div id="pageLike">
		<c:if test="${likeCheck==0 }">
		<img src="/resources/heart.png" title="좋아요" width=35 id="bntLike"/>
		</c:if>
		<c:if test="${likeCheck!=0 }">
		<img src="/resources/heart_colored.png" title="좋아요취소" width=35 id="bntLike"/>
		</c:if>
	</div>
	<div id="pageContent">
		<form name="frm" enctype="multipart/form-data">
			<div id="condition">
					<input type="hidden" name="fb_no" value="${vo.fb_no }"/><br>
					<div id="fb_title">
						<input type="text" name="fb_title" size="40" value="${vo.fb_title }"/>
					</div>
					
					<div class="title">카테고리</div>
					<c:if test="${vo.fb_writer == uid}">
						<select id="fb_category" name="fb_category">
							<option value="sell">팝니다</option>
							<option value="buy">삽니다</option>
							<option value="greetings">가입인사</option>
							<option value="talk">캠핑톡</option>
						 </select>	
					</c:if>
					<c:if test="${vo.fb_writer != uid}">
						<input type="text" value="${vo.fb_category }"/>
					</c:if>
					<div id="writer"><span class="title">작성자 </span> ${vo.fb_writer }</div>
					
			</div>
			<div id="form-box">
				<!-- 대표사진 -->
				<div id="form-image">
						
						<c:if test="${vo.fb_image == null }">
							<img src="http://placehold.it/200x150"/>
						</c:if>
						<c:if test="${vo.fb_image != null }">
							<img src="/board/display?file=${vo.fb_image }" name="fb_image" id="fb_image" width=350 height=300/>
						</c:if>
						<input type="file" name="file" style="display:none;"/>
						<!-- 이미지를 변경하지 않았을 때 기존 이미지 사용 -->
						<input type="hidden" name="oldImage" value="${vo.fb_image }"/>	
				</div>
				<div id="fb_info">
					
					<div id="fb_content">
						<textarea rows="20" cols="59" name="fb_content">${vo.fb_content }</textarea>
					</div>
				</div>
			</div>
			<div id="form-images">

								
				<!-- 첨부파일 -->
				<c:if test="${attList!=null}">
					<div id="form-attach">
						<div class="title">첨부이미지</div>
						<c:if test="${vo.fb_writer == uid}">
							<input type="file" name="attFile" accept="image/*"/>
						</c:if>
						<div id="attachments">
						
							<!-- 첨부파일 리스트 출력 -->
							<c:forEach items="${attList }" var="attach">
								<div class="attachBox">
									<img src="display?file=/${vo.fb_no }/${attach }" width=150 height=100/>
									<div class="printDel">
										<c:if test="${vo.fb_writer == uid}">
											<a href="${attach }">삭제</a>
										</c:if>
									</div>
								</div>
							</c:forEach>		
						
						</div>
					</div>
				</c:if>	
			</div>
			<!---------------------- 수정, 삭제, 취소 버튼 ------------------->
				<div id="readBtns">
				<c:if test="${uid == vo.fb_writer}">
					<input type="submit" value="수정"/>
					<input type="button" id="btnDelete" value="삭제"/>
				</c:if>
				<input type="button" value="목록으로" onClick="location.href='/board/list'"/>		
				</div>
		</form>
	</div>

	

	<div class="line"></div>
	
	<!------------------------------ 댓글 --------------------------->
	<!-------- 댓글입력 -------->
	<div class="write">
		<div id="uid"><b>${uid}</b></div>
		<textarea rows="5" cols="120" id="txtReply"></textarea><br/>
		<button id="btnReplyInsert">댓글등록</button>
	</div>
	
	<!--------댓글목록 ------>
	<div id="replyList">
		<h4><b>댓글목록</b> (<span id="total"></span>개의 댓글)</h4>
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
	</div>
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
	
	var category = "${vo.fb_category }";
	if(category=='sell'){
		$('#fb_category option:eq(0)').prop("selected",true);
	}else if(category=='buy'){
		$('#fb_category option:eq(1)').prop("selected",true);
	}else if(category=='greetings'){
		$('#fb_category option:eq(2)').prop("selected",true);
	}else{
		$('#fb_category option:eq(3)').prop("selected",true);
	}
	


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
		var fb_category = $(frm.fb_category).val();
		
		if(fb_reply==""){
			alert('댓글 내용을 입력하세요!');
			$('#txtReply').focus();
			return;
		}
		
		if(!confirm('댓글을 등록하실래요?')) return;
		$.ajax({
			type:'post',
			url:'replyInsert',
			data:{"fb_bno":fb_no, "fb_reply":fb_reply, "fb_replyer":fb_replyer, "fb_category":fb_category },
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
		var formImage = $(frm.file).val();
		if(formImage==""){
			formImage = $(frm.oldImage).val();
		}
		if(!confirm('삭제하시겠습니까?')) return;
		$.ajax({
			type:'post',
			url:'delete',
			data:{"fb_no":fb_no,"formImage":formImage},
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
		var fb_image = $(frm.fb_image).val();
		var fb_oldImage = $(frm.fb_oldImage).val();

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