package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.AptDealDto;
import com.ssafy.happyhouse.model.AptInfoDto;
import com.ssafy.happyhouse.model.HousePageBean;
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
	
	
	@GetMapping("/aptlist")
	public ResponseEntity<List<AptInfoDto>> getAptInDong(@RequestParam Map<String, String> map, HttpSession session) {
		List<AptInfoDto> list;
		try {
			list = aptMapService.getAptInDong(map);
			session.setAttribute("selectDong", map.get("dong"));
			return new ResponseEntity<List<AptInfoDto>>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/dealInfo")
	public ResponseEntity<List<AptDealDto>> getDealInfo(@RequestParam Map<String, String> map) {
		HousePageBean hpb = new HousePageBean();
		hpb.setAptName(map.get("AptName"));
		hpb.setDong_code(map.get("code"));
		hpb.setDong(map.get("dong"));
		hpb.setMin(Integer.parseInt(map.get("min")));
		hpb.setMax(Integer.parseInt(map.get("max")));
		hpb.setSort(Integer.parseInt(map.get("sort")));
		System.out.println(hpb);
		List<AptDealDto> list;
		try {
			list = aptMapService.getAptDealInfo(hpb);
			return new ResponseEntity<List<AptDealDto>>(list, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
