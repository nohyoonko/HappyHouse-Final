package com.ssafy.happyhouse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/apt")
public class AptController_Spring {

	@GetMapping("/apt")
	String apt() {
		return "apt/apt";
	}
	
	@GetMapping("/mvapt")
	String mvapt(@RequestParam("dong") String dong, Model model) {
		System.out.println("선택한 동: "+ dong);
		model.addAttribute("selectDong", dong);
		return "apt/apt";
	}
}
