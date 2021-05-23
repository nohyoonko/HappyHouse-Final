package com.ssafy.happyhouse.model;

import java.util.Arrays;

public class HousePageBean {

	private String city;
	private String dong;
	private String dong_code;
	private String aptname;
	private String dealtype;
	private boolean[] searchType;
	private String pagelink;
	private int pageNo;
	private int interval;
	private int sort;
	private int max;
	private int min;

	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getDong_code() {
		return dong_code;
	}
	public void setDong_code(String dong_code) {
		this.dong_code = dong_code;
	}
	public String getAptName() {
		return aptname;
	}
	public void setAptName(String aptname) {
		this.aptname = aptname;
	}
	public String getDealtype() {
		return dealtype;
	}
	public void setDealtype(String dealtype) {
		this.dealtype = dealtype;
	}
	public boolean[] getSearchType() {
		return searchType;
	}
	public void setSearchType(boolean[] searchType) {
		this.searchType = searchType;
	}
	public String getPagelink() {
		return pagelink;
	}
	public void setPagelink(String pagelink) {
		this.pagelink = pagelink;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getInterval() {
		return interval;
	}
	public void setInterval(int interval) {
		this.interval = interval;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public int getMax() {
		return max;
	}
	public void setMax(int max) {
		this.max = max;
	}
	public int getMin() {
		return min;
	}
	public void setMin(int min) {
		this.min = min;
	}
	
	@Override
	public String toString() {
		return "HousePageBean [city=" + city + ", dong=" + dong + ", dongcode=" + dong_code + ", aptname=" + aptname
				+ ", dealtype=" + dealtype + ", searchType=" + Arrays.toString(searchType) + ", pagelink=" + pagelink
				+ ", pageNo=" + pageNo + ", interval=" + interval + ", sort=" + sort + ", max=" + max + ", min=" + min +"]";
	}
	
}
