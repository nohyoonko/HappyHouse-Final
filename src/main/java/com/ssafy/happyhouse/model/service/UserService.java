package com.ssafy.happyhouse.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.User;

@Service
public class UserService {
	
	@Autowired
	private SqlSession sqlSession;
	
	//로그인계정은 고정값을 이용
	public User singin(String email,String password) {
		if(email.equals("abc@def.net")&& password.equals("1234")) {
			return new User(email,password);
		}else {
			throw new RuntimeException("존재안함");
		}
	}
	
	//귀중한 정보 전달
	public String getServerInfo() {
		return "made by ko_cheong";
	}
}
