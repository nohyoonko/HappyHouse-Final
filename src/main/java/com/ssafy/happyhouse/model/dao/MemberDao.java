package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.Map;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.User;

public interface MemberDao {
	public MemberDto login(Map<String, String> map) throws SQLException;
	public User signin(Map<String,String> map)throws SQLException;
	public int join(MemberDto memberDto);
	public MemberDto getMember(String userid);
	public String getPassWord(Map<String, String> map);
	public void modifyMember(MemberDto memberDto);
	public void deleteMember(String userid);
}
