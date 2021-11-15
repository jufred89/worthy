<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <style>
#background_image{
background-image:url("../resources/back.jpg");
/* background:black; */
 background-size : cover;
 height: 85vh;
background-repeat:no-repeat;
}
#search_box{
position:absolute;
top:200px;
bottom:0;
left:0;
right:0;
height:200px;

}
#search_box h1{
	color:white;
	font-weight:bold;
	font-size:270%;
	margin-bottom:40px;
}
#search_box input[type='text']{
background-image:url("../resources/search.png");
background-repeat:no-repeat;
background-size:20px;
background-position:97%;
  width: 500px;
  height: 50px;
  box-sizing: border-box;
  border:none;
  border-radius: 30px;
  padding:20px;
  font-weight:bold;
}

</style>
<c:if test="${uid.indexOf('admin')==-1 || uid==null}">
    <div id="background_image">
    
    <div id="search_box">
 <h1>어디로 떠날까요?</h1>
 <input type="text" name="camp_addr">
 <input type="text" name="reser_checkin">
 <input type="text" name="reser_checkout">
</div>

</div>
</c:if>


<script>
$('#search_box').on('keypress','input',function(e){
   if(e.keyCode==13){
   var camp_addr=$('#search_box input[name=camp_addr]').val()
   var reser_checkin=$('#search_box input[name=reser_checkin]').val()
   var reser_checkout=$('#search_box input[name=reser_checkout]').val()
   alert(camp_addr+"/"+reser_checkin+"/"+reser_checkout)
	location.href = "/camping/list?camp_addr=" + camp_addr
	+ "&reser_checkin=" + reser_checkin + "&reser_checkout="+reser_checkout
   }
})
</script>