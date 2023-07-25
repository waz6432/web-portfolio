package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class GuideReportDto {

	private int guide_report_id;
	private int user_id;
	private int guide_planning_id;
	private int admin_id;
	private String guide_report_status;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date guide_report_reg_date;
	private String guide_report_type;
	private String guide_report_desc;
	private String guide_report_attached;
	public GuideReportDto() {
		super();
	}
	public GuideReportDto(int guide_report_id, int user_id, int guide_planning_id, int admin_id,
			String guide_report_status, Date guide_report_reg_date, String guide_report_type, String guide_report_desc,
			String guide_report_attached) {
		super();
		this.guide_report_id = guide_report_id;
		this.user_id = user_id;
		this.guide_planning_id = guide_planning_id;
		this.admin_id = admin_id;
		this.guide_report_status = guide_report_status;
		this.guide_report_reg_date = guide_report_reg_date;
		this.guide_report_type = guide_report_type;
		this.guide_report_desc = guide_report_desc;
		this.guide_report_attached = guide_report_attached;
	}
	public int getGuide_report_id() {
		return guide_report_id;
	}
	public void setGuide_report_id(int guide_report_id) {
		this.guide_report_id = guide_report_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getGuide_planning_id() {
		return guide_planning_id;
	}
	public void setGuide_planning_id(int guide_planning_id) {
		this.guide_planning_id = guide_planning_id;
	}
	public int getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}
	public String getGuide_report_status() {
		return guide_report_status;
	}
	public void setGuide_report_status(String guide_report_status) {
		this.guide_report_status = guide_report_status;
	}
	public Date getGuide_report_reg_date() {
		return guide_report_reg_date;
	}
	public void setGuide_report_reg_date(Date guide_report_reg_date) {
		this.guide_report_reg_date = guide_report_reg_date;
	}
	public String getGuide_report_type() {
		return guide_report_type;
	}
	public void setGuide_report_type(String guide_report_type) {
		this.guide_report_type = guide_report_type;
	}
	public String getGuide_report_desc() {
		return guide_report_desc;
	}
	public void setGuide_report_desc(String guide_report_desc) {
		this.guide_report_desc = guide_report_desc;
	}
	public String getGuide_report_attached() {
		return guide_report_attached;
	}
	public void setGuide_report_attached(String guide_report_attached) {
		this.guide_report_attached = guide_report_attached;
	}
	@Override
	public String toString() {
		return "GuideReportDto [guide_report_id=" + guide_report_id + ", user_id=" + user_id + ", guide_planning_id="
				+ guide_planning_id + ", admin_id=" + admin_id + ", guide_report_status=" + guide_report_status
				+ ", guide_report_reg_date=" + guide_report_reg_date + ", guide_report_type=" + guide_report_type
				+ ", guide_report_desc=" + guide_report_desc + ", guide_report_attached=" + guide_report_attached + "]";
	}
	
	
}
