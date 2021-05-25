package com.ssafy.happyhouse.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.dao.NoticeDao;

@Service
public class NoticeServiceImpl implements NoticeService {

	private static final Logger logger = LoggerFactory.getLogger(NoticeServiceImpl.class);
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void writeArticle(NoticeDto noticeDto) throws Exception {
		System.out.println(noticeDto);
		if (noticeDto.getSubject() == null || noticeDto.getContent() == null) {
			throw new Exception();
		}
		sqlSession.getMapper(NoticeDao.class).writeArticle(noticeDto);
	}

	@Override
	public List<NoticeDto> listArticle(Map<String, String> map) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("key", map.get("key") == null ? "" : map.get("key"));
		param.put("word", map.get("word") == null ? "" : map.get("word"));
		return sqlSession.getMapper(NoticeDao.class).listArticle(param);
	}

	@Override
	public NoticeDto getArticle(int articleno) throws Exception {
		return sqlSession.getMapper(NoticeDao.class).getArticle(articleno);
	}

	@Override
	public void modifyArticle(NoticeDto noticeDto) throws Exception {
		sqlSession.getMapper(NoticeDao.class).modifyArticle(noticeDto);
	}

	@Override
	public void deleteArticle(int articleno) throws Exception {
		sqlSession.getMapper(NoticeDao.class).deleteArticle(articleno);
	}

	@Override
	public void upPageView(int articleno) throws Exception {
		sqlSession.getMapper(NoticeDao.class).upPageView(articleno);

	}

}
