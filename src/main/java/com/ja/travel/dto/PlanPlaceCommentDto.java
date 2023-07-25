package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class PlanPlaceCommentDto {

	private int plan_place_comment_id;
	private int plan_place_id;
	private int user_id;
	private String plan_place_user_comment;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date plan_place_reg_date;

	public PlanPlaceCommentDto() {
		super();
	}

	public PlanPlaceCommentDto(int plan_place_comment_id, int plan_place_id, int user_id, String plan_place_user_comment,
			Date plan_place_reg_date) {
		super();
		this.plan_place_comment_id = plan_place_comment_id;
		this.plan_place_id = plan_place_id;
		this.user_id = user_id;
		this.plan_place_user_comment = plan_place_user_comment;
		this.plan_place_reg_date = plan_place_reg_date;
	}

	public int getPlan_place_comment_id() {
		return plan_place_comment_id;
	}

	public void setPlan_place_comment_id(int plan_place_comment_id) {
		this.plan_place_comment_id = plan_place_comment_id;
	}

	public int getPlan_place_id() {
		return plan_place_id;
	}

	public void setPlan_place_id(int plan_place_id) {
		this.plan_place_id = plan_place_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getPlan_place_user_comment() {
		return plan_place_user_comment;
	}

	public void setPlan_place_user_comment(String plan_place_user_comment) {
		this.plan_place_user_comment = plan_place_user_comment;
	}

	public Date getPlan_place_reg_date() {
		return plan_place_reg_date;
	}

	public void setPlan_place_reg_date(Date plan_place_reg_date) {
		this.plan_place_reg_date = plan_place_reg_date;
	}

	@Override
	public String toString() {
		return "PlanPlaceComment [plan_place_comment_id=" + plan_place_comment_id + ", plan_place_id=" + plan_place_id
				+ ", user_id=" + user_id + ", plan_place_user_comment=" + plan_place_user_comment
				+ ", plan_place_reg_date=" + plan_place_reg_date + "]";
	}

}
