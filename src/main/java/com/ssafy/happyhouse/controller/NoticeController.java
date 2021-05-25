package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.AptInfoDto;
import com.ssafy.happyhouse.model.Board;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.service.NoticeService;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/api/notice")
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
	
	@Autowired
	private NoticeService noticeService;

	@GetMapping("/get/{articleno}")
	private ResponseEntity<NoticeDto> getArticle(@PathVariable String articleno,HttpSession session) {
		logger.debug("getarticle - 호출");
		try {
			NoticeDto noitce = noticeService.getArticle(Integer.parseInt(articleno));
			noticeService.upPageView(noitce.getArticleno());
			return new ResponseEntity<NoticeDto>(noitce, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<NoticeDto>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping
	public ResponseEntity<String>  writeArticle(@RequestBody NoticeDto noticeDto) {
		logger.debug("writeNotice - 호출");
		System.out.println("controller: "+ noticeDto.getSubject());
		try {
			noticeService.writeArticle(noticeDto);
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}


	@GetMapping("/get")
	private ResponseEntity<List<NoticeDto>> listArticle(@RequestParam Map<String, String> map) {
		logger.debug("getNoticelist - 호출");
		try {
			List<NoticeDto> list = noticeService.listArticle(map);
			return new ResponseEntity<List<NoticeDto>>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@DeleteMapping("/{articleno}")
	private ResponseEntity<String> deleteArticle(@PathVariable("articleno") int articleno, HttpServletResponse response) {
		try {
			noticeService.deleteArticle(articleno);
			logger.debug("삭제 성공!");
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
		
	}
	
	@PutMapping("/{articleno}")
	public ResponseEntity<String> updateNotice(@RequestBody NoticeDto noticeDto) {
		logger.debug("updateNotice - 호출");
		logger.debug("" + noticeDto);
		
		try {
			noticeService.modifyArticle(noticeDto);
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
}
