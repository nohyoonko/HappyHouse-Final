package com.ssafy.happyhouse.controller;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
    
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/findPwd")
	private String findPwd() {
		return "user/findPwd";
	}
	
	@GetMapping("/profile")
	private String profile() {
		return "user/profile";
	}

	@PostMapping("/login")
	private String login(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		try {
			MemberDto memberDto = memberService.login(map);
			if(memberDto != null) {
				session.setAttribute("userinfo", memberDto);
			} else {
				model.addAttribute("msg", "아이디 또는 비밀번호 확인 후 로그인해 주세요.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "로그인 중 문제가 발생했습니다.");
			return "error/error";
		}
		return "index";
	}
	
	@PostMapping("/findPwd")
	private String findPwd(@RequestParam Map<String, String> map, Model model) {
		try {
			String userpwd = memberService.getPassWord(map);
			if(userpwd != null) {
				model.addAttribute("find", "비밀번호는 " + userpwd + " 입니다.");
			} else {
				model.addAttribute("find", "비밀번호를 찾을 수 없습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("find", "비밀번호를 찾는 중 문제가 생겼습니다.");
			return "error/error";
		}
		return "index";
	}

	@PostMapping("/delete/{userid}")
	private String delete(@PathVariable("userid") String userid) {
		memberService.deleteMember(userid);
		return "redirect:/member/logout";
	}

	@PostMapping("/modify")
	private String modify(MemberDto memberDto, Model model, HttpSession session) {
		try {
			memberService.modifyMember(memberDto);
			MemberDto updateMem = memberService.getMember(memberDto.getUserid());
			if(updateMem != null) {
//				session 설정
				session.setAttribute("userinfo", updateMem);
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "수정 중 문제가 발생했습니다.");
			return "error/error";
		}
		return "user/profile";
	}

	@PostMapping("/join")
	private String join(MemberDto memberDto, Model model, RedirectAttributes rttr) {
		String msg = null;
		try {
			int success = memberService.join(memberDto);
			// 회원가입 성공(아이디 중복 X)
			if (success != 0)
				msg = "회원가입 성공!";
			else
				msg = "회원가입 실패!";
		} catch(SQLIntegrityConstraintViolationException e) {
			e.printStackTrace();
			model.addAttribute("msg", "아이디 중복으로 회원가입 실패했습니다.");
			return "error/error";
		} catch (SQLException e) {
			e.printStackTrace();
			model.addAttribute("msg", "회원가입 중 문제가 발생했습니다.");
			return "error/error";
		}
		
		rttr.addFlashAttribute("msg", msg);
		return "redirect:/";
	}

	@GetMapping("/logout")
	private String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

}
