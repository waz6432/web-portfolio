package com.ja.travel.dto;

public class PlanDto {

	private int plan_id, user_id, referenced_plan_id;
	private String plan_title, plan_content, plan_thumbnail, plan_disclosure_status, plan_statuse;

	public PlanDto() {
		super();
	}

	public PlanDto(int plan_id, int user_id, int referenced_plan_id, String plan_title, String plan_content,
			String plan_thumbnail, String plan_disclosure_status, String plan_statuse) {
		super();
		this.plan_id = plan_id;
		this.user_id = user_id;
		this.referenced_plan_id = referenced_plan_id;
		this.plan_title = plan_title;
		this.plan_content = plan_content;
		this.plan_thumbnail = plan_thumbnail;
		this.plan_disclosure_status = plan_disclosure_status;
		this.plan_statuse = plan_statuse;
	}

	public int getPlan_id() {
		return plan_id;
	}

	public void setPlan_id(int plan_id) {
		this.plan_id = plan_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getPlan_title() {
		return plan_title;
	}

	public void setPlan_title(String plan_title) {
		this.plan_title = plan_title;
	}

	public int getReferenced_plan_id() {
		return referenced_plan_id;
	}

	public void setReferenced_plan_id(int referenced_plan_id) {
		this.referenced_plan_id = referenced_plan_id;
	}

	public String getPlan_content() {
		return plan_content;
	}

	public void setPlan_content(String plan_content) {
		this.plan_content = plan_content;
	}

	public String getPlan_thumbnail() {
		return plan_thumbnail;
	}

	public void setPlan_thumbnail(String plan_thumbnail) {
		this.plan_thumbnail = plan_thumbnail;
	}

	public String getPlan_disclosure_status() {
		return plan_disclosure_status;
	}

	public void setPlan_disclosure_status(String plan_disclosure_status) {
		this.plan_disclosure_status = plan_disclosure_status;
	}

	public String getPlan_statuse() {
		return plan_statuse;
	}

	public void setPlan_statuse(String plan_statuse) {
		this.plan_statuse = plan_statuse;
	}

	@Override
	public String toString() {
		return "PlanDto [plan_id=" + plan_id + ", user_id=" + user_id + ", plan_title=" + plan_title
				+ ", referenced_plan_id=" + referenced_plan_id + ", plan_content=" + plan_content + ", plan_thumbnail="
				+ plan_thumbnail + ", plan_disclosure_status=" + plan_disclosure_status + ", plan_statuse="
				+ plan_statuse + "]";
	}

}