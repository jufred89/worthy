<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<link rel="stylesheet" href="../resources/shop.css" />
<a href="/shop/insert">상품등록 버튼은 관리자페이지로 옮길 예정</a>

<div style="width:400px;
	margin:0 auto; text-align:center;">
	<div id="subject">CAMPING SHOP</div>
	<h5>캠핑정보</h5>
</div>
<div id="container">	
<div id="condition">
   <input type="text" id="keyword" placeholder="검색어 입력"> 
   <span id="total"></span> 

   <select id="searchType">
      <option value="new">최신순</option>
      <option value="price">낮은 가격순</option>
      <option value="price_desc">높은 가격순</option>
   </select>
   
</div>
<div id="shop"></div>
<script id="temp" type="text/x-handlebars-template">

   {{#each list}}
      <div id="item" onClick="location.href='/shop/read?prod_id={{prod_id}}'">
         <img src="/shop/display?file={{prod_image}}" width="350" height="350"/>
         <div class="item_info">
            <p class="prod_name">{{prod_name}}</p>
            <p class="prod_saleprice">{{prod_saleprice}}원</p>
            <p class="prod_normalprice">{{prod_normalprice_f}}원</p>
            <p class="prod_detail">{{prod_detail}}</p>
         </div>
      </div>
   {{/each}}

</script>
</div>
<script>

   getList();
   
   //정렬 순서
   $("#searchType").on("change", function(e){
      e.preventDefault();
      
      
      
      getList();
   });

   //검색창 엔터 입력
   $("#keyword").on("keypress", function(e) {
      if (e.keyCode == 13) {
         page = 1;
         getList();
      }
   });
   
   //한페이지 출력수
   $("#perPageNum").on("change", function(){
      page=1;
      getList();
   });

   
   function getList() {
      
      var keyword = $("#keyword").val();
      var searchType = $("#searchType").val();
   console.log(searchType)

      $.ajax({
         type : "get",
         url : "/shop/list.json",
         data : {
            
            "keyword" : keyword,
            "searchType" : searchType,
            
         },
         dataType : "json",
         success : function(data) {
            var temp = Handlebars.compile($("#temp").html());
            $("#shop").html(temp(data));
         
            
            $("#total").html("검색건: " + data.pm.totalCount + "건");
         }
      });
   }

   $("#pagination").on("click", "a", function(e) {
      e.preventDefault();

      page = $(this).attr("href");
      getList();
   });
</script>