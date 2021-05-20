package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.InterestDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.InterestService;

@RestController
@RequestMapping("/interest")
public class InterestRestController {

	@Autowired
	InterestService interestService;
	
	@GetMapping("/mvadd")
	ModelAndView mvadd() {
		ModelAndView mav = new ModelAndView("interest/addInterest");
		return mav;
	}
	
	@GetMapping("/mvlist")
	ModelAndView mvlist(HttpSession session) {
		ModelAndView mav = new ModelAndView("interest/showInterest");
		MemberDto user = (MemberDto) session.getAttribute("userinfo");
		String userid = user.getUserid();
		try {
			List<InterestDto> list = interestService.listInterest(userid);
			session.setAttribute("interestList", list);
			return mav;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("error/error");
	}
	
	@GetMapping("/add/{adress}")
	public ResponseEntity<?> insertInterest(@PathVariable String adress,HttpSession session  ) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userinfo");
		String userid = memberDto.getUserid();
		InterestDto interestDto = new InterestDto();
		interestDto.setUserid(userid);
		interestDto.setAddress(adress);
		try {
			interestService.addInterest(interestDto);
			return new ResponseEntity(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/delete")
	ModelAndView deleteInterest(String adress,HttpSession session) {
		MemberDto user = (MemberDto) session.getAttribute("userinfo");
		String userid = user.getUserid();
		
		InterestDto interestDto = new InterestDto();
		interestDto.setAddress(adress);
		interestDto.setUserid(userid);
		
		try {
			interestService.deleteInterest(interestDto);
			return mvlist(session);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("error/error");
	}

}
