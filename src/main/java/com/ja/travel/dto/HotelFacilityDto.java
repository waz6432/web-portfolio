package com.ja.travel.dto;

public class HotelFacilityDto {

	private int hotel_facility_id;
	private String hotel_facility_name;
	private String hotel_facility_image;

	public HotelFacilityDto() {
		super();
	}

	public HotelFacilityDto(int hotel_facility_id, String hotel_facility_name, String hotel_facility_image) {
		super();
		this.hotel_facility_id = hotel_facility_id;
		this.hotel_facility_name = hotel_facility_name;
		this.hotel_facility_image = hotel_facility_image;
	}

	public int getHotel_facility_id() {
		return hotel_facility_id;
	}

	public void setHotel_facility_id(int hotel_facility_id) {
		this.hotel_facility_id = hotel_facility_id;
	}

	public String getHotel_facility_name() {
		return hotel_facility_name;
	}

	public void setHotel_facility_name(String hotel_facility_name) {
		this.hotel_facility_name = hotel_facility_name;
	}

	public String getHotel_facility_image() {
		return hotel_facility_image;
	}

	public void setHotel_facility_image(String hotel_facility_image) {
		this.hotel_facility_image = hotel_facility_image;
	}

	@Override
	public String toString() {
		return "HotelFacilityDto [hotel_facility_id=" + hotel_facility_id + ", hotel_facility_name="
				+ hotel_facility_name + ", hotel_facility_image=" + hotel_facility_image + "]";
	}

}
