package com.ja.travel.dto;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class PlanningDto {

	private int planning_id, plan_id, user_id;
	private String planning_start_point, planning_content, planning_title, planning_member, planning_start_date, planning_end_date;

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date planning_reg_date;

	public PlanningDto() {
		super();
	}

	public PlanningDto(int planning_id, int plan_id, int user_id, String planning_start_point, String planning_content,
			String planning_title, String planning_member, String planning_start_date, String planning_end_date,
			Date planning_reg_date) {
		super();
		this.planning_id = planning_id;
		this.plan_id = plan_id;
		this.user_id = user_id;
		this.planning_start_point = planning_start_point;
		this.planning_content = planning_content;
		this.planning_title = planning_title;
		this.planning_member = planning_member;
		this.planning_start_date = planning_start_date;
		this.planning_end_date = planning_end_date;
		this.planning_reg_date = planning_reg_date;
	}

	public int getPlanning_id() {
		return planning_id;
	}

	public void setPlanning_id(int planning_id) {
		this.planning_id = planning_id;
	}

	public int getPlan_id() {
		return plan_id;
	}

	public void setPlan_id(int plan_id) {
		this.plan_id = plan_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getPlanning_member() {
		return planning_member;
	}

	public void setPlanning_member(String planning_member) {
		this.planning_member = planning_member;
	}

	public String getPlanning_start_point() {
		return planning_start_point;
	}

	public void setPlanning_start_point(String planning_start_point) {
		this.planning_start_point = planning_start_point;
	}

	public String getPlanning_content() {
		return planning_content;
	}

	public void setPlanning_content(String planning_content) {
		this.planning_content = planning_content;
	}

	public String getPlanning_title() {
		return planning_title;
	}

	public void setPlanning_title(String planning_title) {
		this.planning_title = planning_title;
	}

	public String getPlanning_start_date() {
		return planning_start_date;
	}

	public void setPlanning_start_date(String planning_start_date) {
		this.planning_start_date = planning_start_date;
	}

	public String getPlanning_end_date() {
		return planning_end_date;
	}

	public void setPlanning_end_date(String planning_end_date) {
		this.planning_end_date = planning_end_date;
	}

	public Date getPlanning_reg_date() {
		return planning_reg_date;
	}

	public void setPlanning_reg_date(Date planning_reg_date) {
		this.planning_reg_date = planning_reg_date;
	}

	@Override
	public String toString() {
		return "PlanningDto [planning_id=" + planning_id + ", plan_id=" + plan_id + ", user_id=" + user_id
				+ ", planning_member=" + planning_member + ", planning_start_point=" + planning_start_point
				+ ", planning_content=" + planning_content + ", planning_title=" + planning_title
				+ ", planning_start_date=" + planning_start_date + ", planning_end_date=" + planning_end_date
				+ ", planning_reg_date=" + planning_reg_date + "]";
	}

}
