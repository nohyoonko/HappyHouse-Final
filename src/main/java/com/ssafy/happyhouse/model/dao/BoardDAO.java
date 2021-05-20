package com.ssafy.happyhouse.model.dao;

import java.util.List;

import com.ssafy.happyhouse.model.Board;

public interface BoardDAO {
	public List<Board> selectBoard();
	public Board selectBoardByNo(int no);
	public int insertBoard(Board board);
	public int updateBoard(Board board);
	public int deleteBoard(int no);
}