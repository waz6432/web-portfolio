package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class CrewMemberDto {
	private int crew_member_id;
	private int user_id;
	private String  crew_domain;
	private int crew_member_grade_default_id;
	private String crew_join_request_intro;
	private Date crew_member_request_date;
	private String crew_join_status;
	private Date crew_member_log_date;
	
	public CrewMemberDto(int crew_member_id, int user_id, String crew_domain, int crew_member_grade_default_id,
			String crew_join_request_intro, Date crew_member_request_date, String crew_join_status,
			Date crew_member_log_date) {
		super();
		this.crew_member_id = crew_member_id;
		this.user_id = user_id;
		this.crew_domain = crew_domain;
		this.crew_member_grade_default_id = crew_member_grade_default_id;
		this.crew_join_request_intro = crew_join_request_intro;
		this.crew_member_request_date = crew_member_request_date;
		this.crew_join_status = crew_join_status;
		this.crew_member_log_date = crew_member_log_date;
	}
	public CrewMemberDto() {
		super();
	}
	public int getCrew_member_id() {
		return crew_member_id;
	}
	public void setCrew_member_id(int crew_member_id) {
		this.crew_member_id = crew_member_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getCrew_domain() {
		return crew_domain;
	}
	public void setCrew_domain(String crew_domain) {
		this.crew_domain = crew_domain;
	}
	public int getCrew_member_grade_default_id() {
		return crew_member_grade_default_id;
	}
	public void setCrew_member_grade_default_id(int crew_member_grade_default_id) {
		this.crew_member_grade_default_id = crew_member_grade_default_id;
	}
	public String getCrew_join_request_intro() {
		return crew_join_request_intro;
	}
	public void setCrew_join_request_intro(String crew_join_request_intro) {
		this.crew_join_request_intro = crew_join_request_intro;
	}

	public Date getCrew_member_request_date() {
		return crew_member_request_date;
	}
	public void setCrew_member_request_date(Date crew_member_request_date) {
		this.crew_member_request_date = crew_member_request_date;
	}
	public String getCrew_join_status() {
		return crew_join_status;
	}
	public void setCrew_join_status(String crew_join_status) {
		this.crew_join_status = crew_join_status;
	}
	public Date getCrew_member_log_date() {
		return crew_member_log_date;
	}
	public void setCrew_member_log_date(Date crew_member_log_date) {
		this.crew_member_log_date = crew_member_log_date;
	}
	@Override
	public String toString() {
		return "CrewMemberDto [crew_member_id=" + crew_member_id + ", user_id=" + user_id + ", crew_domain="
				+ crew_domain + ", crew_member_grade_default_id=" + crew_member_grade_default_id
				+ ", crew_join_request_intro=" + crew_join_request_intro + ", crew_member_request_date="
				+ crew_member_request_date + ", crew_join_status=" + crew_join_status + ", crew_member_log_date="
				+ crew_member_log_date + "]";
	}
	
	
}
