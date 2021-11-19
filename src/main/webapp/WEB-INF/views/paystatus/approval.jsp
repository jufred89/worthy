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
		<h3>결제가 진행중입니다.</h3>


		
	<script>
	opener.location.href  = '/orderSuccess'; //부모창 url 변경
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
				var quantity = data.quantity;
				var total = data.amount.total;
				var item_name = data.item_name;
				$.ajax({
					type:'post',
					url:'/shop/kakaoPaySuccess',
					data:{"aid":aid,"pay_date":approved_at,"pay_type":payment_method_type,
						"quantity":quantity,"pay_price":total},
					success:function(){
						alert("결제가 완료되었습니다.")
						window.close();
					}
				});
				
				window.opener.$("#aid").html(aid);
				window.opener.$("#approved_at").html(approved_at);
				window.opener.$("#payment_method_type").html(payment_method_type);
				window.opener.$("#total").html(total);
				window.opener.$("#quantity").html(quantity);
				window.opener.$("#item_name").html(item_name);
				
				self.close();
	
			}
		});
	
</script>
</body>

</html>