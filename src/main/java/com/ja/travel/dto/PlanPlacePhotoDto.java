package com.ja.travel.dto;

public class PlanPlacePhotoDto {

	private int plan_place_photo_id;
	private int plan_place_id;
	private String plan_place_photo_link;

	public PlanPlacePhotoDto() {
		super();
	}

	public PlanPlacePhotoDto(int plan_place_photo_id, int plan_place_id, String plan_place_photo_link) {
		super();
		this.plan_place_photo_id = plan_place_photo_id;
		this.plan_place_id = plan_place_id;
		this.plan_place_photo_link = plan_place_photo_link;
	}

	public int getPlan_place_photo_id() {
		return plan_place_photo_id;
	}

	public void setPlan_place_photo_id(int plan_place_photo_id) {
		this.plan_place_photo_id = plan_place_photo_id;
	}

	public int getPlan_place_id() {
		return plan_place_id;
	}

	public void setPlan_place_id(int plan_place_id) {
		this.plan_place_id = plan_place_id;
	}

	public String getPlan_place_photo_link() {
		return plan_place_photo_link;
	}

	public void setPlan_place_photo_link(String plan_place_photo_link) {
		this.plan_place_photo_link = plan_place_photo_link;
	}

	@Override
	public String toString() {
		return "PlanPlacePhotoDto [plan_place_photo_id=" + plan_place_photo_id + ", plan_place_id=" + plan_place_id
				+ ", plan_place_photo_link=" + plan_place_photo_link + "]";
	}

}
