package com.ssafy.happyhouse.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/apt")
public class AptController_Spring {

	@GetMapping("/apt")
	public ModelAndView apt() {
		ModelAndView mav = new ModelAndView("apt/apt");
		return mav;
	}
	
	@GetMapping("/mvapt")
	public ModelAndView mvapt(@RequestParam("dong") String dong) {
		System.out.println("선택한 동: "+ dong);
		ModelAndView mav = new ModelAndView("apt/apt");
		mav.addObject("selectDong", dong);
		return mav;
	}
	
}
