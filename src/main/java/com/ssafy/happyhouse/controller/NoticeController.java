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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.service.NoticeService;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/notice")
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
	
	@Autowired
	private NoticeService noticeService;

	@GetMapping("/")
	private void notice(HttpServletResponse response) throws IOException {
		response.sendRedirect("/notice/list?key=&word=");
	}

	@GetMapping("/get")
	private ResponseEntity<NoticeDto> getArticle(HttpSession session, int articleno) {
		try {
			NoticeDto noitce = noticeService.getArticle(articleno);
			noticeService.upPageView(noitce.getArticleno());
			return new ResponseEntity<NoticeDto>(noitce, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<NoticeDto>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/write")
	private ModelAndView writeArticle(NoticeDto noticeDto, HttpServletResponse response, HttpSession session) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userinfo");
		if (memberDto != null) {
			try {
				noticeDto.setUserid(memberDto.getUserid());
				noticeService.writeArticle(noticeDto);
				notice(response);
				return null;
			} catch (Exception e) {
				e.printStackTrace();
				ModelAndView mav = new ModelAndView();
				mav.addObject("msg", "글작성중 문제가 발생했습니다.");
				return mav;
			}
		} else {
			ModelAndView mav = new ModelAndView("error/error");
			mav.addObject("msg", "로그인 후 사용 가능한 페이지입니다.");
			return mav;
		}
	}

	@GetMapping("/list")
	private ModelAndView listArticle(@RequestParam Map<String, String> map) {
		try {
			ModelAndView mav = new ModelAndView("notice/notice");
			List<NoticeDto> list = noticeService.listArticle(map);
			mav.addObject("articles", list);
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
			ModelAndView mav = new ModelAndView("error/error");
			mav.addObject("msg", "공지사항 목록을 얻어오는 중 문제가 발생했습니다.");
			return mav;
		}
	}

	@GetMapping("/delete/{articleno}")
	private ModelAndView deleteArticle(@PathVariable("articleno") int articleno, HttpServletResponse response) {
		try {
			noticeService.deleteArticle(articleno);
			logger.debug("삭제 성공!");
			notice(response);
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			ModelAndView mav = new ModelAndView("error/error");
			mav.addObject("msg", "삭제 중 문제가 발생했습니다.");
			return mav;
		}
	}

	@PostMapping("/modify")
	private void modifyArticle(@RequestParam Map<String, String> map, HttpServletResponse response) throws IOException {
		NoticeDto noticeDto = new NoticeDto();
		noticeDto.setArticleno(Integer.parseInt(map.get("articleno")));
		noticeDto.setSubject(map.get("subject"));
		noticeDto.setContent(map.get("content"));
		logger.debug("수정할 글 번호: {}", noticeDto.getArticleno());
		try {
			noticeService.modifyArticle(noticeDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		notice(response);
	}
}
