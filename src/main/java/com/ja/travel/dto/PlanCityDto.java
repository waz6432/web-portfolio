package com.ja.travel.dto;

public class PlanCityDto {

	private int plan_city_id;
	private String plan_city_name;
	
	public PlanCityDto() {
		super();
	}

	public PlanCityDto(int plan_city_id, String plan_city_name) {
		super();
		this.plan_city_id = plan_city_id;
		this.plan_city_name = plan_city_name;
	}

	public int getPlan_city_id() {
		return plan_city_id;
	}

	public void setPlan_city_id(int plan_city_id) {
		this.plan_city_id = plan_city_id;
	}

	public String getPlan_city_name() {
		return plan_city_name;
	}

	public void setPlan_city_name(String plan_city_name) {
		this.plan_city_name = plan_city_name;
	}

	@Override
	public String toString() {
		return "PlanCityDto [plan_city_id=" + plan_city_id + ", plan_city_name=" + plan_city_name + "]";
	}
	
}
