package com.ja.travel.dto;

import java.util.Date;

public class CrewBoardLikeDto {
	private int crew_board_like_id;
	private int crew_board_id;
	private int crew_member_id;
	private Date crew_board_like_date;
	public CrewBoardLikeDto(int crew_board_like_id, int crew_board_id, int crew_member_id, Date crew_board_like_date) {
		super();
		this.crew_board_like_id = crew_board_like_id;
		this.crew_board_id = crew_board_id;
		this.crew_member_id = crew_member_id;
		this.crew_board_like_date = crew_board_like_date;
	}
	public CrewBoardLikeDto() {
		super();
	}
	public int getCrew_board_like_id() {
		return crew_board_like_id;
	}
	public void setCrew_board_like_id(int crew_board_like_id) {
		this.crew_board_like_id = crew_board_like_id;
	}
	public int getCrew_board_id() {
		return crew_board_id;
	}
	public void setCrew_board_id(int crew_board_id) {
		this.crew_board_id = crew_board_id;
	}
	public int getCrew_member_id() {
		return crew_member_id;
	}
	public void setCrew_member_id(int crew_member_id) {
		this.crew_member_id = crew_member_id;
	}
	public Date getCrew_board_like_date() {
		return crew_board_like_date;
	}
	public void setCrew_board_like_date(Date crew_board_like_date) {
		this.crew_board_like_date = crew_board_like_date;
	}
	@Override
	public String toString() {
		return "CrewBoardLikeDto [crew_board_like_id=" + crew_board_like_id + ", crew_board_id=" + crew_board_id
				+ ", crew_member_id=" + crew_member_id + ", crew_board_like_date=" + crew_board_like_date + "]";
	}
	
	
}
