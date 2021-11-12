<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <style>
#background_image{
/* background-image:url("../resources/img121.jpg"); */
background:black;
 background-size : cover;
 height: 80vh;


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
}
input[type='text']{
background-image:url("../resources/search.png");
background-repeat:no-repeat;
background-size:20px;
background-position:98%;
text-align:center;
  width: 500px;
  height: 40px;
  box-sizing: border-box;
  outline: none;
  border-radius: 30px;
}

</style>
<c:if test="${uid.indexOf('admin')==-1 || uid==null}">
    <div id="background_image">
    
    <div id="search_box">
 <h1>어디로 떠날까요?</h1>
 <input type="text" >
</div>

</div>
</c:if>


<script>
$('#search_box').on('keypress','input',function(e){
   if(e.keyCode==13){
   var keyword=$('#search_box input').val()
   alert(keyword)
   }
})

</script>