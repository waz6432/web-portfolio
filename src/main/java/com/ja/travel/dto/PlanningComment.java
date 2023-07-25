package com.ja.travel.dto;

import java.util.Date;

public class PlanningComment {
	private int planning_comment_id;
	private int planning_id;
	private int user_id;
	private String user_comment;
	private Date reg_date;

	public PlanningComment() {
		super();
	}

	public PlanningComment(int planning_comment_id, int planning_id, int user_id, String user_comment, Date reg_date) {
		this.planning_comment_id = planning_comment_id;
		this.planning_id = planning_id;
		this.user_id = user_id;
		this.user_comment = user_comment;
		this.reg_date = reg_date;
	}

	public int getPlanning_comment_id() {
		return planning_comment_id;
	}

	public void setPlanning_comment_id(int planning_comment_id) {
		this.planning_comment_id = planning_comment_id;
	}

	public int getPlanning_id() {
		return planning_id;
	}

	public void setPlanning_id(int planning_id) {
		this.planning_id = planning_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getUser_comment() {
		return user_comment;
	}

	public void setUser_comment(String user_comment) {
		this.user_comment = user_comment;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "PlanningComment{" + "planning_comment_id=" + planning_comment_id + ", planning_id=" + planning_id
				+ ", user_id=" + user_id + ", user_comment='" + user_comment + '\'' + ", reg_date=" + reg_date + '}';
	}
}