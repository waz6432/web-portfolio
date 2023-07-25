package com.ja.travel.dto;

public class PlanRouteCityDto {
	
	private int plan_route_city_id, plan_place_id, plan_day_city_id;

	public PlanRouteCityDto() {
		super();
	}

	public PlanRouteCityDto(int plan_route_city_id, int plan_place_id, int plan_day_city_id) {
		super();
		this.plan_route_city_id = plan_route_city_id;
		this.plan_place_id = plan_place_id;
		this.plan_day_city_id = plan_day_city_id;
	}

	public int getPlan_route_city_id() {
		return plan_route_city_id;
	}

	public void setPlan_route_city_id(int plan_route_city_id) {
		this.plan_route_city_id = plan_route_city_id;
	}

	public int getPlan_place_id() {
		return plan_place_id;
	}

	public void setPlan_place_id(int plan_place_id) {
		this.plan_place_id = plan_place_id;
	}

	public int getPlan_day_city_id() {
		return plan_day_city_id;
	}

	public void setPlan_day_city_id(int plan_day_city_id) {
		this.plan_day_city_id = plan_day_city_id;
	}

	@Override
	public String toString() {
		return "PlanRouteCityDto [plan_route_city_id=" + plan_route_city_id + ", plan_place_id=" + plan_place_id
				+ ", plan_day_city_id=" + plan_day_city_id + "]";
	}
	
	
}
