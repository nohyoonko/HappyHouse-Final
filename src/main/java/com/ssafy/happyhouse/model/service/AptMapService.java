package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.AptDealDto;
import com.ssafy.happyhouse.model.AptInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;

public interface AptMapService {

	List<SidoGugunCodeDto> getSido() throws Exception;

	List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception;

	List<AptInfoDto> getDongInGugun(String gugun) throws Exception;

	List<AptInfoDto> getAptInDong(String dong) throws Exception;

	List<AptDealDto> getAptDealInfo(String aptName) throws Exception;

}
