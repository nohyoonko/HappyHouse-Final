package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.InterestDto;
import com.ssafy.happyhouse.model.dao.InterestDao;


@Service
public class InterestServiceImpl implements InterestService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void addInterest(InterestDto interestDto) throws Exception {
		sqlSession.getMapper(InterestDao.class).addInterest(interestDto);
	}

	@Override
	public List<InterestDto> listInterest(String userid) throws Exception {
		return sqlSession.getMapper(InterestDao.class).listInterest(userid);
	}

	@Override
	public InterestDto getInterest(String userid) throws Exception {
		return sqlSession.getMapper(InterestDao.class).getInterest(userid);
	}

	@Override
	public void deleteInterest(InterestDto interestDto) throws Exception {
		sqlSession.getMapper(InterestDao.class).deleteInterest(interestDto);
	}

}
