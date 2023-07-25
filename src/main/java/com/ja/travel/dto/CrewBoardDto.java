package com.ja.travel.dto;

import java.util.Date;

public class CrewBoardDto {
	private int crew_board_id;
	private int crew_member_id;
	private String crew_domain;
	private String crew_board_title;
	private String crew_board_notice;
	private String crew_board_content;
	private Date crew_board_reg_date;
	private String crew_board_status;
	private Date crew_board_update_date;
	private String crew_board_visibility;

	
	
	public CrewBoardDto(int crew_board_id, int crew_member_id, String crew_domain, String crew_board_title,
			String crew_board_notice, String crew_board_content, Date crew_board_reg_date, String crew_board_status,
			Date crew_board_update_date, String crew_board_visibility) {
		super();
		this.crew_board_id = crew_board_id;
		this.crew_member_id = crew_member_id;
		this.crew_domain = crew_domain;
		this.crew_board_title = crew_board_title;
		this.crew_board_notice = crew_board_notice;
		this.crew_board_content = crew_board_content;
		this.crew_board_reg_date = crew_board_reg_date;
		this.crew_board_status = crew_board_status;
		this.crew_board_update_date = crew_board_update_date;
		this.crew_board_visibility = crew_board_visibility;
	}
	
	public CrewBoardDto() {
		super();
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
	public String getCrew_domain() {
		return crew_domain;
	}
	public void setCrew_domain(String crew_domain) {
		this.crew_domain = crew_domain;
	}
	public String getCrew_board_title() {
		return crew_board_title;
	}
	public void setCrew_board_title(String crew_board_title) {
		this.crew_board_title = crew_board_title;
	}
	public String getCrew_board_content() {
		return crew_board_content;
	}
	public void setCrew_board_content(String crew_board_content) {
		this.crew_board_content = crew_board_content;
	}
	public Date getCrew_board_reg_date() {
		return crew_board_reg_date;
	}
	public void setCrew_board_reg_date(Date crew_board_reg_date) {
		this.crew_board_reg_date = crew_board_reg_date;
	}
	public String getCrew_board_status() {
		return crew_board_status;
	}
	public void setCrew_board_status(String crew_board_status) {
		this.crew_board_status = crew_board_status;
	}
	public Date getCrew_board_update_date() {
		return crew_board_update_date;
	}
	public void setCrew_board_update_date(Date crew_board_update_date) {
		this.crew_board_update_date = crew_board_update_date;
	}
	
	
	public String getCrew_board_notice() {
		return crew_board_notice;
	}

	public void setCrew_board_notice(String crew_board_notice) {
		this.crew_board_notice = crew_board_notice;
	}

	public String getCrew_board_visibility() {
		return crew_board_visibility;
	}

	public void setCrew_board_visibility(String crew_board_visibility) {
		this.crew_board_visibility = crew_board_visibility;
	}

	@Override
	public String toString() {
		return "CrewBoardDto [crew_board_id=" + crew_board_id + ", crew_member_id=" + crew_member_id + ", crew_domain="
				+ crew_domain + ", crew_board_title=" + crew_board_title + ", crew_board_notice=" + crew_board_notice
				+ ", crew_board_content=" + crew_board_content + ", crew_board_reg_date=" + crew_board_reg_date
				+ ", crew_board_status=" + crew_board_status + ", crew_board_update_date=" + crew_board_update_date
				+ ", crew_board_visibility=" + crew_board_visibility + "]";
	}


	


	
}
