package com.ja.travel.dto;

public class PlanBigCityDto {

	private int big_city_id;
	private String big_city_name;
	
	public PlanBigCityDto() {
		super();
	}

	public PlanBigCityDto(int big_city_id, String big_city_name) {
		super();
		this.big_city_id = big_city_id;
		this.big_city_name = big_city_name;
	}

	public int getBig_city_id() {
		return big_city_id;
	}

	public void setBig_city_id(int big_city_id) {
		this.big_city_id = big_city_id;
	}

	public String getBig_city_name() {
		return big_city_name;
	}

	public void setBig_city_name(String big_city_name) {
		this.big_city_name = big_city_name;
	}

	@Override
	public String toString() {
		return "PlanBigCityDto [big_city_id=" + big_city_id + ", big_city_name=" + big_city_name + "]";
	}
	
}
