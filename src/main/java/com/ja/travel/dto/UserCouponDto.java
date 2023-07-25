package com.ja.travel.dto;

public class UserCouponDto {

	private int user_coupon_id;
	private int user_id;
	private int coupon_id;
	public UserCouponDto() {
		super();
	}
	public UserCouponDto(int user_coupon_id, int user_id, int coupon_id) {
		super();
		this.user_coupon_id = user_coupon_id;
		this.user_id = user_id;
		this.coupon_id = coupon_id;
	}
	public int getUser_coupon_id() {
		return user_coupon_id;
	}
	public void setUser_coupon_id(int user_coupon_id) {
		this.user_coupon_id = user_coupon_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getCoupon_id() {
		return coupon_id;
	}
	public void setCoupon_id(int coupon_id) {
		this.coupon_id = coupon_id;
	}
	@Override
	public String toString() {
		return "UserCouponDto [user_coupon_id=" + user_coupon_id + ", user_id=" + user_id + ", coupon_id=" + coupon_id
				+ "]";
	}
	
}