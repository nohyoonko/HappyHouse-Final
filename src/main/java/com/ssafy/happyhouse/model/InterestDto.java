package com.ssafy.happyhouse.model;

public class InterestDto {
	private String userid;
	private String address;
	private int count;
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "userid: " + userid+ ", address: " + address + ", count: " + count;
	}
	
	
}
