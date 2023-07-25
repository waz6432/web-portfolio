package com.ja.travel.dto;

import java.util.Date;

public class CrewBoardCommentDto {
	private int board_comment_id;
	private int crew_board_id;
	private int crew_member_id;
	private String crew_comment;
	private Date crew_comment_date;
	private Date crew_comment_deleted_date;
	private String crew_comment_updated;
	public CrewBoardCommentDto(int board_comment_id, int crew_board_id, int crew_member_id, String crew_comment,
			Date crew_comment_date, Date crew_comment_deleted_date, String crew_comment_updated) {
		super();
		this.board_comment_id = board_comment_id;
		this.crew_board_id = crew_board_id;
		this.crew_member_id = crew_member_id;
		this.crew_comment = crew_comment;
		this.crew_comment_date = crew_comment_date;
		this.crew_comment_deleted_date = crew_comment_deleted_date;
		this.crew_comment_updated = crew_comment_updated;
	}
	public CrewBoardCommentDto() {
		super();
	}
	public int getBoard_comment_id() {
		return board_comment_id;
	}
	public void setBoard_comment_id(int board_comment_id) {
		this.board_comment_id = board_comment_id;
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
	public String getCrew_comment() {
		return crew_comment;
	}
	public void setCrew_comment(String crew_comment) {
		this.crew_comment = crew_comment;
	}
	public Date getCrew_comment_date() {
		return crew_comment_date;
	}
	public void setCrew_comment_date(Date crew_comment_date) {
		this.crew_comment_date = crew_comment_date;
	}
	public Date getCrew_comment_deleted_date() {
		return crew_comment_deleted_date;
	}
	public void setCrew_comment_deleted_date(Date crew_comment_deleted_date) {
		this.crew_comment_deleted_date = crew_comment_deleted_date;
	}
	public String getCrew_comment_updated() {
		return crew_comment_updated;
	}
	public void setCrew_comment_updated(String crew_comment_updated) {
		this.crew_comment_updated = crew_comment_updated;
	}
	@Override
	public String toString() {
		return "CrewBoardCommentDto [board_comment_id=" + board_comment_id + ", crew_board_id=" + crew_board_id
				+ ", crew_member_id=" + crew_member_id + ", crew_comment=" + crew_comment + ", crew_comment_date="
				+ crew_comment_date + ", crew_comment_deleted_date=" + crew_comment_deleted_date
				+ ", crew_comment_updated=" + crew_comment_updated + "]";
	}
	
	
}
