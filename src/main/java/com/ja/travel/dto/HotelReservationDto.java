package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HotelReservationDto {

	private int hotel_reservation_id;
	private int hotel_id;
	private int user_id;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date hotel_reservation_check_in;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date hotel_reservation_check_out;
	private Date hotel_reservation_reg_date;

	public HotelReservationDto() {
		super();
	}

	public HotelReservationDto(int hotel_reservation_id, int hotel_id, int user_id, Date hotel_reservation_check_in,
			Date hotel_reservation_check_out, Date hotel_reservation_reg_date) {
		super();
		this.hotel_reservation_id = hotel_reservation_id;
		this.hotel_id = hotel_id;
		this.user_id = user_id;
		this.hotel_reservation_check_in = hotel_reservation_check_in;
		this.hotel_reservation_check_out = hotel_reservation_check_out;
		this.hotel_reservation_reg_date = hotel_reservation_reg_date;
	}

	public int getHotel_reservation_id() {
		return hotel_reservation_id;
	}

	public void setHotel_reservation_id(int hotel_reservation_id) {
		this.hotel_reservation_id = hotel_reservation_id;
	}

	public int getHotel_id() {
		return hotel_id;
	}

	public void setHotel_id(int hotel_id) {
		this.hotel_id = hotel_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public Date getHotel_reservation_check_in() {
		return hotel_reservation_check_in;
	}

	public void setHotel_reservation_check_in(Date hotel_reservation_check_in) {
		this.hotel_reservation_check_in = hotel_reservation_check_in;
	}

	public Date getHotel_reservation_check_out() {
		return hotel_reservation_check_out;
	}

	public void setHotel_reservation_check_out(Date hotel_reservation_check_out) {
		this.hotel_reservation_check_out = hotel_reservation_check_out;
	}

	public Date getHotel_reservation_reg_date() {
		return hotel_reservation_reg_date;
	}

	public void setHotel_reservation_reg_date(Date hotel_reservation_reg_date) {
		this.hotel_reservation_reg_date = hotel_reservation_reg_date;
	}

	@Override
	public String toString() {
		return "HotelReservationDto [hotel_reservation_id=" + hotel_reservation_id + ", hotel_id=" + hotel_id
				+ ", user_id=" + user_id + ", hotel_reservation_check_in=" + hotel_reservation_check_in
				+ ", hotel_reservation_check_out=" + hotel_reservation_check_out + ", hotel_reservation_reg_date="
				+ hotel_reservation_reg_date + "]";
	}

}
