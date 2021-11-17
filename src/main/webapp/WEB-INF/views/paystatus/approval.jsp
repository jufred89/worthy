<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>결제 승인</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>

</head>
<body>
		<% 
			String pg_token = request.getQueryString().toString();
			request.setAttribute("pg_token", pg_token);
		%>		
		<h2>결제가 완료되었습니다.</h2>
		<div id="payment">
          	<div>주문번호 <span id="aid"></span></div>
          	<div>상품 <span id="item_name"></span> 포함 <span id="quantity"></span>건
          	</div>
          	<div>결제금액 <span id="total"></span></div>
          	<div>결제일시 <span id="approved_at"></span></div>
          	<div>결제방법 <span id="payment_method_type"></span></div>
          	<button 
				onclick="opener.parent.location.reload(); self.close() ">닫기</button>
		</div>

		
	<script>
	var pg_token = "${pg_token}";
	var tid = localStorage.getItem("tid"); //mycart.jsp에서 세션에 저장한 tid 가져오기
	
	
		$.ajax({
			type:'post',
			url:'/shop/kakaoPayApproval',
			data:{"pg_token":pg_token, "tid":tid},
			dataType:'json',
			success:function(data){
				var aid = data.aid;
				var approved_at = data.approved_at;
				var payment_method_type = data.payment_method_type;
				var item_name = data.item_name;
				var quantity = data.quantity;
				var total = data.amount.total;
				
				$('#payment #aid').html(aid);
				$('#payment #approved_at').html(approved_at);
				$('#payment #payment_method_type').html(payment_method_type);
				$('#payment #item_name').html(item_name);
				$('#payment #quantity').html(quantity);
				$('#payment #total').html(total);
				
	
			}
		});
	
</script>
</body>

</html>