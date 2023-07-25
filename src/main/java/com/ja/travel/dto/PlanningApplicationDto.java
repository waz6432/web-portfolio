package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class PlanningApplicationDto {

	private int planning_application_id, user_id, planning_id;
	private String planning_application_content, planning_member_status;
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	private Date reg_date;

	public PlanningApplicationDto() {
		super();
	}

	public PlanningApplicationDto(int planning_application_id, int user_id, int planning_id,
			String planning_application_content, String planning_member_status, Date reg_date) {
		super();
		this.planning_application_id = planning_application_id;
		this.user_id = user_id;
		this.planning_id = planning_id;
		this.planning_application_content = planning_application_content;
		this.planning_member_status = planning_member_status;
		this.reg_date = reg_date;
	}

	public int getPlanning_application_id() {
		return planning_application_id;
	}

	public void setPlanning_application_id(int planning_application_id) {
		this.planning_application_id = planning_application_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getPlanning_id() {
		return planning_id;
	}

	public void setPlanning_id(int planning_id) {
		this.planning_id = planning_id;
	}

	public String getPlanning_application_content() {
		return planning_application_content;
	}

	public void setPlanning_application_content(String planning_application_content) {
		this.planning_application_content = planning_application_content;
	}

	public String getPlanning_member_status() {
		return planning_member_status;
	}

	public void setPlanning_member_status(String planning_member_status) {
		this.planning_member_status = planning_member_status;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "PlanningApplicationDto [planning_application_id=" + planning_application_id + ", user_id=" + user_id
				+ ", planning_id=" + planning_id + ", planning_application_content=" + planning_application_content
				+ ", planning_member_status=" + planning_member_status + ", reg_date=" + reg_date + "]";
	}

}
