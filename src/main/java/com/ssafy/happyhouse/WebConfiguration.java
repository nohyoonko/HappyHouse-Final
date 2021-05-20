package com.ssafy.happyhouse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.ssafy.happyhouse.interceptor.ConfirmInterceptor;


@Configuration
public class WebConfiguration extends WebMvcConfigurerAdapter{

	@Autowired
	private ConfirmInterceptor ConfirmInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(ConfirmInterceptor).addPathPatterns("/notice/**");
		registry.addInterceptor(ConfirmInterceptor).addPathPatterns("/member/profile");
	}

}
