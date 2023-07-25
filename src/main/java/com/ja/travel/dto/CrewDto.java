package com.ja.travel.dto;

import java.util.Date;

public class CrewDto {
	private int crew_id;
	private int master_id;
	private String crew_name;
	private String crew_thumbnail;
	private String crew_desc;
	private int crew_point;
	private Date crew_reg_date;
	private String crew_domain;

	public CrewDto(int crew_id, int master_id, String crew_name, String crew_thumbnail, String crew_desc,
			int crew_point, Date crew_reg_date, String crew_domain) {
		super();
		this.crew_id = crew_id;
		this.master_id = master_id;
		this.crew_name = crew_name;
		this.crew_thumbnail = crew_thumbnail;
		this.crew_desc = crew_desc;
		this.crew_point = crew_point;
		this.crew_reg_date = crew_reg_date;
		this.crew_domain = crew_domain;
	}

	public CrewDto() {
		super();
	}

	public int getCrew_id() {
		return crew_id;
	}

	public void setCrew_id(int crew_id) {
		this.crew_id = crew_id;
	}

	

	public int getMaster_id() {
		return master_id;
	}

	public void setMaster_id(int master_id) {
		this.master_id = master_id;
	}

	public String getCrew_name() {
		return crew_name;
	}

	public void setCrew_name(String crew_name) {
		this.crew_name = crew_name;
	}

	public String getCrew_thumbnail() {
		return crew_thumbnail;
	}

	public void setCrew_thumbnail(String crew_thumbnail) {
		this.crew_thumbnail = crew_thumbnail;
	}

	public String getCrew_desc() {
		return crew_desc;
	}

	public void setCrew_desc(String crew_desc) {
		this.crew_desc = crew_desc;
	}

	public int getCrew_point() {
		return crew_point;
	}

	public void setCrew_point(int crew_point) {
		this.crew_point = crew_point;
	}

	public Date getCrew_reg_date() {
		return crew_reg_date;
	}

	public void setCrew_reg_date(Date crew_reg_date) {
		this.crew_reg_date = crew_reg_date;
	}

	public String getCrew_domain() {
		return crew_domain;
	}

	public void setCrew_domain(String crew_domain) {
		this.crew_domain = crew_domain;
	}


	@Override
	public String toString() {
		return "CrewDto [crew_id=" + crew_id + ", master_id=" + master_id + ", crew_name=" + crew_name
				+ ", crew_thumbnail=" + crew_thumbnail + ", crew_desc=" + crew_desc + ", crew_point=" + crew_point
				+ ", crew_reg_date=" + crew_reg_date + ", crew_domain=" + crew_domain + ", crew_member_amount="
				+ "]";
	}

	
}
