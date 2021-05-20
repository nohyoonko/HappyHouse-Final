package com.ssafy.happyhouse.model.service;

import java.sql.SQLException;
import java.util.Map;

import com.ssafy.happyhouse.model.MemberDto;

public interface MemberService {
	public MemberDto login(Map<String, String> map) throws SQLException;
	public int join(MemberDto memberDto) throws SQLException;
	public MemberDto getMember(String userid);
	public String getPassWord(Map<String, String> map);
	public void modifyMember(MemberDto memberDto);
	public void deleteMember(String userid);
}
