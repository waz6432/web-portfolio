package com.ja.travel.dto;

import java.util.Date;

public class PlanPlaceLoveDto {

	private int plan_place_LOVE_id;
	private int plan_place_id;
	private int user_id;
	private Date plan_place_LOVE_reg_date;

	public PlanPlaceLoveDto() {
		super();
	}

	public PlanPlaceLoveDto(int plan_place_LOVE_id, int plan_place_id, int user_id, Date plan_place_LOVE_reg_date) {
		super();
		this.plan_place_LOVE_id = plan_place_LOVE_id;
		this.plan_place_id = plan_place_id;
		this.user_id = user_id;
		this.plan_place_LOVE_reg_date = plan_place_LOVE_reg_date;
	}

	public int getPlan_place_LOVE_id() {
		return plan_place_LOVE_id;
	}

	public void setPlan_place_LOVE_id(int plan_place_LOVE_id) {
		this.plan_place_LOVE_id = plan_place_LOVE_id;
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

	public Date getPlan_place_LOVE_reg_date() {
		return plan_place_LOVE_reg_date;
	}

	public void setPlan_place_LOVE_reg_date(Date plan_place_LOVE_reg_date) {
		this.plan_place_LOVE_reg_date = plan_place_LOVE_reg_date;
	}

	@Override
	public String toString() {
		return "PlanPlaceLoveDto [plan_place_LOVE_id=" + plan_place_LOVE_id + ", plan_place_id=" + plan_place_id
				+ ", user_id=" + user_id + ", plan_place_LOVE_reg_date=" + plan_place_LOVE_reg_date + "]";
	}

}
