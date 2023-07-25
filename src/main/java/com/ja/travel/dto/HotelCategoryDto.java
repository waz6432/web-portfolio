package com.ja.travel.dto;

import java.util.Date;

public class HotelCategoryDto {

	private int hotel_category_id;
	private String hotel_category_title;
	private Date hotel_category_reg_date;

	public HotelCategoryDto() {
		super();
	}

	public HotelCategoryDto(int hotel_category_id, String hotel_category_title, Date hotel_category_reg_date) {
		super();
		this.hotel_category_id = hotel_category_id;
		this.hotel_category_title = hotel_category_title;
		this.hotel_category_reg_date = hotel_category_reg_date;
	}

	public int getHotel_category_id() {
		return hotel_category_id;
	}

	public void setHotel_category_id(int hotel_category_id) {
		this.hotel_category_id = hotel_category_id;
	}

	public String getHotel_category_title() {
		return hotel_category_title;
	}

	public void setHotel_category_title(String hotel_category_title) {
		this.hotel_category_title = hotel_category_title;
	}

	public Date getHotel_category_reg_date() {
		return hotel_category_reg_date;
	}

	public void setHotel_category_reg_date(Date hotel_category_reg_date) {
		this.hotel_category_reg_date = hotel_category_reg_date;
	}

	@Override
	public String toString() {
		return "HotelCategoryDto [hotel_category_id=" + hotel_category_id + ", hotel_category_title="
				+ hotel_category_title + ", hotel_category_reg_date=" + hotel_category_reg_date + "]";
	}

}
