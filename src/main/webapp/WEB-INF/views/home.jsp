<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<html>
<head>
<title>워디 : 캠핑 어디까지 가봤어?</title>


<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>




<script
   src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
   href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
   

<link rel="stylesheet" href="../resources/home.css" />

<script src="../resources/bootstrap-datepicker.js"></script>
<link rel="stylesheet" href="../resources/bootstrap-datepicker.css">
<style type="text/css">
body{
position: relative;
}
.cal_top{
margin-top:20px;
    text-align: center;
    font-size: 30px;
}
.cal{
    text-align: center; 
   
     
}
#cal_tab{
margin-top:20px;
}
table.calendar{
    border: 1px solid black;
    display: inline-table;
    text-align: left;
     
}
table.calendar td{
    vertical-align: top;
    border: 1px solid skyblue;
    width: 100px;
}

.img_icon1,.img_icon2{
display:flex;
flex-flow:row wrap;
justify-content:center;
align-content:center;
}
.img_icon1 img,.img_icon2 img{
width:50px;
height:50px;
margin:5px;
}
.selected,.selected2{
box-sizing:initial;
border:2px solid coral;
}


#icon_style div,#icon_facil div{
margin:20px;
}
#icon_style div p,#icon_facil div p{
display:flex;

justify-content:center;
align-items:center;
}


</style>
</head>
<body>

   <div id="header">

   <nav class="navbar navbar-inverse navbar-fixed-top">
     <div class="container-fluid">
       <div class="navbar-header col-sm-2">
         
        
          <img src="/resources/worthycamping_logo_sample3.png" id="logo" onClick="location.href='/'" width=150 style="margin-top:0;"></img>
      
    </div>
   <%--  <c:if test="${uid.indexOf('admin')==-1 || uid==null}">
    <div class="nav navbar-nav col-sm-4">
   <div id="info_search_box" >
    <div id="search_where"><input class="form-control"  type="text" placeholder="어디로?"> </div>
      
<div class="input-group input-daterange">
    <input type="text" id="start" class="form-control"  placeholder="언제부터">
    <input type="text" id="end" class="form-control"placeholder="언제까지">
</div>
    </div>
    </div>
    </c:if>
 --%>
    <div class="nav navbar-nav col-sm-4">
   
 
    </div>
    
    
 
    <div class="nav navbar-nav navbar-right col-sm-6" id="menus">
  
<div>
            <a href='/camping/list?camp_addr=&reser_checkin=&reser_checkout=' >캠핑검색 </a>
         </div> 
         <div>
            <a href="/notice/list">캠핑정보 </a>
         </div>
         <div>
            <a href="/shop">캠핑상점 </a>
         </div>
         <div>
            <a href="/board/list">자유게시판</a>
         </div>
         
         
           
         
            <c:if test="${uid!=null}">
               <div style="float:right;">
                 <c:choose>
               <c:when test="${uid eq 'admin'}">
                  <a style="" href="/admin">${uid}</a><span style="display:inline-block;margin-right:10px;">님 환영합니다! </span>
                    </c:when>
                    <c:otherwise>
                    <a style="" href="/mypage?uid=${uid}">${uid}</a><span style="display:inline-block;margin-right:10px;">님 환영합니다! </span>
                    </c:otherwise>
                  </c:choose>
                  <c:choose>
                  <c:when test="${uid eq 'admin'}">
                   
                  <a href="/user/logout" id="logout"><span class='glyphicon glyphicon-share-alt'></span>LOGOUT</a>
                  </c:when>
                  <c:otherwise>
                  <a href="/mycart">
                  <img src="../resources/shop.png" width=40 height=40 style="margin:0 5px;"/>
                  </a>
                  <a href="/user/logout" id="logout"><span class='glyphicon glyphicon-share-alt'></span>LOGOUT</a>
                  </c:otherwise>
                  </c:choose>
               </div>
               
                <!-- <div><a href="/mypage">Mypage</a></div> -->
         </c:if>
         <c:if test="${uid==null}">
            <div style="margin-right:10px;">|</div>
            <div id="login_join_imoticon" >
                  <a href="/mycart">
             <img src="../resources/shop.png" width=40 height=40 style="margin:0 5px;"/>
                  </a>
               <a href="/user/login" ><span class="glyphicon glyphicon-log-in"></span> LOGIN</a>
               <a href="/user/join"><span class="glyphicon glyphicon-user"></span>SIGN UP</a>
            </div>
         </c:if>
    </div>
  </div>
</nav>
      
   

   
   </div>
   <!-- 모달창2시작 -->
         <div class="modal" id="myModal3" style="z-index: 99">
            <div class="modal-dialog">
               <div class="modal-content" style="height: 900px;">

                  <!-- Modal Header -->
                  <div class="modal-header">
                     
                     <h1 style="font-weight:20px;color:gray;">테마검색</h1>
                     

                  </div>

                  <!-- Modal body -->
                  <div class="modal-body" style="">
                  
                  
                     <h3>캠핑스타일</h3>
                     <div style="display:flex;justify-content:space-between;">   
                     <p style="color:coral; " >원하는 캠핑 스타일을 선택 후 검색버튼을 클릭하세요!</p>
                     <p style="color:red;" >*1개까지 선택이 가능합니다.</p>
                     </div>
                     <div class="img_icon1" id="icon_style">
                      <div>
                     <img src="../resources/kind/글램핑시설.png" alt='1'>
                     <p>글램핑시설</p>
                     </div>
                     <div>
                     <img src="../resources/kind/방갈로.png" alt='2'>
                     <p>방갈로</p>
                     </div>
                     <div>
                     <img src="../resources/kind/오토캠핑.png"alt='3'>
                     <p>오토캠핑</p>
                     </div>
                     <div>
                     <img src="../resources/kind/카라반시설.png" alt='4'>
                       <p>카라반시설</p>
                       </div>
                     </div>
                     <hr>
                     <!-- <h3 style="margin-top: 30px;">자연환경</h3>
                     <div class="img_icon">
                     <img src="../resources/nature/강변.png">
                     <img src="../resources/nature/계곡.png">
                     <img src="../resources/nature/공원.png">
                     <img src="../resources/nature/국립공원.png">
                     <img src="../resources/nature/낚시터.png">
                     <img src="../resources/nature/농촌.png">
                     <img src="../resources/nature/도심.png">
                     <img src="../resources/nature/바다.png">
                     <img src="../resources/nature/산.png">
                     <img src="../resources/nature/섬.png">
                     <img src="../resources/nature/유원지.png">
                     <img src="../resources/nature/자연휴야림.png">
                     <img src="../resources/nature/lake.png">
                     </div>
                     <hr> -->
                     <h3>캠핑스타일</h3>
                     <div style="display:flex;justify-content:space-between;">      
                     <p style="color:coral;" >원하는 캠핑 스타일을 선택 후 검색버튼을 클릭하세요!</p>
                     <p style="color:red;" >*5개까지 선택이 가능합니다.</p>
                     </div>
                        <div class="img_icon2" id="icon_facil">
                        <div>
                     <img src="../resources/kind_comporable/개수대.png" alt="15">
                        <p>개수대</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/동계캠핑.png" alt="15">
                   <p>동계캠핑</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/매점.png" alt="11">
                      <p>매점</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/반려동물동반.png" alt="15">
                      <p>반려동물동반</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/샤워시설.png" alt="14">
                     <p>샤워시설</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/수세식화장실.png" alt="13">
                     <p>수세식화장실</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/온수제공.png" alt="4">
                     <p>온수제공</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/와이파이.png" alt="2">
                     <p>와이파이</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/잔디광장.png" alt="8">
                     <p>잔디광장</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/장작판매.png" alt="3">
                     <p>장작판매</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/재래식화장실.png" alt="13">
                     <p>재래식화장실</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/전기.png" alt="1">
                     <p>전기</p>
                     </div>
                     <div>
                     <img src="../resources/kind_comporable/캠핑용품대여.png" alt="15">
                     <p>캠핑용품대여</p>
                     </div>
                     
               
                     </div>
                  </div>

                  <!-- Modal footer -->
                  <div class="modal-footer">
                  <button type="button" id="d_start" class="btn-search btn--primary">검색할까요?</button>
                  </div>
               </div>
            </div>
         </div>
         
         <!-- 모달창2끝 -->
   <div id="center">
    <div id="content">
      
         

         <jsp:include page="${pageName}"></jsp:include>
       </div>
      
   </div>
   
    <c:if test="${pageName == 'about.jsp'}">
            <div id="footer">
   <img src="/resources/worthycamping_logo_sample3.png" width=100 style="margin-left:20px;"/>
   <p style="margin-right:20px;">Created by worthy. © 2021</p>
   </div>
      </c:if>
      <c:if test="${pageName != 'about.jsp'}">
          <div id="footer2">
    <img src="/resources/logowhite.png" width=100 style="margin-left:20px;"/>
   <p style="margin-right:20px;">Created by worthy. © 2021</p>
   </div>
   </c:if>
</body>
<script>

var end=1;
var arr=new Array(5);
var num=$('.num').text()
var uid="${uid}"
var selectedClass=0;
var selectedClass2=0;


function selectedSearch(){
$('#icon_facil .selected2').each(function(i){
   arr[i]=$(this).attr('alt')
   console.log(arr)
})
}

$('#start').on('click',function(){
   end=0;
   
});
$('#end').on('click',function(){
   
   end=1;
});

$('#start,#end').datepicker({
   format: "yyyy-mm-dd",   
   startDate: '0d',   
   autoShow:true,
    language : "ko"   
       
   })
   
$("#search_local").on("click","ul li",function(){
   var s_input=$(this).parent().parent().find($("#local"))
    var s_li=$(this).text();
   s_input.val(s_li)
})

   
 $("div.input-daterange").each(function(){
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

$('#d_start').on('click',function(){
   if(end==0){
      alert('언제까지 갔다오실까요?')
      return;
   }
   if(!confirm('이 기간동안 떠나시나요?'))return;
})
$('.img_icon1').on('click','img',function(){
   
   $(this).toggleClass('selected')
   if($(this).hasClass('selected')){
      selectedClass++;
   }else{
      selectedClass--;
   }
   if(selectedClass>1){
      $(this).removeClass('selected')
      alert('1개까지 선택이 가능하세요!')
   
   }
})
$('.img_icon2').on('click','img',function(){
   
   $(this).toggleClass('selected2')
   if($(this).hasClass('selected2')){
      selectedClass2++;
   }else{
      selectedClass2--;
   }

   if(selectedClass2>5){
      $(this).removeClass('selected2')
      alert('5개까지 선택이 가능하세요!')
         selectedSearch()
   }
})
$('.navbar-header').on('click','h2',function(){
   if(uid.indexOf('admin')!=-1){
      location.href='/admin'
   }else{
      location.href='/'
   }
})
</script>
</html>