package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.User;
import com.ssafy.happyhouse.model.dao.MemberDao;

@Service
public class UserService {

	@Autowired
	private SqlSession sqlSession;

	// 로그인계정은 고정값을 이용
	public User singin(String userid, String userpwd) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("userpwd", userpwd);
		User user;
		user = sqlSession.getMapper(MemberDao.class).signin(map);
		if (user.getUserid() != null)
			return user;
		else
			throw new RuntimeException("존재안함");

	}

	// 귀중한 정보 전달
	public String getServerInfo() {
		return "made by ko_cheong";
	}
}
