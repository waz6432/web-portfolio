package com.ja.travel.dto;

import java.util.Date;

public class AdminDto {
	private int admin_id;
	private String admin_userid;
	private String admin_pw;
	private String admin_nickname;
	private Date admin_reg_date;
	public AdminDto() {
		super();
	}
	public AdminDto(int admin_id, String admin_userid, String admin_pw, String admin_nickname, Date admin_reg_date) {
		super();
		this.admin_id = admin_id;
		this.admin_userid = admin_userid;
		this.admin_pw = admin_pw;
		this.admin_nickname = admin_nickname;
		this.admin_reg_date = admin_reg_date;
	}
	public int getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}
	public String getAdmin_userid() {
		return admin_userid;
	}
	public void setAdmin_userid(String admin_userid) {
		this.admin_userid = admin_userid;
	}
	public String getAdmin_pw() {
		return admin_pw;
	}
	public void setAdmin_pw(String admin_pw) {
		this.admin_pw = admin_pw;
	}
	public String getAdmin_nickname() {
		return admin_nickname;
	}
	public void setAdmin_nickname(String admin_nickname) {
		this.admin_nickname = admin_nickname;
	}
	public Date getAdmin_reg_date() {
		return admin_reg_date;
	}
	public void setAdmin_reg_date(Date admin_reg_date) {
		this.admin_reg_date = admin_reg_date;
	}
	@Override
	public String toString() {
		return "AdminDto [admin_id=" + admin_id + ", admin_userid=" + admin_userid + ", admin_pw=" + admin_pw
				+ ", admin_nickname=" + admin_nickname + ", admin_reg_date=" + admin_reg_date + "]";
	}
	
}