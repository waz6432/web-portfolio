package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class GuideApplyDto {

	private int guide_apply_id;
	private int user_id;
	private String guide_apply_name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date guide_apply_date;
	private String guide_apply_profile;
	private String guide_apply_state;
	private String guide_apply_message;
	public GuideApplyDto() {
		super();
	}
	public GuideApplyDto(int guide_apply_id, int user_id, String guide_apply_name, Date guide_apply_date,
			String guide_apply_profile, String guide_apply_state, String guide_apply_message) {
		super();
		this.guide_apply_id = guide_apply_id;
		this.user_id = user_id;
		this.guide_apply_name = guide_apply_name;
		this.guide_apply_date = guide_apply_date;
		this.guide_apply_profile = guide_apply_profile;
		this.guide_apply_state = guide_apply_state;
		this.guide_apply_message = guide_apply_message;
	}
	public int getGuide_apply_id() {
		return guide_apply_id;
	}
	public void setGuide_apply_id(int guide_apply_id) {
		this.guide_apply_id = guide_apply_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getGuide_apply_name() {
		return guide_apply_name;
	}
	public void setGuide_apply_name(String guide_apply_name) {
		this.guide_apply_name = guide_apply_name;
	}
	public Date getGuide_apply_date() {
		return guide_apply_date;
	}
	public void setGuide_apply_date(Date guide_apply_date) {
		this.guide_apply_date = guide_apply_date;
	}
	public String getGuide_apply_profile() {
		return guide_apply_profile;
	}
	public void setGuide_apply_profile(String guide_apply_profile) {
		this.guide_apply_profile = guide_apply_profile;
	}
	public String getGuide_apply_state() {
		return guide_apply_state;
	}
	public void setGuide_apply_state(String guide_apply_state) {
		this.guide_apply_state = guide_apply_state;
	}
	public String getGuide_apply_message() {
		return guide_apply_message;
	}
	public void setGuide_apply_message(String guide_apply_message) {
		this.guide_apply_message = guide_apply_message;
	}
	@Override
	public String toString() {
		return "GuideApplyDto [guide_apply_id=" + guide_apply_id + ", user_id=" + user_id + ", guide_apply_name="
				+ guide_apply_name + ", guide_apply_date=" + guide_apply_date + ", guide_apply_profile="
				+ guide_apply_profile + ", guide_apply_state=" + guide_apply_state + ", guide_apply_message="
				+ guide_apply_message + "]";
	}
	
	
}
