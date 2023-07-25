package com.ja.travel.dto;

public class HotelFacilityLineDto {

	private int hotel_facility_line_id;
	private int hotel_id;
	private int hotel_facility_id;

	public HotelFacilityLineDto() {
		super();
	}

	
	public HotelFacilityLineDto(int hotel_facility_line_id, int hotel_id, int hotel_facility_id) {
		super();
		this.hotel_facility_line_id = hotel_facility_line_id;
		this.hotel_id = hotel_id;
		this.hotel_facility_id = hotel_facility_id;
	}

	public int getHotel_facility_line_id() {
		return hotel_facility_line_id;
	}

	public void setHotel_facility_line_id(int hotel_facility_line_id) {
		this.hotel_facility_line_id = hotel_facility_line_id;
	}

	public int getHotel_id() {
		return hotel_id;
	}

	public void setHotel_id(int hotel_id) {
		this.hotel_id = hotel_id;
	}

	public int getHotel_facility_id() {
		return hotel_facility_id;
	}

	public void setHotel_facility_id(int hotel_facility_id) {
		this.hotel_facility_id = hotel_facility_id;
	}

	@Override
	public String toString() {
		return "HotelFacilityLineDto [hotel_facility_line_id=" + hotel_facility_line_id + ", hotel_id=" + hotel_id
				+ ", hotel_facility_id=" + hotel_facility_id + "]";
	}

}
