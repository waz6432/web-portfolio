package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class GuideRestrictDto {

	private int guide_restrict_id;
	private int guide_id;
	private int admin_id;
	private int guide_report_id;
	private int plan_id;
	private int guide_restrict_duration;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date guide_restrict_start_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date guide_restrict_end_date;
	private String guide_restrict_reason;
	public GuideRestrictDto() {
		super();
	}
	public GuideRestrictDto(int guide_restrict_id, int guide_id, int admin_id, int guide_report_id, int plan_id,
			int guide_restrict_duration, Date guide_restrict_start_date, Date guide_restrict_end_date,
			String guide_restrict_reason) {
		super();
		this.guide_restrict_id = guide_restrict_id;
		this.guide_id = guide_id;
		this.admin_id = admin_id;
		this.guide_report_id = guide_report_id;
		this.plan_id = plan_id;
		this.guide_restrict_duration = guide_restrict_duration;
		this.guide_restrict_start_date = guide_restrict_start_date;
		this.guide_restrict_end_date = guide_restrict_end_date;
		this.guide_restrict_reason = guide_restrict_reason;
	}
	public int getGuide_restrict_id() {
		return guide_restrict_id;
	}
	public void setGuide_restrict_id(int guide_restrict_id) {
		this.guide_restrict_id = guide_restrict_id;
	}
	public int getGuide_id() {
		return guide_id;
	}
	public void setGuide_id(int guide_id) {
		this.guide_id = guide_id;
	}
	public int getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}
	public int getGuide_report_id() {
		return guide_report_id;
	}
	public void setGuide_report_id(int guide_report_id) {
		this.guide_report_id = guide_report_id;
	}
	public int getPlan_id() {
		return plan_id;
	}
	public void setPlan_id(int plan_id) {
		this.plan_id = plan_id;
	}
	public int getGuide_restrict_duration() {
		return guide_restrict_duration;
	}
	public void setGuide_restrict_duration(int guide_restrict_duration) {
		this.guide_restrict_duration = guide_restrict_duration;
	}
	public Date getGuide_restrict_start_date() {
		return guide_restrict_start_date;
	}
	public void setGuide_restrict_start_date(Date guide_restrict_start_date) {
		this.guide_restrict_start_date = guide_restrict_start_date;
	}
	public Date getGuide_restrict_end_date() {
		return guide_restrict_end_date;
	}
	public void setGuide_restrict_end_date(Date guide_restrict_end_date) {
		this.guide_restrict_end_date = guide_restrict_end_date;
	}
	public String getGuide_restrict_reason() {
		return guide_restrict_reason;
	}
	public void setGuide_restrict_reason(String guide_restrict_reason) {
		this.guide_restrict_reason = guide_restrict_reason;
	}
	@Override
	public String toString() {
		return "GuideRestrictDto [guide_restrict_id=" + guide_restrict_id + ", guide_id=" + guide_id + ", admin_id="
				+ admin_id + ", guide_report_id=" + guide_report_id + ", plan_id=" + plan_id
				+ ", guide_restrict_duration=" + guide_restrict_duration + ", guide_restrict_start_date="
				+ guide_restrict_start_date + ", guide_restrict_end_date=" + guide_restrict_end_date
				+ ", guide_restrict_reason=" + guide_restrict_reason + "]";
	}
	
	
}
