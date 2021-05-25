package com.ssafy.happyhouse.controller;

import java.util.List;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.Board;
import com.ssafy.happyhouse.model.InterestDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.InterestService;

//http://localhost:9999/vue/swagger-ui.html
@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/api/interest")
public class InterestRestController {

	private static final Logger logger = LoggerFactory.getLogger(InterestRestController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
	
	@Autowired
	InterestService interestService;
	
//	@GetMapping("/mvadd")
//	ModelAndView mvadd() {
//		ModelAndView mav = new ModelAndView("interest/addInterest");
//		return mav;
//	}
//	
//	@GetMapping
//	ModelAndView mvlist(HttpSession session) {
//		ModelAndView mav = new ModelAndView("interest/showInterest");
//		MemberDto user = (MemberDto) session.getAttribute("userinfo");
//		String userid = user.getUserid();
//		try {
//			List<InterestDto> list = interestService.listInterest(userid);
//			session.setAttribute("interestList", list);
//			return mav;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return new ModelAndView("error/error");
//	}
	@GetMapping("/{userid}")
	public ResponseEntity<List<InterestDto>> getlist(@PathVariable String userid) throws Exception {
		logger.debug("getlist - 호출");
		List<InterestDto> list;
		try {
			list = interestService.listInterest(userid);
			return new ResponseEntity<List<InterestDto>>(list, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping
	public ResponseEntity<?> insertInterest(@RequestBody InterestDto interestDto,HttpSession session  ) {
		logger.debug("InsertInterest - 호출");
		try {
			interestService.addInterest(interestDto);
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
	@DeleteMapping("/{userid}/{address}")
	public ResponseEntity<String> deleteInterest(@PathVariable String userid,@PathVariable String address) {
		logger.debug("deletInterest - 호출");
		InterestDto interestDto = new InterestDto();
		interestDto.setUserid(userid);
		interestDto.setAddress(address);
		try {
			interestService.deleteInterest(interestDto);
			return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<String>(FAIL, HttpStatus.NO_CONTENT);
	}
	
	@GetMapping
	public ResponseEntity<List<InterestDto>> listTopFiveInterest() throws Exception {
		logger.debug("getlist - 호출");
		List<InterestDto> list;
		try {
			list = interestService.listTopFiveInterest();
			for(int i = 0; i < list.size(); i++)
				System.out.println(list.get(i));
			return new ResponseEntity<List<InterestDto>>(list, HttpStatus.OK);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
