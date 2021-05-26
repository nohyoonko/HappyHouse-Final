package com.ssafy.happyhouse.model.dao;

import com.ssafy.happyhouse.model.CommentDto;

public interface CommentDao {
	public int insertComment(CommentDto comment);
	public CommentDto getComment(int articleno);
	public int updateComment(CommentDto comment);
	public int deleteComment(int commentno);
}
