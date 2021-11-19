<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
    <style>
   
   #pop{
  
   display:none;
	position: relative;
	background:black;
	border-radius: .4em;
	width:250px;
	height:170px;
	color:white;
margin-top:20px;
}
#pop:after {
	content: '';
	position: absolute;
	top: 0;
	left: 50%;
	width: 0;
	height: 0;
	border: 20px solid transparent;
	border-bottom-color: black;
	border-top: 0;
	margin-left: -20px;
	margin-top: -20px;
}
#pop ul{
flex-flow:wrap;
list-style:none;
display:flex;
justify-content:center;
align-content:center;
padding:10px;
}
#pop ul li{

width:50px;
height:50px;
display:flex;
justify-content:center;
align-items:center;
}
#pop ul li:hover{

background:white;
color:black;
}
#background_image{
background-image:url("../resources/back.jpg");
/* background:black; */
 background-size : cover;
 height: 85vh;
background-repeat:no-repeat;
}
#search_box{
top:300px;
position:absolute;
bottom:0;
left:0;
right:0;
height:200px;
display:flex;
justify-content:center;
align-content:center;

}
#background_image h1{
top:200px;
position:absolute;
bottom:0;
left:0;
right:0;

	color:white;
	font-weight:bold;
	font-size:270%;
	margin-bottom:40px;
}
#search_box input[type='text']{

  width: 250px;
  height: 50px;
  box-sizing: border-box;
  border:none;
 border-radius:10px;
  padding:20px;
  font-weight:bold;
}
#search_btn{
background-image:url("../resources/search.png");
background-repeat:no-repeat;
background-size:20px;
background-position:50%;
height:50px;
width:70px;
border-radius:10px;
}
#time input{
margin-right:5px;
}
</style>
<c:if test="${uid.indexOf('admin')==-1 || uid==null}">
    <div id="background_image">
    
 <h1>어디로 떠날까요?</h1>
 <form>
    <div id="search_box">
   <div class="input-group input-daterange" style="margin-right:5px;">
 <input type="text" name="camp_addr" placeholder="어디로?" id="where" value="">
   <div id='pop' class='pop' >

							
							<ul>
							<li>전체</li>
							<li>제주</li>
							<li>강원</li>
							<li>부산</li>
							<li>경기</li>
							<li>충청</li>
							<li>경상</li>
							<li>전라</li>
							<li>인천</li>
							<li>대전</li>
							<li>대구</li>
							<li>울산</li>
							</ul>
								</div>
 
	</div>	
 
<div class="input-group input-daterange" id="time">
    <input type="text" id="start" class="form-control" name="reser_checkin" placeholder="언제부터?" value="">

    <input type="text" id="end" class="form-control" name="reser_checkout" placeholder="언제까지?">
    <input type="button" id="search_btn">

</div>


   
 </div>
 </form>
</div>
</c:if>


<script>
$("#where").mouseover(function(){
	$('#pop').css('display','block')
})

$('html').click(function(e) { if(!$(e.target).hasClass("pop")) { $('#pop').css('display','none')} });
 
$('#pop').on('click','ul li',function(){
var where=$(this).parent().parent().parent().find($('#where'))
	where.val($(this).text())
})
$('#start,#end').datepicker({
	format: "yyyy-mm-dd",	
	startDate: '0d',	
	autoShow:true,
    language : "ko"	
	    
	})
$('#search_btn').on('click',function(e){
  
   var camp_addr=$('#search_box input[name=camp_addr]').val()
   var reser_checkin=$('#search_box input[name=reser_checkin]').val()
   var reser_checkout=$('#search_box input[name=reser_checkout]').val()
   alert(camp_addr+"/"+reser_checkin+"/"+reser_checkout)
	location.href = "/camping/list?camp_addr=" + camp_addr
	+ "&reser_checkin=" + reser_checkin + "&reser_checkout="+reser_checkout
   
})

 $("div#time").each(function(){
    var $inputs = $(this).find('input');
   
   // $inputs.datepicker("setDate", new Date());
    if ($inputs.length >= 2) {
        var $from = $inputs.eq(0);
        var $to   = $inputs.eq(1);
        $from.on('changeDate', function (e) {
            var d = new Date(e.date.valueOf());

        
            $to.datepicker('setStartDate', d); // 종료일은 시작일보다 빠를 수 없다.
        });
        $to.on('changeDate', function (e) {
            var d = new Date(e.date.valueOf());
            $from.datepicker('setEndDate', d); // 시작일은 종료일보다 늦을 수 없다.
        });
    }
    
}) 
</script>