package com.ja.travel.dto;

public class HotelImageDetailsDto {

	private int hotel_image_details_id;
	private int hotel_id;
	private String hotel_image_details_link;

	public HotelImageDetailsDto() {
		super();
	}

	public HotelImageDetailsDto(int hotel_image_details_id, int hotel_id, String hotel_image_details_link) {
		super();
		this.hotel_image_details_id = hotel_image_details_id;
		this.hotel_id = hotel_id;
		this.hotel_image_details_link = hotel_image_details_link;
	}

	public int getHotel_image_details_id() {
		return hotel_image_details_id;
	}

	public void setHotel_image_details_id(int hotel_image_details_id) {
		this.hotel_image_details_id = hotel_image_details_id;
	}

	public int getHotel_id() {
		return hotel_id;
	}

	public void setHotel_id(int hotel_id) {
		this.hotel_id = hotel_id;
	}

	public String getHotel_image_details_link() {
		return hotel_image_details_link;
	}

	public void setHotel_image_details_link(String hotel_image_details_link) {
		this.hotel_image_details_link = hotel_image_details_link;
	}

	@Override
	public String toString() {
		return "HotelImageDetailsDto [hotel_image_details_id=" + hotel_image_details_id + ", hotel_id=" + hotel_id
				+ ", hotel_image_details_link=" + hotel_image_details_link + "]";
	}

}
