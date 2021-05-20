package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.dao.MemberDao;

@Service
public class MemberServiceImpl implements MemberService {

	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public MemberDto login(Map<String, String> map) throws SQLException {
		return sqlSession.getMapper(MemberDao.class).login(map);
	}

	@Override
	public int join(MemberDto memberDto) throws SQLException {
		return sqlSession.getMapper(MemberDao.class).join(memberDto);
	}
	
	@Override
	public String getPassWord(Map<String, String> map) {
		return sqlSession.getMapper(MemberDao.class).getPassWord(map);
	}
	
	@Override
	public MemberDto getMember(String userid) {
		return sqlSession.getMapper(MemberDao.class).getMember(userid);
	}

	@Override
	public void modifyMember(MemberDto memberDto) {
		sqlSession.getMapper(MemberDao.class).modifyMember(memberDto);
	}

	@Override
	public void deleteMember(String userid) {
		sqlSession.getMapper(MemberDao.class).deleteMember(userid);
	}

}
