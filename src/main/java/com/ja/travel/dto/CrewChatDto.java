package com.ja.travel.dto;

import java.util.Date;

public class CrewChatDto {
	public int crew_chat_id;
	public int crew_member_id;
	public String crew_domain;
	public String crew_chat_text;
	public Date crew_chat_date;
	@Override
	public String toString() {
		return "CrewChatDto [crew_chat_id=" + crew_chat_id + ", crew_member_id=" + crew_member_id + ", crew_domain="
				+ crew_domain + ", crew_chat_text=" + crew_chat_text + ", crew_chat_date=" + crew_chat_date + "]";
	}
	public CrewChatDto(int crew_chat_id, int crew_member_id, String crew_domain, String crew_chat_text,
			Date crew_chat_date) {
		super();
		this.crew_chat_id = crew_chat_id;
		this.crew_member_id = crew_member_id;
		this.crew_domain = crew_domain;
		this.crew_chat_text = crew_chat_text;
		this.crew_chat_date = crew_chat_date;
	}
	public CrewChatDto() {
		super();
	}
	public int getCrew_chat_id() {
		return crew_chat_id;
	}
	public void setCrew_chat_id(int crew_chat_id) {
		this.crew_chat_id = crew_chat_id;
	}
	public int getCrew_member_id() {
		return crew_member_id;
	}
	public void setCrew_member_id(int crew_member_id) {
		this.crew_member_id = crew_member_id;
	}
	public String getCrew_domain() {
		return crew_domain;
	}
	public void setCrew_domain(String crew_domain) {
		this.crew_domain = crew_domain;
	}
	public String getCrew_chat_text() {
		return crew_chat_text;
	}
	public void setCrew_chat_text(String crew_chat_text) {
		this.crew_chat_text = crew_chat_text;
	}
	public Date getCrew_chat_date() {
		return crew_chat_date;
	}
	public void setCrew_chat_date(Date crew_chat_date) {
		this.crew_chat_date = crew_chat_date;
	}
	
}
