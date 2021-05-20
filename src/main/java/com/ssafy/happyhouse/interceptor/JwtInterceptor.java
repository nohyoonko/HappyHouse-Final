package com.ssafy.happyhouse.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.ssafy.happyhouse.model.service.JwtService;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class JwtInterceptor implements HandlerInterceptor {
	
	private static final Logger log = LoggerFactory.getLogger(JwtInterceptor.class);
	
	@Autowired
	private JwtService jwtService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println(request.getMethod() + ":" + request.getServletPath());
		
		if(request.getMethod().equals("OPTIONS")) {
			return true;
		}
		else {
			String token = request.getHeader("jwt-auth-token");
			if(token != null && token.length() > 0) {
				jwtService.checkValid(token);
				log.trace("토큰 사용 가능:{}", token);
				return true;
			}else {
				throw new RuntimeException("인증토큰이 없습니다.");
			}
		}
	}
	
	
}
