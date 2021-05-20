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

import com.ssafy.happyhouse.model.AptDealDto;
import com.ssafy.happyhouse.model.AptInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.AptMapService;

@RestController
@RequestMapping("/api/aptrest")
public class AptRestController {

	@Autowired
	AptMapService aptMapService;
	
	@GetMapping("/sido")
	public ResponseEntity<List<SidoGugunCodeDto>> getSido() {
		List<SidoGugunCodeDto> list;
		try {
			list = aptMapService.getSido();
			return new ResponseEntity<List<SidoGugunCodeDto>>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/gugun/{sido}")
	public ResponseEntity<List<SidoGugunCodeDto>> getGugun(@PathVariable String sido) {
		List<SidoGugunCodeDto> list;
		try {
			list = aptMapService.getGugunInSido(sido);
			return new ResponseEntity<List<SidoGugunCodeDto>>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/dong/{gugun}")
	public ResponseEntity<List<AptInfoDto>> getDong(@PathVariable  String gugun) {
		System.out.println(gugun);
		List<AptInfoDto> list;
		try {
			list = aptMapService.getDongInGugun(gugun);
			System.out.println(list.toString());
			return new ResponseEntity<List<AptInfoDto>>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	@GetMapping("/apt/{dong}")
	public ResponseEntity<List<AptInfoDto>> getAptInDong(@PathVariable String dong, HttpSession session) {
		List<AptInfoDto> list;
		try {
			list = aptMapService.getAptInDong(dong);
			session.setAttribute("selectDong", dong);
			return new ResponseEntity<List<AptInfoDto>>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/dealInfo/{content}")
	public ResponseEntity<List<AptDealDto>> getDealInfo(@PathVariable String content) {
		System.out.println(content);
		List<AptDealDto> list;
		try {
			list = aptMapService.getAptDealInfo(content);
			System.out.println("매매 이름 : "+list.get(0).getAptName());
			return new ResponseEntity<List<AptDealDto>>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
