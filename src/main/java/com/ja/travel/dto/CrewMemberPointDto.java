package com.ja.travel.dto;

import java.util.Date;

public class CrewMemberPointDto {
	private int crew_member_point_id;
	private int crew_member_id;
	private String crew_member_point_reason;
	private int crew_member_point_change;
	private Date crew_member_point_date;
	
	
	public CrewMemberPointDto(int crew_member_point_id, int crew_member_id, String crew_member_point_reason,
			int crew_member_point_change, Date crew_member_point_date) {
		super();
		this.crew_member_point_id = crew_member_point_id;
		this.crew_member_id = crew_member_id;
		this.crew_member_point_reason = crew_member_point_reason;
		this.crew_member_point_change = crew_member_point_change;
		this.crew_member_point_date = crew_member_point_date;
	}
	
	
	public CrewMemberPointDto() {
		super();
	}


	public int getCrew_member_point_id() {
		return crew_member_point_id;
	}
	public void setCrew_member_point_id(int crew_member_point_id) {
		this.crew_member_point_id = crew_member_point_id;
	}
	public int getCrew_member_id() {
		return crew_member_id;
	}
	public void setCrew_member_id(int crew_member_id) {
		this.crew_member_id = crew_member_id;
	}
	public String getCrew_member_point_reason() {
		return crew_member_point_reason;
	}
	public void setCrew_member_point_reason(String crew_member_point_reason) {
		this.crew_member_point_reason = crew_member_point_reason;
	}
	public int getCrew_member_point_change() {
		return crew_member_point_change;
	}
	public void setCrew_member_point_change(int crew_member_point_change) {
		this.crew_member_point_change = crew_member_point_change;
	}
	public Date getCrew_member_point_date() {
		return crew_member_point_date;
	}
	public void setCrew_member_point_date(Date crew_member_point_date) {
		this.crew_member_point_date = crew_member_point_date;
	}
	
	
}
