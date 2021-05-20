package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.InterestDto;

public interface InterestService {
	public void addInterest(InterestDto interestDto) throws Exception;
	public List<InterestDto> listInterest(String userid) throws Exception;
	public InterestDto getInterest(String userid) throws Exception;
	public void deleteInterest(InterestDto interestDto) throws Exception;
}
