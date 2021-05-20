package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.AptDealDto;
import com.ssafy.happyhouse.model.AptInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.dao.AptMapDao;

@Service
public class AptMapServiceImpl implements AptMapService {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return sqlSession.getMapper(AptMapDao.class).getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return sqlSession.getMapper(AptMapDao.class).getGugunInSido(sido);
	}

	@Override
	public List<AptInfoDto> getDongInGugun(String gugun) throws Exception {
		return sqlSession.getMapper(AptMapDao.class).getDongInGugun(gugun);
	}

	@Override
	public List<AptInfoDto> getAptInDong(String dong) throws Exception {
		return sqlSession.getMapper(AptMapDao.class).getAptInDong(dong);
	}

	@Override
	public List<AptDealDto> getAptDealInfo(String AptName) throws Exception {
		return sqlSession.getMapper(AptMapDao.class).getAptDealInfo(AptName);
	}

}
