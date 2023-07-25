package com.ja.travel.dto;

public class PlanDayDto {

	    private int plan_day_id, plan_id, plan_day;

		public PlanDayDto() {
			super();
		}

		public PlanDayDto(int plan_day_id, int plan_id, int plan_day) {
			super();
			this.plan_day_id = plan_day_id;
			this.plan_id = plan_id;
			this.plan_day = plan_day;
		}

		public int getPlan_day_id() {
			return plan_day_id;
		}

		public void setPlan_day_id(int plan_day_id) {
			this.plan_day_id = plan_day_id;
		}

		public int getPlan_id() {
			return plan_id;
		}

		public void setPlan_id(int plan_id) {
			this.plan_id = plan_id;
		}

		public int getPlan_day() {
			return plan_day;
		}

		public void setPlan_day(int plan_day) {
			this.plan_day = plan_day;
		}

		@Override
		public String toString() {
			return "PlanDayDto [plan_day_id=" + plan_day_id + ", plan_id=" + plan_id + ", plan_day=" + plan_day + "]";
		}
		
}
