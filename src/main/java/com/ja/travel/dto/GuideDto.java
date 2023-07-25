package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class GuideDto {

	private int guide_id;
	private int user_id;
	private int admin_id;
	private Date guide_apply_date;
	private String guide_profile;
	private String guide_name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date guide_reg_date;
	public GuideDto() {
		super();
	}
	public GuideDto(int guide_id, int user_id, int admin_id, Date guide_apply_date, String guide_profile,
			String guide_name, Date guide_reg_date) {
		super();
		this.guide_id = guide_id;
		this.user_id = user_id;
		this.admin_id = admin_id;
		this.guide_apply_date = guide_apply_date;
		this.guide_profile = guide_profile;
		this.guide_name = guide_name;
		this.guide_reg_date = guide_reg_date;
	}
	public int getGuide_id() {
		return guide_id;
	}
	public void setGuide_id(int guide_id) {
		this.guide_id = guide_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}
	public Date getGuide_apply_date() {
		return guide_apply_date;
	}
	public void setGuide_apply_date(Date guide_apply_date) {
		this.guide_apply_date = guide_apply_date;
	}
	public String getGuide_profile() {
		return guide_profile;
	}
	public void setGuide_profile(String guide_profile) {
		this.guide_profile = guide_profile;
	}
	public String getGuide_name() {
		return guide_name;
	}
	public void setGuide_name(String guide_name) {
		this.guide_name = guide_name;
	}
	public Date getGuide_reg_date() {
		return guide_reg_date;
	}
	public void setGuide_reg_date(Date guide_reg_date) {
		this.guide_reg_date = guide_reg_date;
	}
	@Override
	public String toString() {
		return "GuideDto [guide_id=" + guide_id + ", user_id=" + user_id + ", admin_id=" + admin_id
				+ ", guide_apply_date=" + guide_apply_date + ", guide_profile=" + guide_profile + ", guide_name="
				+ guide_name + ", guide_reg_date=" + guide_reg_date + "]";
	}
	
	
}
