<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="../resources/info_read.css" />
<style>
	frm{width:960px;margin:0 auto;}
	h5{float:left;}
	#title{font-weight:bold; border:none;}
	#file{
		border:1px dashed gray; 
		padding:8px;
		width:730px;
		margin-top:15px;
	}
	#image{margin:15px;}
	#file{
		margin:0 auto;
		margin-top:15px; 
		width:730px;
		border:1px dashed gray;
	}
	#oldFiles{
		margin:0 auto;
		width:730px;
	}
	#oldFiles img{
		margin:10px;
		width:150px;
		height:100px;
	}
	#files img{
		margin:10px;
		width:150px;
		height:100px;
	}
	textarea{margin:15px; border:1px solid #c2c2c3;}
	#imageBox{
		margin:0 auto;
		margin-bottom:15px;
	}
	#overlay{
	  postiion : relative;
	  width:150px; height:100px;
	}
	.btnImg {
	  position: absolute;
	  top: 145px;
	  left : 95px; 
	  width:10px;
	  height:10px;
	}
	
	form{border:1px solid #e2e2e3; padding:30px;}
	h5{ margin:3px 10px 20px 10px;}
	#nb_content{padding:30px;}
	#divRead{border:none;}
	#readHeader{border:none;}
	
</style>
<div style="width:960px;margin:0 auto; text-align:center;">
		<div style="overflow:hidden; margin-bottom:10px;">
			<div id="notice_logo">NOTICE</div>
		</div>
</div>
<div id="divRead">
	<div id="readHeader">
		<div style="overflow:hidden;">
		<h5>공지사항 수정</h5>
		</div>
		<form name="frm" action="/notice/update" method="POST" enctype="multipart/form-data">
			<input type="hidden" name="nb_no" value="${vo.nb_no}"/>
			<input type="text" name="nb_title" id="title" style="margin:30px; width:730px; text-align:center;" value="${vo.nb_title}" placeholder="제목을 입력하세요"/><br/>
				<div id="imageBox">
					<img name="image" src="/notice/display?file=${vo.nb_image}" style=" width:400px; height:300px;"/>
					<input type="hidden" name="oldImage" value="${vo.nb_image}"/>
					<input type="file" name="file" style="display:none;"/>
					<div id="file"><input type="file" name="files" accept="image/*" multiple/></div>
				</div>
			    <div id="oldFiles">
					<c:if test="${att!=null}">
						<c:forEach items="${att}" var="list">
							<span class="att">
								<img src="/notice/display?file=/${vo.nb_no}/${list}" width=150 height=100 class="attImg"/>
								<input type="hidden" value="${list}" class="attVal">
							</span>
						</c:forEach>		
					</c:if>
					<span id="files"></span>
				</div>
			<textarea rows="10" cols="100" name="nb_content" id="nb_content" placeholder="내용을 입력하세요">${vo.nb_content}</textarea>
			<div>
			<input type="submit" class="blackBtn" value="수정"/>
			<input type="reset" class="whiteBtn" value="수정취소" onClick="location.href='/notice/list'"/>
			</div>
		</form>
	</div>
</div>

<script>	
	//수정 클릭시
	$(frm).on("submit",function(e){
		e.preventDefault();

		var nb_content=$(frm.nb_content).val();
		var nb_title=$(frm.nb_title).val();
		
		if(nb_title=="" || nb_content==""){
			alert("글의 제목과 내용을 입력해주세요!");
			return;
		}
		if(!confirm("공지사항을 수정 하시겠습니까?")) return;
		frm.submit();
	});

	//파일첨부 클릭시
	$(frm.files).on("change", function(){
		var files=$(this)[0].files;
		var i=0;
		var name = $(this).get(0).files[i].name;		
		var str="";
		$.each(files, function(index, file){
			str += "<img src='" + URL.createObjectURL(file) + "'";
			str += "style='width:150px;height:100px;display:inline;' id='"+name+"'/>";
		});
		$("#files").append(str);
	});
	
	//이미 첨부되있던 이미지 클릭시
	$(".att").on("click", function(){
		var image = $(this).children(".attVal").val();
		var nb_no=$(frm.nb_no).val();
		
		//console.log(image + nb_no);
		
		if(!confirm("첨부 이미지를 삭제하시겠습니까?"))return;
		$(this).remove();
		$.ajax({
			type:"post",
			url:"/notice/attDel",
			data:{"image":image, "nb_no":nb_no},
			success:function(){}
		});
	});
	
//	$("input[name=files]").change(function(){
//		var files = $("input[name=files]")[0].files;
//		for(var i=0;i<files.length;i++){
//			alert('fileName : ' + $(this).get(0).files[i].name);
//		}
//	});
	
	//첨부할 이미지 클릭시
	$("#files").on("click", "img", function(){
		if(!confirm("첨부 이미지를 삭제하시겠습니까?"))return;
		$(this).remove();
		alert("삭제되었습니다.");
	});
	
	//대표이미지 클릭시
	$(frm.image).on("click", function(){
		$(frm.file).click();
	});
	
	//이미지 미리보기
	$(frm.file).on("change",function(){
		var file = $(frm.file)[0].files[0];
		$(frm.image).attr("src", URL.createObjectURL(file));
		$(frm.image).attr("name","image");
		$(frm.image).css("width",400);
		$(frm.image).css("height",300);
		console.log(file);
	});
</script>
