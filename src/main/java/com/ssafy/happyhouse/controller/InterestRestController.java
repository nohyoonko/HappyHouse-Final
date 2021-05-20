package com.ssafy.happyhouse.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.InterestDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.InterestService;

@RestController
@RequestMapping("/interest/rest")
public class InterestRestController {

	@Autowired
	InterestService interestService;
	

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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	

}
