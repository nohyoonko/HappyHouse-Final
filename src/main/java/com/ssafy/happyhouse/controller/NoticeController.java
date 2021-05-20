package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@Autowired
	private NoticeService noticeService;

	@GetMapping("/")
	private String notice() {
		return "redirect:/notice/list?key=&word=";
	}

	
	@GetMapping("/get")
	private @ResponseBody NoticeDto getArticle(HttpSession session,int articleno) {
		try {
			NoticeDto noitce = noticeService.getArticle(articleno);
			noticeService.upPageView(noitce.getArticleno());
			return noitce;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@PostMapping("/write")
	private String writeArticle(NoticeDto noticeDto, Model model, HttpSession session) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userinfo");
		if (memberDto != null) {
			try {
				noticeDto.setUserid(memberDto.getUserid());
				noticeService.writeArticle(noticeDto);
				return "redirect:/notice/list?key=&word=";
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("msg", "글작성중 문제가 발생했습니다.");
				return "error/error";
			}
		} else {
			model.addAttribute("msg", "로그인 후 사용 가능한 페이지입니다.");
			return "error/error";
		}
	}

	@GetMapping("/list")
	private String listArticle(@RequestParam Map<String, String> map, Model model) {
		try {
			List<NoticeDto> list = noticeService.listArticle(map);
			model.addAttribute("articles", list);
			return "notice/notice";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "공지사항 목록을 얻어오는 중 문제가 발생했습니다.");
			return "error/error";
		}
	}

	@GetMapping("/delete/{articleno}")
	private String deleteArticle(@PathVariable("articleno") int articleno, Model model) {
		try {
			noticeService.deleteArticle(articleno);
			logger.debug("삭제 성공!");
			return "redirect:/notice/list?key=&word=";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "삭제 중 문제가 발생했습니다.");
			return "error/error";
		}

	}

	@PostMapping("/modify")
	private String modifyArticle(@RequestParam Map<String, String> map) {
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
		return "redirect:/notice/list?key=&word=";
	}
}
