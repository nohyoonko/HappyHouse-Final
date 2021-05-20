package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ssafy.happyhouse.model.InterestDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.InterestService;


@Controller
@RequestMapping("/interest")
public class InterestController_Spring {
	
	@Autowired
	InterestService interestService;

	@GetMapping("/mvadd")
	String mvadd() {
		return "interest/addInterest";
	}
	
	@GetMapping("/mvlist")
	String mvlist(HttpSession session) {
		MemberDto user = (MemberDto) session.getAttribute("userinfo");
		String userid = user.getUserid();
		try {
			List<InterestDto> list = interestService.listInterest(userid);
			session.setAttribute("interestList", list);
			return "interest/showInterest";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/";
	}
	
	@GetMapping("/delete")
	String deleteInterest(String adress,HttpSession session) {
		MemberDto user = (MemberDto) session.getAttribute("userinfo");
		String userid = user.getUserid();
		
		InterestDto interestDto = new InterestDto();
		interestDto.setAddress(adress);
		interestDto.setUserid(userid);
		
		try {
			interestService.deleteInterest(interestDto);
			return mvlist(session);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "/";
		
	}
	
}
