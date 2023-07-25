package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class UserDto {
	private int user_id;
	private String user_email;
	private String user_pw;
	private String user_nickname;
	private String user_phone;
	private String user_gender;
	private String user_image;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date user_birth;
	private String user_address;
	private Date user_reg_date;

	public UserDto() {
		super();
	}

	public UserDto(int user_id, String user_email, String user_pw, String user_nickname, String user_phone,
			String user_gender, String user_image, Date user_birth, String user_address, Date user_reg_date) {
		super();
		this.user_id = user_id;
		this.user_email = user_email;
		this.user_pw = user_pw;
		this.user_nickname = user_nickname;
		this.user_phone = user_phone;
		this.user_gender = user_gender;
		this.user_image = user_image;
		this.user_birth = user_birth;
		this.user_address = user_address;
		this.user_reg_date = user_reg_date;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_pw() {
		return user_pw;
	}

	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public String getUser_gender() {
		return user_gender;
	}

	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}

	public String getUser_image() {
		return user_image;
	}

	public void setUser_image(String user_image) {
		this.user_image = user_image;
	}

	public Date getUser_birth() {
		return user_birth;
	}

	public void setUser_birth(Date user_birth) {
		this.user_birth = user_birth;
	}

	public String getUser_address() {
		return user_address;
	}

	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}

	public Date getUser_reg_date() {
		return user_reg_date;
	}

	public void setUser_reg_date(Date user_reg_date) {
		this.user_reg_date = user_reg_date;
	}

	@Override
	public String toString() {
		return "UserDto [user_id=" + user_id + ", user_email=" + user_email + ", user_pw=" + user_pw
				+ ", user_nickname=" + user_nickname + ", user_phone=" + user_phone + ", user_gender=" + user_gender
				+ ", user_image=" + user_image + ", user_birth=" + user_birth + ", user_address=" + user_address
				+ ", user_reg_date=" + user_reg_date + "]";
	}

}
