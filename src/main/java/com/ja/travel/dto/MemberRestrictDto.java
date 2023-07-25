package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class MemberRestrictDto {

	private int user_restrict_id;
	private int user_id;
	private int admin_id;
	private int user_report_id;
	private int user_restrict_duration;
	@DateTimeFormat(pattern = "yyyy-MM-DD")
	private Date user_restrict_start_date;
	@DateTimeFormat(pattern = "yyyy-MM-DD")
	private Date user_restrict_end_date;
	private String user_restrict_reason;
	public MemberRestrictDto() {
		super();
	}
	public MemberRestrictDto(int user_restrict_id, int user_id, int admin_id, int user_report_id,
			int user_restrict_duration, Date user_restrict_start_date, Date user_restrict_end_date,
			String user_restrict_reason) {
		super();
		this.user_restrict_id = user_restrict_id;
		this.user_id = user_id;
		this.admin_id = admin_id;
		this.user_report_id = user_report_id;
		this.user_restrict_duration = user_restrict_duration;
		this.user_restrict_start_date = user_restrict_start_date;
		this.user_restrict_end_date = user_restrict_end_date;
		this.user_restrict_reason = user_restrict_reason;
	}
	public int getUser_restrict_id() {
		return user_restrict_id;
	}
	public void setUser_restrict_id(int user_restrict_id) {
		this.user_restrict_id = user_restrict_id;
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
	public int getUser_report_id() {
		return user_report_id;
	}
	public void setUser_report_id(int user_report_id) {
		this.user_report_id = user_report_id;
	}
	public int getUser_restrict_duration() {
		return user_restrict_duration;
	}
	public void setUser_restrict_duration(int user_restrict_duration) {
		this.user_restrict_duration = user_restrict_duration;
	}
	public Date getUser_restrict_start_date() {
		return user_restrict_start_date;
	}
	public void setUser_restrict_start_date(Date user_restrict_start_date) {
		this.user_restrict_start_date = user_restrict_start_date;
	}
	public Date getUser_restrict_end_date() {
		return user_restrict_end_date;
	}
	public void setUser_restrict_end_date(Date user_restrict_end_date) {
		this.user_restrict_end_date = user_restrict_end_date;
	}
	public String getUser_restrict_reason() {
		return user_restrict_reason;
	}
	public void setUser_restrict_reason(String user_restrict_reason) {
		this.user_restrict_reason = user_restrict_reason;
	}
	@Override
	public String toString() {
		return "MemberRestrictDto [user_restrict_id=" + user_restrict_id + ", user_id=" + user_id + ", admin_id="
				+ admin_id + ", user_report_id=" + user_report_id + ", user_restrict_duration=" + user_restrict_duration
				+ ", user_restrict_start_date=" + user_restrict_start_date + ", user_restrict_end_date="
				+ user_restrict_end_date + ", user_restrict_reason=" + user_restrict_reason + "]";
	}

	
}
	