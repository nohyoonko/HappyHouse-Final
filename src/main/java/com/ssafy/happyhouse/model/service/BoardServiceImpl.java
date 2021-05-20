package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.happyhouse.model.Board;
import com.ssafy.happyhouse.model.dao.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private SqlSession sqlSession;

    @Override
	public List<Board> retrieveBoard() {
		return sqlSession.getMapper(BoardDAO.class).selectBoard();
	}
    
  	@Override
	public boolean writeBoard(Board board) {
		return sqlSession.getMapper(BoardDAO.class).insertBoard(board) == 1;
	}

	@Override
	public Board detailBoard(int no) {
		return sqlSession.getMapper(BoardDAO.class).selectBoardByNo(no);
	}

	@Override
	@Transactional
	public boolean updateBoard(Board board) {
		return sqlSession.getMapper(BoardDAO.class).updateBoard(board) == 1;
	}

	@Override
	@Transactional
	public boolean deleteBoard(int no) {
		return sqlSession.getMapper(BoardDAO.class).deleteBoard(no) == 1;
	}
}