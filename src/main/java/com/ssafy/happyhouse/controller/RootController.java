package com.ssafy.happyhouse.controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RootController implements ErrorController {

	@Override
	public String getErrorPath() {
		return "/error";
	}
	
	@GetMapping("/error")
	public String redirectRoot() {
		return "index.html";
	}

}
