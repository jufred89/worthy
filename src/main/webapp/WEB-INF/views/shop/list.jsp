<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<style>
#subject{
	font-size:150%; 
	font-weight:bold;
	letter-spacing:15px;
	word-spacing:5px;
	margin-left:50px;
}
 #searchType,#orderby{
	padding:5px;
	border: 1px solid #dadada;
}

#shop {
margin:0 auto;
width:1600px;
display: grid;
   grid-template-columns: repeat(4, 1fr);
   
}

#item{
margin-top:50px;
/* float:left;
   margin:5px;
   height:500px; */
}
#keyword{
	width:400px; padding:7px 10px; margin-left:5px;
	border:none;
	border-bottom:1px solid #dadada;
}
#total{display:inline-block; width:100px;}
</style>
<a href="/shop/insert">상품등록 버튼은 관리자페이지로 옮길 예정</a>

<div style="width:400px;
	margin:0 auto; text-align:center;">
	<div id="subject">CAMPING SHOP</div>
	<h5>캠핑상점</h5>
</div>
	<div id="condition">
		<div id="search">
		<!-- <select id="searchType">
				<option value="title">제품명</option>
				<option value="content">제품설명</option>
				<option value="all">제품명+제품설명</option>
			</select> -->
			<input type="text" id="keyword" placeholder="검색어 입력">
		 <span id="total"></span> 
		   <select id="searchType">
      <option value="new">최신순</option>
      <option value="price">낮은 가격순</option>
      <option value="price_desc">높은 가격순</option>
   </select>
		</div>
	
			
		</div>
	

<div id="shop"></div>
<script id="temp" type="text/x-handlebars-template">

   {{#each list}}
      <div id="item" onClick="location.href='/shop/read?prod_id={{prod_id}}'">
         <img src="/shop/display?file={{prod_image}}" width="350" height="350"/>
         <div style="padding-left:25px">
            <p>{{prod_name}}</p>
            <p class="saleprice">{{prod_saleprice}}</p>
            <p>{{prod_normalprice_f}}</p>
            <p>{{prod_detail}}</p>
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
      var orderby = $("#orderby").val();
      var searchType=$("#searchType").val();
   console.log(searchType)

      $.ajax({
         type : "get",
         url : "/shop/list.json",
         data : {
        	 
            "orderby":orderby,
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