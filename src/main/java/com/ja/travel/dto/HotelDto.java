package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class HotelDto {

	private int hotel_id;
	private int user_id;
	private String hotel_category;
	private String hotel_title;
	private String hotel_main_image;
	private String hotel_content;
	private String hotel_address;
	private int hotel_price;
	private int hotel_bedRoom;
	private int hotel_bed;
	private int hotel_bathRoom;
	private int hotel_limit_number;
	private int hotel_check_in_time;
	private int hotel_check_out_time;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date hotel_reserve_start_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date hotel_reserve_end_date;
	private Date hotel_reg_date;
	
	public HotelDto() {
		super();
	}

	public HotelDto(int hotel_id, int user_id, String hotel_category, String hotel_title, String hotel_main_image,
			String hotel_content, String hotel_address, int hotel_price, int hotel_bedRoom, int hotel_bed,
			int hotel_bathRoom, int hotel_limit_number, int hotel_check_in_time, int hotel_check_out_time,
			Date hotel_reserve_start_date, Date hotel_reserve_end_date, Date hotel_reg_date) {
		super();
		this.hotel_id = hotel_id;
		this.user_id = user_id;
		this.hotel_category = hotel_category;
		this.hotel_title = hotel_title;
		this.hotel_main_image = hotel_main_image;
		this.hotel_content = hotel_content;
		this.hotel_address = hotel_address;
		this.hotel_price = hotel_price;
		this.hotel_bedRoom = hotel_bedRoom;
		this.hotel_bed = hotel_bed;
		this.hotel_bathRoom = hotel_bathRoom;
		this.hotel_limit_number = hotel_limit_number;
		this.hotel_check_in_time = hotel_check_in_time;
		this.hotel_check_out_time = hotel_check_out_time;
		this.hotel_reserve_start_date = hotel_reserve_start_date;
		this.hotel_reserve_end_date = hotel_reserve_end_date;
		this.hotel_reg_date = hotel_reg_date;
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

	public String getHotel_category() {
		return hotel_category;
	}

	public void setHotel_category(String hotel_category) {
		this.hotel_category = hotel_category;
	}

	public String getHotel_title() {
		return hotel_title;
	}

	public void setHotel_title(String hotel_title) {
		this.hotel_title = hotel_title;
	}

	public String getHotel_main_image() {
		return hotel_main_image;
	}

	public void setHotel_main_image(String hotel_main_image) {
		this.hotel_main_image = hotel_main_image;
	}

	public String getHotel_content() {
		return hotel_content;
	}

	public void setHotel_content(String hotel_content) {
		this.hotel_content = hotel_content;
	}

	public String getHotel_address() {
		return hotel_address;
	}

	public void setHotel_address(String hotel_address) {
		this.hotel_address = hotel_address;
	}

	public int getHotel_price() {
		return hotel_price;
	}

	public void setHotel_price(int hotel_price) {
		this.hotel_price = hotel_price;
	}

	public int getHotel_bedRoom() {
		return hotel_bedRoom;
	}

	public void setHotel_bedRoom(int hotel_bedRoom) {
		this.hotel_bedRoom = hotel_bedRoom;
	}

	public int getHotel_bed() {
		return hotel_bed;
	}

	public void setHotel_bed(int hotel_bed) {
		this.hotel_bed = hotel_bed;
	}

	public int getHotel_bathRoom() {
		return hotel_bathRoom;
	}

	public void setHotel_bathRoom(int hotel_bathRoom) {
		this.hotel_bathRoom = hotel_bathRoom;
	}

	public int getHotel_limit_number() {
		return hotel_limit_number;
	}

	public void setHotel_limit_number(int hotel_limit_number) {
		this.hotel_limit_number = hotel_limit_number;
	}

	public int getHotel_check_in_time() {
		return hotel_check_in_time;
	}

	public void setHotel_check_in_time(int hotel_check_in_time) {
		this.hotel_check_in_time = hotel_check_in_time;
	}

	public int getHotel_check_out_time() {
		return hotel_check_out_time;
	}

	public void setHotel_check_out_time(int hotel_check_out_time) {
		this.hotel_check_out_time = hotel_check_out_time;
	}

	public Date getHotel_reserve_start_date() {
		return hotel_reserve_start_date;
	}

	public void setHotel_reserve_start_date(Date hotel_reserve_start_date) {
		this.hotel_reserve_start_date = hotel_reserve_start_date;
	}

	public Date getHotel_reserve_end_date() {
		return hotel_reserve_end_date;
	}

	public void setHotel_reserve_end_date(Date hotel_reserve_end_date) {
		this.hotel_reserve_end_date = hotel_reserve_end_date;
	}

	public Date getHotel_reg_date() {
		return hotel_reg_date;
	}

	public void setHotel_reg_date(Date hotel_reg_date) {
		this.hotel_reg_date = hotel_reg_date;
	}

	@Override
	public String toString() {
		return "HotelDto [hotel_id=" + hotel_id + ", user_id=" + user_id + ", hotel_category=" + hotel_category
				+ ", hotel_title=" + hotel_title + ", hotel_main_image=" + hotel_main_image + ", hotel_content="
				+ hotel_content + ", hotel_address=" + hotel_address + ", hotel_price=" + hotel_price
				+ ", hotel_bedRoom=" + hotel_bedRoom + ", hotel_bed=" + hotel_bed + ", hotel_bathRoom=" + hotel_bathRoom
				+ ", hotel_limit_number=" + hotel_limit_number + ", hotel_check_in_time=" + hotel_check_in_time
				+ ", hotel_check_out_time=" + hotel_check_out_time + ", hotel_reserve_start_date="
				+ hotel_reserve_start_date + ", hotel_reserve_end_date=" + hotel_reserve_end_date + ", hotel_reg_date="
				+ hotel_reg_date + "]";
	}

}
