package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class PlanPlaceDto {

	private int plan_place_id;
	private int plan_city_id;
	private int user_id;
	private String plan_place_photo;
	private String plan_place_name;
	private String plan_place_content;
	private String plan_place_address;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date plan_place_reg_date;

	public PlanPlaceDto() {
		super();
	}

	public PlanPlaceDto(int plan_place_id, int plan_city_id, int user_id, String plan_place_photo,
			String plan_place_name, String plan_place_content, String plan_place_address, Date plan_place_reg_date) {
		super();
		this.plan_place_id = plan_place_id;
		this.plan_city_id = plan_city_id;
		this.user_id = user_id;
		this.plan_place_photo = plan_place_photo;
		this.plan_place_name = plan_place_name;
		this.plan_place_content = plan_place_content;
		this.plan_place_address = plan_place_address;
		this.plan_place_reg_date = plan_place_reg_date;
	}

	public int getPlan_place_id() {
		return plan_place_id;
	}

	public void setPlan_place_id(int plan_place_id) {
		this.plan_place_id = plan_place_id;
	}

	public int getPlan_city_id() {
		return plan_city_id;
	}

	public void setPlan_city_id(int plan_city_id) {
		this.plan_city_id = plan_city_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getPlan_place_photo() {
		return plan_place_photo;
	}

	public void setPlan_place_photo(String plan_place_photo) {
		this.plan_place_photo = plan_place_photo;
	}

	public String getPlan_place_name() {
		return plan_place_name;
	}

	public void setPlan_place_name(String plan_place_name) {
		this.plan_place_name = plan_place_name;
	}

	public String getPlan_place_content() {
		return plan_place_content;
	}

	public void setPlan_place_content(String plan_place_content) {
		this.plan_place_content = plan_place_content;
	}

	public String getPlan_place_address() {
		return plan_place_address;
	}

	public void setPlan_place_address(String plan_place_address) {
		this.plan_place_address = plan_place_address;
	}

	public Date getPlan_place_reg_date() {
		return plan_place_reg_date;
	}

	public void setPlan_place_reg_date(Date plan_place_reg_date) {
		this.plan_place_reg_date = plan_place_reg_date;
	}

	@Override
	public String toString() {
		return "PlanPlaceDto [plan_place_id=" + plan_place_id + ", plan_city_id=" + plan_city_id + ", user_id="
				+ user_id + ", plan_place_photo=" + plan_place_photo + ", plan_place_name=" + plan_place_name
				+ ", plan_place_content=" + plan_place_content + ", plan_place_address=" + plan_place_address
				+ ", plan_place_reg_date=" + plan_place_reg_date + "]";
	}

}
