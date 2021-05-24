package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.InterestDto;

public interface InterestDao {
	public void addInterest(InterestDto interestDto) throws SQLException;
	public List<InterestDto> listInterest(String userid) throws SQLException;
	public InterestDto getInterest(String userid) throws SQLException;
	public void deleteInterest(InterestDto interestDto) throws SQLException;
	public List<InterestDto> listTopFiveInterest() throws SQLException;
}
