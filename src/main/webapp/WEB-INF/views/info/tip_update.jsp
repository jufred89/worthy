<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	frm{width:960px;margin:0 auto; padding:15px;}
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
	textarea{margin:15px;}
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
</style>
<h1>팁 수정</h1>
<form name="frm" action="/tip/update" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="tip_no" value="${vo.tip_no}"/>
	<input type="text" name="tip_title" style="margin-bottom:15px; width:730px;" value="${vo.tip_title}" placeholder="제목을 입력하세요"/><br/>
		<div id="imageBox">
			<img name="image" src="/tip/display?file=${vo.tip_image}" style=" width:400px; height:300px;"/>
			<input type="hidden" name="oldImage" value="${vo.tip_image}"/>
			<input type="file" name="file" style="display:none;"/>
			<div id="file"><input type="file" name="files" accept="image/*" multiple/></div>
		</div>
	    <div id="oldFiles">
			<c:if test="${att!=null}">
				<c:forEach items="${att}" var="list">
					<span class="att">
						<img src="/tip/display?file=/${vo.tip_no}/${list}" width=150 height=100 class="attImg"/>
						<input type="hidden" value="${list}" class="attVal">
					</span>
				</c:forEach>		
			</c:if>
			<span id="files"></span>
		</div>
	<textarea rows="10" cols="100" name="tip_content" placeholder="내용을 입력하세요">${vo.tip_content}</textarea>
	<hr/>
	<input type="submit" value="수정"/>
	<input type="reset" value="수정취소" onClick="location.href='/tip/list'"/>
</form>
<script>
	//수정 클릭시
	$(frm).on("submit",function(e){
		e.preventDefault();

		var tip_content=$(frm.tip_content).val();
		var tip_title=$(frm.tip_title).val();
		
		if(tip_title=="" || tip_content==""){
			alert("글의 제목과 내용을 입력해주세요!");
			return;
		}
		if(!confirm("팁을 수정 하시겠습니까?")) return;
		frm.submit();
	});	
	

	//파일첨부 클릭시
	$(frm.files).on("change", function(){
		var files=$(this)[0].files;
		var str="";
		$.each(files, function(index, file){
			str += "<img src='" + URL.createObjectURL(file) + "'";
			str += "style='width:150px;height:100px;display:inline;'/>";
		});
		$("#files").append(str);
	});

	//이미 첨부되있던 이미지 클릭시
	$(".att").on("click", function(){
		var image = $(this).children(".attVal").val();
		var tip_no=$(frm.tip_no).val();
		
		//console.log(image + nb_no);
		
		if(!confirm("첨부 이미지를 삭제하시겠습니까?"))return;
		$(this).remove();
		$.ajax({
			type:"post",
			url:"/tip/attDel",
			data:{"image":image, "tip_no":tip_no},
			success:function(){}
		});
	});
	
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
		$(frm.image).css("width",400);
		$(frm.image).css("height",300);
		console.log(file);
	});
</script>
