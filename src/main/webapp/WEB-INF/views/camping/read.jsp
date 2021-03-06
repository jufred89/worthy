<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<style>
#campBody {
   width: 1500px;
   margin: 0px auto;
   padding:0 30px 30px 30px;
}

#campingReadBox1 {
   width: 1500px;
   margin: 0px auto;
   padding: 10px;
   overflow: hidden;
}

#campingReadBox1 h1 {
   font-weight: bold;
   text-align: left;
}
h1{font-size:30px;}
h2{font-size:20px;}
h3{font-size:18px;}
h4{font-size:17px;}
h5{font-size:15px;}
#campMainImage {
   width: 700px;
   height: 570px;
   float: left;
}

.campImage {
   width: 385px;
   height: 290px;
   float: left;
}

.image-thumbnail {
   width: 100%;
   height: 100%;
   object-fit: cover;
   border-radius: 25px;
}

.image-thumbnail2 {
   width: 100%;
   height: 100%;
   object-fit: cover;
   border-radius: 25px;
}

#campInformationBox {
   width: 70%;
   margin: 0px auto;
   padding: 20px;
   float: left;
}

#campInformationBox h2 {
   text-align: left;
   font-weight: bold;
}

#campInformationBox h4 {
   text-align: left;
   padding: 10px;
   line-height: 160%
}

#campingStyleRead {
   margin: 0px auto;
   padding: 20px;
}

#campingFacilityRead {
   padding: 20px;
   height:300px;
}

#campingStyleRead h2 {
   text-align: left;
   font-weight: bold;
}

#campingFacilityRead h2 {
   text-align: left;
   font-weight: bold;
}

#campSubBox {
   overflow: hidden;
}

#reserve_box {
   border: 1px solid rgb(230, 230, 230);
   float: right;
   width: 25%;
   height: 65%;
   padding: 50px;
   border-radius: 30px;
   background: rgb(242, 242, 242);
   margin:30px;
}

#reserve_box span {
   font-size: 20px;
   font-weight: bold;
   text-align: left;
   display: block;
}
#reserve_box h4, #reserve_box input[type=radio] {
   font-size: 18px;
   font-weight: normal;
   text-align: left;
   margin-bottom: 40px;
   margin-left:10px;
}

#reserve_box button {
   width: 210px;
   background: black;
   color: white;
   font-size: 18px;
   margin-top: 50px;
   padding: 10px;
   border-radius: 20px;
   box-shadow: 5px 5px 5px gray;
}

#available_reser {
   font-size: 18px;
   text-align: left;
}

#available_reser div {
   padding: 10px 0px 10px 0px;
}

#available_reser input[type=radio] {
   width:15px;
   height:15px;
   margin: 5px;
}
#mapBox{
   margin-bottom:40px;
}
#mapBox h2 {
   text-align: left;
   font-weight: bold;
   padding: 20px;
}
#pageLike{
   text-align: right;
   margin-right: 30px;
   margin-bottom:10px;
   cursor: pointer;
}
#campingReviews{
   overflow: hidden;
}
#campingReviews h2{
   text-align: left;
   font-weight: bold;
   padding: 20px;
}
.campingReviewer{
   float: left;
   width: 33%;
   height: 150px;
   padding: 10px;
   overflow: hidden;
   background: rgb(242, 242, 242);
}
.campingReviewerImage{
   float: left;
   margin: 10px;
}
.campingReviewerImage img{
   border-radius:35px;
   border: 3px solid black;
}
.campingReviewTop{
   float: left;
   text-align: left;
   padding: 5px;
}
.campingReviewBottom{
   clear: left;
   text-align: left;
   padding: 5px;
}
.camp_ruid{
   font-size: 20px;
   margin: 10px;
}
.main_common{
   padding:8px;
    display: inline-block;
    width: 100px;
    height: 100px;
    border: 1px solid gray;
    border-radius:5px;
    margin: 2px;
    float: left;
}
.main_common2{
}
#facilityList{
   width: 1000px;
    background: yellow;
}
#styleList{
   width: 1000px;
}
</style>


<!-- ????????? ?????? ?????? -->
<div id="campBody">
   <div id="campingReadBox1">
      <div>
         <h1>${cvo.camp_name}</h1>
         <h3 id="from_addr">${cvo.camp_addr}</h3>
         <div id="pageLike">
            <c:if test="${likeCheck==0 }">
               <img src="/resources/heart.png" title="?????????" width=40 id="bntLike" />
            </c:if>
            <c:if test="${likeCheck!=0 }">
               <img src="/resources/heart_colored.png" title="???????????????" width=40
                  id="bntLike" />
            </c:if>
         </div>
      </div>
      <div id="campMainImage">
         <img class="image-thumbnail"
            src="/camping/display?file=${cvo.camp_image}" />
      </div>
      <div id="campSubImages">
         <c:forEach items="${attList}" var="camp_image">
            <div class="campImage">
               <img class="image-thumbnail2"
                  src="/camping/display?file=${camp_image}" width=250
                  style="padding: 10px;" />
            </div>
         </c:forEach>
      </div>
   </div>
   <div id="campSubBox">
      <div id="campInformationBox">
         <div>
            <h2>???????????? ?????? ????????????</h2>
            <h4>${cvo.camp_memo}</h4>
         </div>
         <div>
            <h2>???????????? ?????????</h2>
            <h4>${cvo.camp_detail}</h4>
         </div>
      </div>
      <div id="reserve_box">
         <span>?????????</span>
         <h4>${reser_checkin}</h4>
         <span>????????????</span>
         <h4>${reser_checkout}</h4>
         <span>??????</span>
         <div id="cal_daytrip"></div>
         <!-- ?????? ???????????? ????????? ????????? ????????? ?????? ????????? ?????? ?????? -->
         <span>?????????????????????</span>
         <div id="available_reser">
            <c:forEach items="${reserList}" var="rvo">
               <c:if test="${rvo.style_qty-rvo.reser_count eq 0}">
                  <div>
                     <input type="radio" name="camp_style_list"
                        value="${rvo.style_no}" price="${rvo.style_price}" disabled
                        dir="ltr" />${rvo.style_name}|${rvo.style_qty-rvo.reser_count}???|${rvo.style_price}
                  </div>
               </c:if>
               <c:if test="${rvo.style_qty-rvo.reser_count ne 0}">
                  <div>
                     <input type="radio" name="camp_style_list"
                        value="${rvo.style_no}" price="${rvo.style_price}" dir="ltr" />${rvo.style_name}|${rvo.style_qty-rvo.reser_count}???|${rvo.style_price}
                  </div>
               </c:if>
            </c:forEach>
         </div>
         <!-- ?????????????????? ???????????? -->
         <button onclick="reservePage()">????????????</button>
      </div>
      <div id="campInformationBox2">
         <!-- ????????? ????????? ?????? -->
         <div id="campingStyleRead">
            <h2>????????? ?????????</h2>
            <div id="styleList">
               <c:forEach items="${styleList}" var="svo">
               <c:if test="${svo.style_name=='?????????'}">
                  <div class="main_common2">
                     <img src="/resources/kind/???????????????.png" width=70px/>
                     <h4>${svo.style_name}|${svo.style_qty}???|${svo.style_price}???</h4>
                  </div>
               </c:if>
               <c:if test="${svo.style_name=='???????????????'}">
                  <div class="main_common2">
                     <img src="/resources/kind/???????????????.png" width=70px/>
                     <h4>${svo.style_name}|${svo.style_qty}???|${svo.style_price}???</h4>
                  </div>
               </c:if>
               <c:if test="${svo.style_name=='??????????????????'}">
                  <div class="main_common2">
                     <img src="/resources/kind/????????????.png" width=70px/>
                     <h4>${svo.style_name}|${svo.style_qty}???|${svo.style_price}???</h4>
                  </div>
               </c:if>
               </c:forEach>
            </div>
         </div>
         <!-- ?????? ?????? ?????? -->
         <div id="campingFacilityRead">
            <h2>????????? ??????</h2>
            <div id="facilityList">
               <c:forEach items="${facilityList}" var="fvo">
                  <div class="main_common">
                        <img src="/resources/kind_comporable/${fvo.facility_name}.png" width=50px/>
                        <h4>${fvo.facility_name}</h4>
                  </div>
               </c:forEach>
            </div>
         </div>
      </div>
   </div>
   <div id="campingReviews">
      <h2>????????? ??????</h2>
      <c:forEach items="${campReviewList}" var="crlvo">
      <div class="campingReviewer">
         <div class="campingReviewerImage">
            <img src="/resources/person.png" width=70 height=70 />
         </div>
         <div class="campingReviewTop">
            <div class="camp_ruid">${crlvo.camp_ruid}</div>
            <div class="camp_reviewdate">${crlvo.camp_reviewdate_f}</div>
         </div>
         <div class="campingReviewBottom">
            <div>${crlvo.camp_review}</div>
         </div>
      </div>
      </c:forEach>
   </div>
   <!-- ?????? ?????? ?????? -->
   <div id="mapBox">
      <h2>????????? ??????</h2>
      <div id="map" style="width: 100%; height: 400px; z-index: -1;"></div>
   </div>
</div>
<script>
   var camp_id = '${cvo.camp_id}';
   var reser_checkin = '${reser_checkin}';
   var reser_checkout = '${reser_checkout}';
   caldaytrip();
   // ??? ??? ???????????? ????????????
   function caldaytrip() {
      var start_date = new Date(reser_checkin);
      var end_date = new Date(reser_checkout);
      var cal_daytrip = (end_date - start_date) / (1000 * 60 * 60 * 24);
      $("#cal_daytrip").html("<h4>" + cal_daytrip + "???" + "</h4>");
   }
   // ??????????????? ????????? ????????? ?????? ?????? ??????????????????
   Handlebars.registerHelper("availablereser",
         function(style_qty, reser_count) {
            if (reser_count == null) {
               return style_qty
            } else {
               return style_qty - reser_count
            }
         });
   // ?????????????????? ??????
   function reservePage() {
      var style_no = $("input[name='camp_style_list']:checked").val();
      var style_price = $("input[name='camp_style_list']:checked").attr(
            "price");
      if (style_no == null) {
         alert("????????? ??????????????????.")
         return;
      }
      if(!confirm("?????????????????? ???????????????.")) return;
      location.href = "/camping/checkout?camp_id=" + camp_id + "&style_no="
            + style_no + "&style_price=" + style_price + "&reser_checkin="
            + reser_checkin + "&reser_checkout=" + reser_checkout
   }
</script>
<!-- ?????? ????????? ?????? ????????? -->
<script>
//????????? ?????? ????????? ??????
$('#pageLike').on('click',function(){
   var likeCheck = "${likeCheck}";
   $.ajax({
      type:'post',
      url:'/camping/like',
      data:{"likeCheck":likeCheck,"uid":uid,"camp_id":camp_id},
      success: function(){
         location.href="/camping/read?camp_id="+camp_id+"&reser_checkin="+reser_checkin+"&reser_checkout="+reser_checkout;
      }
   });
});
</script>
<!-- ????????? ????????? ???????????? T??? ???????????? ????????? ????????? ??????????????? ????????? ???????????? -->
<!-- ?????? ?????? API .js -->
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=437cd2932e9baa6f039994ed90c57549&libraries=services"></script>
<script>
   var camping_addr = "${cvo.camp_addr}"
   var camping_name = "${cvo.camp_name}"
   if (camping_addr != null) {
      console.log(camping_addr);
      var mapContainer = document.getElementById('map') // ????????? ????????? div 
      var mapOption = {
         center : new kakao.maps.LatLng(33.450701, 126.570667), // ????????? ????????????
         level : 3
      // ????????? ?????? ??????
      };

      // ????????? ???????????????    
      var map = new kakao.maps.Map(mapContainer, mapOption);

      var geocoder = new kakao.maps.services.Geocoder();

      // ????????? ????????? ???????????????
      geocoder
            .addressSearch(
                  camping_addr,
                  function(result, status) {

                     // ??????????????? ????????? ??????????????? 
                     if (status === kakao.maps.services.Status.OK) {
                        var coords = new kakao.maps.LatLng(result[0].y,
                              result[0].x);

                        // ??????????????? ?????? ????????? ????????? ???????????????
                        var marker = new kakao.maps.Marker({
                           map : map,
                           position : coords
                        });

                        var iwContent = '<div style="width:250px;text-align:center;padding:2px 0;">'
                        iwContent += '<h4 style="font-weight:bold">'
                              + camping_name + '</h4>' + '<hr/>'
                        iwContent += '<h5>' + camping_addr + '</h4>'
                        iwContent += '</div>'
                        iwRemoveable = true

                        // ?????????????????? ????????? ?????? ????????? ???????????????
                        var infowindow = new kakao.maps.InfoWindow({
                           content : iwContent,
                           removable : iwRemoveable
                        });

                        // ????????? ?????????????????? ???????????????
                        kakao.maps.event.addListener(marker, 'click',
                              function() {
                                 // ?????? ?????? ?????????????????? ???????????????
                                 infowindow.open(map, marker);
                              });

                        // ????????? ????????? ??????????????? ?????? ????????? ??????????????????
                        map.setCenter(coords);
                     }
                  });
   }
</script>