package com.ja.travel.dto;





public class GuidePlanningApplicationDto {
	
	private int guide_planning_application_id, user_id, guide_planning_id;
	
	private String guide_planning_application_co, guide_planning_member_status;

	public int getGuide_planning_application_id() {
		return guide_planning_application_id;
	}

	public void setGuide_planning_application_id(int guide_planning_application_id) {
		this.guide_planning_application_id = guide_planning_application_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getGuide_planning_id() {
		return guide_planning_id;
	}

	public void setGuide_planning_id(int guide_planning_id) {
		this.guide_planning_id = guide_planning_id;
	}

	public String getguide_planning_application_co() {
		return guide_planning_application_co;
	}

	public void setguide_planning_application_co(String guide_planning_application_co) {
		this.guide_planning_application_co = guide_planning_application_co;
	}

	public String getGuide_planning_member_status() {
		return guide_planning_member_status;
	}

	public void setGuide_planning_member_status(String guide_planning_member_status) {
		this.guide_planning_member_status = guide_planning_member_status;
	}
	
	

	public GuidePlanningApplicationDto() {
		super();
	}

	public GuidePlanningApplicationDto(int guide_planning_application_id, int user_id, int guide_planning_id,
			String guide_planning_application_co, String guide_planning_member_status) {
		super();
		this.guide_planning_application_id = guide_planning_application_id;
		this.user_id = user_id;
		this.guide_planning_id = guide_planning_id;
		this.guide_planning_application_co = guide_planning_application_co;
		this.guide_planning_member_status = guide_planning_member_status;
	}

	@Override
	public String toString() {
		return "GuidePlanningApplicationDto [guide_planning_application_id=" + guide_planning_application_id
				+ ", user_id=" + user_id + ", guide_planning_id=" + guide_planning_id
				+ ", guide_planning_application_co=" + guide_planning_application_co
				+ ", guide_planning_member_status=" + guide_planning_member_status + "]";
	}
	
	

	
	
}