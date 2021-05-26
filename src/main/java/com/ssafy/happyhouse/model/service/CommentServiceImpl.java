package com.ssafy.happyhouse.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.CommentDto;
import com.ssafy.happyhouse.model.dao.CommentDao;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public boolean writeComment(CommentDto comment) {
		return sqlSession.getMapper(CommentDao.class).insertComment(comment) == 1;
	}

	@Override
	public CommentDto getComment(int articleno) {
		return sqlSession.getMapper(CommentDao.class).getComment(articleno);
	}

	@Override
	public boolean updateComment(CommentDto comment) {
		return sqlSession.getMapper(CommentDao.class).updateComment(comment) == 1;
	}

	@Override
	public boolean deleteComment(int commentno) {
		return sqlSession.getMapper(CommentDao.class).deleteComment(commentno) == 1;
	}

}
