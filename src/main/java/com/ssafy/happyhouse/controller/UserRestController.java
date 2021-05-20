package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.User;
import com.ssafy.happyhouse.model.service.JwtService;
import com.ssafy.happyhouse.model.service.UserService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api")
@Slf4j
public class UserRestController {
	
	private static final Logger log = LoggerFactory.getLogger(UserRestController.class);

	@Autowired
	private JwtService jwtService;
	
	@Autowired
	private UserService userService;
	
	
	@PostMapping("/user/login")
	public ResponseEntity<Map<String,Object>> signin(@RequestBody User user, HttpServletResponse res){
		Map<String,Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		try {
			User loginUser = userService.singin(user.getUserid(), user.getUserpwd());
			String token = jwtService.create(loginUser);
			res.setHeader("jwt-auth-token", token);
//			resultMap.put("auth_token", token);
			System.out.println(token);
			
			resultMap.put("status", true);
			resultMap.put("data", loginUser);
			status = HttpStatus.ACCEPTED;
		}catch(RuntimeException e) {
			log.error("로그인실패",e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String,Object>>(resultMap, status);
	}
	@PostMapping("/info")
	public ResponseEntity<Map<String,Object>> getInfo(HttpServletRequest req, @RequestBody User user){
		Map<String,Object> resultMap = new HashMap<>();
		HttpStatus status = null;
		try {
			String info = userService.getServerInfo();
			resultMap.putAll(jwtService.get(req.getHeader("jwt-auth-token")));
			
			resultMap.put("status", true);
			resultMap.put("info", info);
			resultMap.put("request_body", user);
			status = HttpStatus.ACCEPTED;
		}catch(RuntimeException e) {
			log.error("정보조회 실패");
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String,Object>>(resultMap, status);
	}
}
