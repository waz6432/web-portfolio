package com.ja.travel.dto;

import java.util.Date;

public class UserReportDto {

	private int user_report_id;
	private int admin_id;
	private int user_id;
	private int reported_user_id;
	private String user_report_status;
	private Date user_report_reg_date;
	private String user_report_desc;
	private Date user_report_resolved_date;
	private String user_report_attached;
	public UserReportDto() {
		super();
	}
	public UserReportDto(int user_report_id, int admin_id, int user_id, int reported_user_id, String user_report_status,
			Date user_report_reg_date, String user_report_desc, Date user_report_resolved_date,
			String user_report_attached) {
		super();
		this.user_report_id = user_report_id;
		this.admin_id = admin_id;
		this.user_id = user_id;
		this.reported_user_id = reported_user_id;
		this.user_report_status = user_report_status;
		this.user_report_reg_date = user_report_reg_date;
		this.user_report_desc = user_report_desc;
		this.user_report_resolved_date = user_report_resolved_date;
		this.user_report_attached = user_report_attached;
	}
	public int getUser_report_id() {
		return user_report_id;
	}
	public void setUser_report_id(int user_report_id) {
		this.user_report_id = user_report_id;
	}
	public int getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getReported_user_id() {
		return reported_user_id;
	}
	public void setReported_user_id(int reported_user_id) {
		this.reported_user_id = reported_user_id;
	}
	public String getUser_report_status() {
		return user_report_status;
	}
	public void setUser_report_status(String user_report_status) {
		this.user_report_status = user_report_status;
	}
	public Date getUser_report_reg_date() {
		return user_report_reg_date;
	}
	public void setUser_report_reg_date(Date user_report_reg_date) {
		this.user_report_reg_date = user_report_reg_date;
	}
	public String getUser_report_desc() {
		return user_report_desc;
	}
	public void setUser_report_desc(String user_report_desc) {
		this.user_report_desc = user_report_desc;
	}
	public Date getUser_report_resolved_date() {
		return user_report_resolved_date;
	}
	public void setUser_report_resolved_date(Date user_report_resolved_date) {
		this.user_report_resolved_date = user_report_resolved_date;
	}
	public String getUser_report_attached() {
		return user_report_attached;
	}
	public void setUser_report_attached(String user_report_attached) {
		this.user_report_attached = user_report_attached;
	}
	@Override
	public String toString() {
		return "UserReportDto [user_report_id=" + user_report_id + ", admin_id=" + admin_id + ", user_id=" + user_id
				+ ", reported_user_id=" + reported_user_id + ", user_report_status=" + user_report_status
				+ ", user_report_reg_date=" + user_report_reg_date + ", user_report_desc=" + user_report_desc
				+ ", user_report_resolved_date=" + user_report_resolved_date + ", user_report_attached="
				+ user_report_attached + "]";
	}
	
	
}