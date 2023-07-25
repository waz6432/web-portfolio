package com.ja.travel.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class GuidePlanPaymentDto {
	private int guide_plan_payment_id, planning_application_id,user_planning_deposit;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date guide_planning_payment_date;
	private String user_name, deposit_bank;
	
	public GuidePlanPaymentDto() {
		super();
	}
	public GuidePlanPaymentDto(int guide_plan_payment_id, int planning_application_id, int user_planning_deposit,
			Date guide_planning_payment_date, String user_name, String deposit_bank) {
		super();
		this.guide_plan_payment_id = guide_plan_payment_id;
		this.planning_application_id = planning_application_id;
		this.user_planning_deposit = user_planning_deposit;
		this.guide_planning_payment_date = guide_planning_payment_date;
		this.user_name = user_name;
		this.deposit_bank = deposit_bank;
	}
	public int getGuide_plan_payment_id() {
		return guide_plan_payment_id;
	}
	public void setGuide_plan_payment_id(int guide_plan_payment_id) {
		this.guide_plan_payment_id = guide_plan_payment_id;
	}
	public int getPlanning_application_id() {
		return planning_application_id;
	}
	public void setPlanning_application_id(int planning_application_id) {
		this.planning_application_id = planning_application_id;
	}
	public int getUser_planning_deposit() {
		return user_planning_deposit;
	}
	public void setUser_planning_deposit(int user_planning_deposit) {
		this.user_planning_deposit = user_planning_deposit;
	}
	public Date getGuide_planning_payment_date() {
		return guide_planning_payment_date;
	}
	public void setGuide_planning_payment_date(Date guide_planning_payment_date) {
		this.guide_planning_payment_date = guide_planning_payment_date;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getDeposit_bank() {
		return deposit_bank;
	}
	public void setDeposit_bank(String deposit_bank) {
		this.deposit_bank = deposit_bank;
	}
	@Override
	public String toString() {
		return "GuidePlanPaymentDto [guide_plan_payment_id=" + guide_plan_payment_id + ", planning_application_id="
				+ planning_application_id + ", user_planning_deposit=" + user_planning_deposit
				+ ", guide_planning_payment_date=" + guide_planning_payment_date + ", user_name=" + user_name
				+ ", deposit_bank=" + deposit_bank + "]";
	}
	
	

}
