package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class CouponDto {

	private int coupon_id;
	private String coupon_title;
	private String coupon_content;
	private String coupon_image;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date coupon_issue_start;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date coupon_issue_end;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date coupon_use_end;
	private int coupon_discount;
	private int coupon_amount;
	private String coupon_status;
	public CouponDto() {
		super();
	}
	public CouponDto(int coupon_id, String coupon_title, String coupon_content, String coupon_image,
			Date coupon_issue_start, Date coupon_issue_end, Date coupon_use_end, int coupon_discount, int coupon_amount,
			String coupon_status) {
		super();
		this.coupon_id = coupon_id;
		this.coupon_title = coupon_title;
		this.coupon_content = coupon_content;
		this.coupon_image = coupon_image;
		this.coupon_issue_start = coupon_issue_start;
		this.coupon_issue_end = coupon_issue_end;
		this.coupon_use_end = coupon_use_end;
		this.coupon_discount = coupon_discount;
		this.coupon_amount = coupon_amount;
		this.coupon_status = coupon_status;
	}
	public int getCoupon_id() {
		return coupon_id;
	}
	public void setCoupon_id(int coupon_id) {
		this.coupon_id = coupon_id;
	}
	public String getCoupon_title() {
		return coupon_title;
	}
	public void setCoupon_title(String coupon_title) {
		this.coupon_title = coupon_title;
	}
	public String getCoupon_content() {
		return coupon_content;
	}
	public void setCoupon_content(String coupon_content) {
		this.coupon_content = coupon_content;
	}
	public String getCoupon_image() {
		return coupon_image;
	}
	public void setCoupon_image(String coupon_image) {
		this.coupon_image = coupon_image;
	}
	public Date getCoupon_issue_start() {
		return coupon_issue_start;
	}
	public void setCoupon_issue_start(Date coupon_issue_start) {
		this.coupon_issue_start = coupon_issue_start;
	}
	public Date getCoupon_issue_end() {
		return coupon_issue_end;
	}
	public void setCoupon_issue_end(Date coupon_issue_end) {
		this.coupon_issue_end = coupon_issue_end;
	}
	public Date getCoupon_use_end() {
		return coupon_use_end;
	}
	public void setCoupon_use_end(Date coupon_use_end) {
		this.coupon_use_end = coupon_use_end;
	}
	public int getCoupon_discount() {
		return coupon_discount;
	}
	public void setCoupon_discount(int coupon_discount) {
		this.coupon_discount = coupon_discount;
	}
	public int getCoupon_amount() {
		return coupon_amount;
	}
	public void setCoupon_amount(int coupon_amount) {
		this.coupon_amount = coupon_amount;
	}
	public String getCoupon_status() {
		return coupon_status;
	}
	public void setCoupon_status(String coupon_status) {
		this.coupon_status = coupon_status;
	}
	@Override
	public String toString() {
		return "CouponDto [coupon_id=" + coupon_id + ", coupon_title=" + coupon_title + ", coupon_content="
				+ coupon_content + ", coupon_image=" + coupon_image + ", coupon_issue_start=" + coupon_issue_start
				+ ", coupon_issue_end=" + coupon_issue_end + ", coupon_use_end=" + coupon_use_end + ", coupon_discount="
				+ coupon_discount + ", coupon_amount=" + coupon_amount + ", coupon_status=" + coupon_status + "]";
	}
	
}