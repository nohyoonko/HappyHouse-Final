package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.NoticeDto;

public interface NoticeService {
	public void writeArticle(NoticeDto noticeDto) throws Exception;
	public List<NoticeDto> listArticle(Map<String, String> map) throws Exception;
	public NoticeDto getArticle(int articleno) throws Exception;
	public void modifyArticle(NoticeDto noticeDto) throws Exception;
	public void deleteArticle(int articleno) throws Exception;
	public void upPageView(int articleno) throws Exception;
}
