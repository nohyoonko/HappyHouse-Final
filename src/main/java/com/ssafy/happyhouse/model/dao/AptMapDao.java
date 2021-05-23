package com.ssafy.happyhouse.model.dao;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.AptDealDto;
import com.ssafy.happyhouse.model.AptInfoDto;
import com.ssafy.happyhouse.model.HousePageBean;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;

public interface AptMapDao {

	List<SidoGugunCodeDto> getSido() throws Exception;

	List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception;

	List<AptInfoDto> getDongInGugun(String gugun) throws Exception;

	List<AptInfoDto> getAptInDong(Map<String, String> map) throws Exception;

	List<AptDealDto> getAptDealInfo(HousePageBean hpb) throws Exception;

}
