package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class MessageDto {

	private int message_id;
	private int user_id;
	private String user_nickname;
	private String message_title;
	private String message_content;
	@DateTimeFormat(pattern = "yy-MM-dd hh:mm:ss")
	private Date message_reg_date;
	@DateTimeFormat(pattern="yy-MM-dd hh:mm:ss")
	private Date message_read_date;
	private String message_status;
	public MessageDto() {
		super();
	}
	public MessageDto(int message_id, int user_id, String user_nickname, String message_title, String message_content,
			Date message_reg_date, Date message_read_date, String message_status) {
		super();
		this.message_id = message_id;
		this.user_id = user_id;
		this.user_nickname = user_nickname;
		this.message_title = message_title;
		this.message_content = message_content;
		this.message_reg_date = message_reg_date;
		this.message_read_date = message_read_date;
		this.message_status = message_status;
	}
	public int getMessage_id() {
		return message_id;
	}
	public void setMessage_id(int message_id) {
		this.message_id = message_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public String getMessage_title() {
		return message_title;
	}
	public void setMessage_title(String message_title) {
		this.message_title = message_title;
	}
	public String getMessage_content() {
		return message_content;
	}
	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}
	public Date getMessage_reg_date() {
		return message_reg_date;
	}
	public void setMessage_reg_date(Date message_reg_date) {
		this.message_reg_date = message_reg_date;
	}
	public Date getMessage_read_date() {
		return message_read_date;
	}
	public void setMessage_read_date(Date message_read_date) {
		this.message_read_date = message_read_date;
	}
	public String getMessage_status() {
		return message_status;
	}
	public void setMessage_status(String message_status) {
		this.message_status = message_status;
	}
	@Override
	public String toString() {
		return "MessageDto [message_id=" + message_id + ", user_id=" + user_id + ", user_nickname=" + user_nickname
				+ ", message_title=" + message_title + ", message_content=" + message_content + ", message_reg_date="
				+ message_reg_date + ", message_read_date=" + message_read_date + ", message_status=" + message_status
				+ "]";
	}
	
	
}