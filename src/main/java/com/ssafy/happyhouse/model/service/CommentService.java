package com.ssafy.happyhouse.model.service;

import com.ssafy.happyhouse.model.CommentDto;

public interface CommentService {
	public boolean writeComment(CommentDto comment);
	public CommentDto getComment(int articleno);
	public boolean updateComment(CommentDto comment);
	public boolean deleteComment(int commentno);
}
