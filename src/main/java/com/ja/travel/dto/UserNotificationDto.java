package com.ja.travel.dto;

import java.util.Date;

public class UserNotificationDto {
	private int user_notification_id;
	private int user_id;
	private String sender_image;
	private String user_notification_content;
	private String user_notification_link;
	private Date user_notification_date;
	private String user_notification_read;

	public UserNotificationDto(int user_notification_id, int user_id, String sender_image, String user_notification_content,
			String user_notification_link, Date user_notification_date, String user_notification_read) {
		super();
		this.user_notification_id = user_notification_id;
		this.user_id = user_id;
		this.sender_image = sender_image;
		this.user_notification_content = user_notification_content;
		this.user_notification_link = user_notification_link;
		this.user_notification_date = user_notification_date;
		this.user_notification_read = user_notification_read;
	}
	public UserNotificationDto() {
		super();
	}
	public int getUser_notification_id() {
		return user_notification_id;
	}
	public void setUser_notification_id(int user_notification_id) {
		this.user_notification_id = user_notification_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
	public String getSender_image() {
		return sender_image;
	}
	public void setSender_image(String sender_image) {
		this.sender_image = sender_image;
	}
	public String getUser_notification_content() {
		return user_notification_content;
	}
	public void setUser_notification_content(String user_notification_content) {
		this.user_notification_content = user_notification_content;
	}
	
	public String getUser_notification_link() {
		return user_notification_link;
	}
	public void setUser_notification_link(String user_notification_link) {
		this.user_notification_link = user_notification_link;
	}
	public Date getUser_notification_date() {
		return user_notification_date;
	}
	public void setUser_notification_date(Date user_notification_date) {
		this.user_notification_date = user_notification_date;
	}
	public String getUser_notification_read() {
		return user_notification_read;
	}
	public void setUser_notification_read(String user_notification_read) {
		this.user_notification_read = user_notification_read;
	}
	
	@Override
	public String toString() {
		return "UserNotificationDto [user_notification_id=" + user_notification_id + ", user_id=" + user_id
				+ ", sender_image=" + sender_image + ", user_notification_content=" + user_notification_content
				+ ", user_notification_link=" + user_notification_link + ", user_notification_date="
				+ user_notification_date + ", user_notification_read=" + user_notification_read + "]";
	}
	
}
