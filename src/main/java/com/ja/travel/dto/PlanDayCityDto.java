package com.ja.travel.dto;

public class PlanDayCityDto {
	
	private int plan_day_city_id, plan_day_id, plan_city_id;

	public PlanDayCityDto() {
		super();
	}

	public PlanDayCityDto(int plan_day_city_id, int plan_day_id, int plan_city_id) {
		super();
		this.plan_day_city_id = plan_day_city_id;
		this.plan_day_id = plan_day_id;
		this.plan_city_id = plan_city_id;
	}

	public int getPlan_day_city_id() {
		return plan_day_city_id;
	}

	public void setPlan_day_city_id(int plan_day_city_id) {
		this.plan_day_city_id = plan_day_city_id;
	}

	public int getPlan_day_id() {
		return plan_day_id;
	}

	public void setPlan_day_id(int plan_day_id) {
		this.plan_day_id = plan_day_id;
	}

	public int getPlan_city_id() {
		return plan_city_id;
	}

	public void setPlan_city_id(int plan_city_id) {
		this.plan_city_id = plan_city_id;
	}

	@Override
	public String toString() {
		return "PlanDayCityDto [plan_day_city_id=" + plan_day_city_id + ", plan_day_id=" + plan_day_id
				+ ", plan_city_id=" + plan_city_id + "]";
	}
	
	

}
