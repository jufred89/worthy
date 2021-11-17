package com.example.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(request.getSession().getAttribute("uid")==null){
			String path = request.getServletPath();
			String query = request.getQueryString() == null? "":"?"+request.getQueryString();
			request.getSession().setAttribute("dest", path+query);
			
			//alertâ + �α��� ������ �̵�
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('���� �α��� ���ּ���!'); "
					+ "location.href='/login'</script>");
			out.flush();

		}

		return super.preHandle(request, response, handler);
	}
	
}
