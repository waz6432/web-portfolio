package com.ja.travel.dto;

import java.util.Date;

public class HotelReviewDto {

	private int hotel_review_id;
	private int hotel_reservation_id;
	private double hotel_review_point;
	private String hotel_review_content;
	private Date hotel_review_reg_date;

	public HotelReviewDto() {
		super();
	}

	public HotelReviewDto(int hotel_review_id, int hotel_reservation_id, double hotel_review_point,
			String hotel_review_content, Date hotel_review_reg_date) {
		super();
		this.hotel_review_id = hotel_review_id;
		this.hotel_reservation_id = hotel_reservation_id;
		this.hotel_review_point = hotel_review_point;
		this.hotel_review_content = hotel_review_content;
		this.hotel_review_reg_date = hotel_review_reg_date;
	}

	public int getHotel_review_id() {
		return hotel_review_id;
	}

	public void setHotel_review_id(int hotel_review_id) {
		this.hotel_review_id = hotel_review_id;
	}

	public int getHotel_reservation_id() {
		return hotel_reservation_id;
	}

	public void setHotel_reservation_id(int hotel_reservation_id) {
		this.hotel_reservation_id = hotel_reservation_id;
	}

	public double getHotel_review_point() {
		return hotel_review_point;
	}

	public void setHotel_review_point(double hotel_review_point) {
		this.hotel_review_point = hotel_review_point;
	}

	public String getHotel_review_content() {
		return hotel_review_content;
	}

	public void setHotel_review_content(String hotel_review_content) {
		this.hotel_review_content = hotel_review_content;
	}

	public Date getHotel_review_reg_date() {
		return hotel_review_reg_date;
	}

	public void setHotel_review_reg_date(Date hotel_review_reg_date) {
		this.hotel_review_reg_date = hotel_review_reg_date;
	}

	@Override
	public String toString() {
		return "HotelReviewDto [hotel_review_id=" + hotel_review_id + ", hotel_reservation_id=" + hotel_reservation_id
				+ ", hotel_review_point=" + hotel_review_point + ", hotel_review_content=" + hotel_review_content
				+ ", hotel_review_reg_date=" + hotel_review_reg_date + "]";
	}

}
