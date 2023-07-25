package com.ja.travel.dto;

public class TravelApplicationRequestDto {
	private String searchWord;
	private String searchType;
	private int pageNum;
	private String startDate;
	private String endDate;
	private String planningMember;

	public TravelApplicationRequestDto() {
		super();
	}

	public TravelApplicationRequestDto(String searchWord, String searchType, int pageNum, String startDate,
			String endDate, String planningMember) {
		super();
		this.searchWord = searchWord;
		this.searchType = searchType;
		this.pageNum = pageNum;
		this.startDate = startDate;
		this.endDate = endDate;
		this.planningMember = planningMember;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getPlanningMember() {
		return planningMember;
	}

	public void setPlanningMember(String planningMember) {
		this.planningMember = planningMember;
	}

	@Override
	public String toString() {
		return "TravelApplicationRequestDto [searchWord=" + searchWord + ", searchType=" + searchType + ", pageNum="
				+ pageNum + ", startDate=" + startDate + ", endDate=" + endDate + ", planningMember=" + planningMember
				+ "]";
	}
}
