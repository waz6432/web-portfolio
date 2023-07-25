package com.ja.travel.dto;




import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class GuidePlanningDto {

	private int guide_planning_id;
	private int plan_id;
	private int guide_id;
	
	private Date guide_planning_start_date;
	private int guide_planning_member;
	
	private String guide_planning_start_point;
	private String guide_planning_content, guide_planning_title;
	
	private Date guide_planning_end_date;
	private int guide_planning_price;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date guide_planning_reg_date; 
	public GuidePlanningDto() {
		super();
	}
	public GuidePlanningDto(int guide_planning_id, int plan_id, int guide_id, Date guide_planning_start_date,
			int guide_planning_member, String guide_planning_start_point, String guide_planning_content,
			String guide_planning_title, Date guide_planning_end_date, int guide_planning_price,
			Date guide_planning_reg_date) {
		super();
		this.guide_planning_id = guide_planning_id;
		this.plan_id = plan_id;
		this.guide_id = guide_id;
		this.guide_planning_start_date = guide_planning_start_date;
		this.guide_planning_member = guide_planning_member;
		this.guide_planning_start_point = guide_planning_start_point;
		this.guide_planning_content = guide_planning_content;
		this.guide_planning_title = guide_planning_title;
		this.guide_planning_end_date = guide_planning_end_date;
		this.guide_planning_price = guide_planning_price;
		this.guide_planning_reg_date = guide_planning_reg_date;
	}
	public int getGuide_planning_id() {
		return guide_planning_id;
	}
	public void setGuide_planning_id(int guide_planning_id) {
		this.guide_planning_id = guide_planning_id;
	}
	public int getPlan_id() {
		return plan_id;
	}
	public void setPlan_id(int plan_id) {
		this.plan_id = plan_id;
	}
	public int getGuide_id() {
		return guide_id;
	}
	public void setGuide_id(int guide_id) {
		this.guide_id = guide_id;
	}
	public Date getGuide_planning_start_date() {
		return guide_planning_start_date;
	}
	public void setGuide_planning_start_date(Date guide_planning_start_date) {
		this.guide_planning_start_date = guide_planning_start_date;
	}
	public int getGuide_planning_member() {
		return guide_planning_member;
	}
	public void setGuide_planning_member(int guide_planning_member) {
		this.guide_planning_member = guide_planning_member;
	}
	public String getGuide_planning_start_point() {
		return guide_planning_start_point;
	}
	public void setGuide_planning_start_point(String guide_planning_start_point) {
		this.guide_planning_start_point = guide_planning_start_point;
	}
	public String getGuide_planning_content() {
		return guide_planning_content;
	}
	public void setGuide_planning_content(String guide_planning_content) {
		this.guide_planning_content = guide_planning_content;
	}
	public String getguide_planning_title() {
		return guide_planning_title;
	}
	public void setguide_planning_title(String guide_planning_title) {
		this.guide_planning_title = guide_planning_title;
	}
	public Date getGuide_planning_end_date() {
		return guide_planning_end_date;
	}
	public void setGuide_planning_end_date(Date guide_planning_end_date) {
		this.guide_planning_end_date = guide_planning_end_date;
	}
	public int getGuide_planning_price() {
		return guide_planning_price;
	}
	public void setGuide_planning_price(int guide_planning_price) {
		this.guide_planning_price = guide_planning_price;
	}
	public Date getGuide_planning_reg_date() {
		return guide_planning_reg_date;
	}
	public void setGuide_planning_reg_date(Date guide_planning_reg_date) {
		this.guide_planning_reg_date = guide_planning_reg_date;
	}
	@Override
	public String toString() {
		return "GuidePlanningDto [guide_planning_id=" + guide_planning_id + ", plan_id=" + plan_id + ", guide_id="
				+ guide_id + ", guide_planning_start_date=" + guide_planning_start_date + ", guide_planning_member="
				+ guide_planning_member + ", guide_planning_start_point=" + guide_planning_start_point
				+ ", guide_planning_content=" + guide_planning_content + ", guide_planning_title=" + guide_planning_title
				+ ", guide_planning_end_date=" + guide_planning_end_date + ", guide_planning_price="
				+ guide_planning_price + ", guide_planning_reg_date=" + guide_planning_reg_date + "]";
	}
	
		
}
