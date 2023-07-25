package com.ja.travel.dto;

import java.sql.Date;

public class PlanningChatDto {
	private int planning_chat_id;
	private int planning_parent_comment_id;
	private int user_id;;
	private int planning_id;
	private String chat_message;
	private Date reg_date;

	public PlanningChatDto() {
		super();
	}

	public PlanningChatDto(int planning_chat_id, int planning_parent_comment_id, int user_id, int planning_id,
			String chat_message, Date reg_date) {
		super();
		this.planning_chat_id = planning_chat_id;
		this.planning_parent_comment_id = planning_parent_comment_id;
		this.user_id = user_id;
		this.planning_id = planning_id;
		this.chat_message = chat_message;
		this.reg_date = reg_date;
	}

	public int getPlanning_chat_id() {
		return planning_chat_id;
	}

	public void setPlanning_chat_id(int planning_chat_id) {
		this.planning_chat_id = planning_chat_id;
	}

	public int getPlanning_parent_comment_id() {
		return planning_parent_comment_id;
	}

	public void setPlanning_parent_comment_id(int planning_parent_comment_id) {
		this.planning_parent_comment_id = planning_parent_comment_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getPlanning_id() {
		return planning_id;
	}

	public void setPlanning_id(int planning_id) {
		this.planning_id = planning_id;
	}

	public String getChat_message() {
		return chat_message;
	}

	public void setChat_message(String chat_message) {
		this.chat_message = chat_message;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "PlanningChatDto [planning_chat_id=" + planning_chat_id + ", planning_parent_comment_id="
				+ planning_parent_comment_id + ", user_id=" + user_id + ", planning_id=" + planning_id
				+ ", chat_message=" + chat_message + ", reg_date=" + reg_date + "]";
	}

}
