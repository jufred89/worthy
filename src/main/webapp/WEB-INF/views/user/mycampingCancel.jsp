<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.slide {
   width: 1000px;
   margin: 0 auto;
}

* {
   margin: 0;
   padding: 0;
}

ul, li {
   list-style: none;
}

.slide {
   height: 300px;
   overflow: hidden;
}

.slide ul {
   width: calc(35% * 7);
   display: flex;
   animation: slide 13s infinite;
} /* slide를 8초동안 진행하며 무한반복 함 */
.slide li {
   width: calc(72%/ 7);
   height: 300px;
}

@
keyframes slide { 0% {
   margin-left: 0;
} /* 0 ~ 10  : 정지 */
20%
{
margin-left
:
0;
} /* 10 ~ 25 : 변이 */
50%
{
margin-left
:
-100%;
} /* 25 ~ 35 : 정지 */
70%
{
margin-left
:
-100%;
} /* 35 ~ 50 : 변이 */
100%
{
margin-left
:
0%;
}
}
#campReviewInsert {
   width: 200px;
   background: rgb(255, 20, 147);
   color: white;
   font-size: 15px;
   margin-top: 10px;
   padding: 10px;
   border-radius: 10px;
   border: none;
}
</style>
<style>
.container {
   width: 100%;
   text-align: left;
   margin-bottom: 50px;
}

.container h1 {
   text-align: left;
   margin-left: 20px;
   margin-bottom: 20px;
}

ul.tabs {
   margin: 0px;
   padding: 0px;
}

ul.tabs li {
   background: none;
   color: #222;
   display: inline-block;
   padding: 10px 15px;
   cursor: pointer;
}

ul.tabs li.current {
   color: #222;
   border-bottom: 1px solid black;
}

.tab-content {
   display: none;
   padding: 15px;
   border-top: 1px solid gray;
}

.tab-content.current {
   display: inherit;
}



.mycampingButton {
   background: black;
   color: white;
   border: none;
   padding: 10px 30px 10px 30px;
   border-radius: 10px;
   font-size: 15px;
   font-weight: bold;
   text-align: center;
}

.subcontent {
   padding: 10px;
   overflow: hidden;
   box-shadow: 3px 3px 3px 3px gray;
   margin-bottom: 40px;
   width:1000px;
   height:340px;
}

.subcontent .campReservMain {
   float: left;
}

.subcontent .campReservImage {
   float: left;
}

.campReservImage {
   width: 300px;
   height: 300px;
}

.campReservImage img {
   border-radius: 25px;
   width: 100%;
   height: 100%;
   object-fit: cover;
   border-radius: 25px;
}

.campReservMain {
   margin-left: 20px;
   width: 400px;
}

.campReservMain div {
   margin: 15px 0px 15px 0px;
}

.price {
   margin-top: 50px;
}

#campDetail {
   float: right;
   margin-right: 10px;
   margin-top: 10px;
}

.reservedBox {
   background: white;
   width:1100px;
}

.mycampingButton {
   background: rgb(204, 0, 0);
   color: white;
   border: none;
   padding: 10px 30px 10px 30px;
   border-radius: 10px;
   font-size: 15px;
   font-weight: bold;
   text-align: center;
}

select[name=cancelReason] {
   padding: 10px 20px 10px 20px;
   font-size: 20px;
   float: left;
}
.subheading{margin:30px;}
</style>
<div class="container">
   <h1 style="font-weight: bold;">캠핑 취소</h1>
   <ul class="tabs">
      <li class="tab-link current" data-tab="tab-1">1.예약 확인</li>
      <li class="tab-link" data-tab="tab-2" id="tab2">2.취소 사유</li>
      <li class="tab-link" data-tab="tab-3" id="tab3">3.취소 요청</li>
   </ul>
   <div id="tab-1" class="tab-content current">
      <div class="reservedBox">
         <div class="subheading">
            <h3 style="font-weight: bold;">취소할 예약을 다시 한번 확인해주세요.</h3>
         </div>
         <div class="subcontent">
            <div class="campReservImage">
               <img src="/camping/display?file=${campData.camp_image}" />
            </div>
            <div class="campReservMain">
               <div>
                  <h3>${campData.camp_name}/${campData.camp_room_no}</h3>
               </div>
               <div>
                  <h5 style="font-weight: bold;">캠핑장 위치</h5>
                  <h5>${campData.camp_addr}</h5>
               </div>
               <div>
                  <h5 style="font-weight: bold;">체크인</h5>
                  <h5>${campData.reser_checkin}오후2시</h5>
               </div>
               <div>
                  <h5 style="font-weight: bold;">체크아웃</h5>
                  <h5>${campData.reser_checkout}오전11시</h5>
               </div>
               <div class="price">
                  <h5 style="font-weight: bold;">결제금액</h5>
                  <h4>${campData.reser_price}원</h4>
               </div>
            </div>
            <div id="campDetail">
               <button id="campingCancelCheckBtn" class="mycampingButton">캠핑일정
                  취소하기</button>
            </div>
         </div>
      </div>
   </div>
   <div id="tab-2" class="tab-content">
      <div class="subheading">
         <h3 style="font-weight: bold;">취소 사유를 작성해주세요.</h3>
      </div>
      <div class="subcontent" style="width:1000px; height:115px; margin:0 auto; padding:30px 60px 30px 50px;">
         <div class="campCancelMain">
            <select name="cancelReason" style="width:600px;">
               <option>숙소가 마음에 들지 않아요.</option>
               <option>다른 괜찮은 숙소를 찾았어요.</option>
               <option>가격이 합리적이지 않아요.</option>
               <option>위치가 마음에 들지 않아요.</option>
            </select>
         </div>
         <div id="campDetail">
            <button id="campingCancelrequest" class="mycampingButton">취소 요청하기</button>
         </div>
      </div>
   </div>
   <div id="tab-3" class="tab-content">
<div id="sub">
   <div class="subheading">회원정보확인</div>

   <form name="frm" id="checkfrm">
      <div class="inputs">아이디</div><input type="text" value="${uid }"/><br>
      <div class="inputs">비밀번호</div><input type="password" name="upass"/><br/>   
      <div id="checkfrmBtns">
         <input type="submit" class="blackBtn" value="확인"/>
         <input type="reset" class="whiteBtn" value="취소"/>
      </div>
   </form>
</div>
   </div>
</div>
<script>
   $(document).ready(function() {
      $('ul.tabs li').click(function() {
         var tab_id = $(this).attr('data-tab');
         $('ul.tabs li').removeClass('current');
         $('.tab-content').removeClass('current');
         $(this).addClass('current');
         $("#" + tab_id).addClass('current');
      })
   })
</script>
<script>
   $("#campingCancelCheckBtn").on("click", function() {
      if (!confirm("취소하려는 예약이 맞습니까?"))
         return;
      $("#tab2").trigger("click");
   });
   $("#campingCancelrequest").on("click", function() {
      if (!confirm("결제가 취소되어 환불되는데 5~8일이 소요될 수 있습니다."))
         return;
      $("#tab3").trigger("click");
   });
</script>
<script>
   $(frm).on('submit',function(e){
      e.preventDefault();
      var uid="${uid}";
      var upass = $(frm.upass).val();
      if(upass==""){
         alert('비밀번호를 입력해주세요');
         $(frm.upass).focus();
         return;
      }
      
      $.ajax({
         type:'post',
         url:'/checkMyinfo',
         data:{"upass":upass},
         success:function(data){
            if(data==1){
               alert("캠핑예약이 취소됩니다.")
               var reser_no="${campData.reser_no}"
               $.ajax({
                  type:'post',
                  url:"/mycampingCancelRequest",
                  data:{reser_no:reser_no},
                  success:function(){
                     location.href='/mypage?uid='+uid;
                  }
               })
            }else{
               alert('비밀번호가 일치하지 않습니다.');
            }
         }
      });
   });
</script>