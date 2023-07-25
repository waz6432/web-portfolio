package com.ja.travel.dto;

import java.util.Date;

public class GuidePlanningComment {
	
    private int guide_planning_comment_id, guide_planning_parent_co_id, guide_planning_id, user_id;
	
	private String user_comment;
	
	private Date reg_date;

	public int getGuide_planning_comment_id() {
		return guide_planning_comment_id;
	}

	public void setGuide_planning_comment_id(int guide_planning_comment_id) {
		this.guide_planning_comment_id = guide_planning_comment_id;
	}

	public int getguide_planning_parent_co_id() {
		return guide_planning_parent_co_id;
	}

	public void setguide_planning_parent_co_id(int guide_planning_parent_co_id) {
		this.guide_planning_parent_co_id = guide_planning_parent_co_id;
	}

	public int getGuide_planning_id() {
		return guide_planning_id;
	}

	public void setGuide_planning_id(int guide_planning_id) {
		this.guide_planning_id = guide_planning_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getUser_comment() {
		return user_comment;
	}

	public void setUser_comment(String user_comment) {
		this.user_comment = user_comment;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	public GuidePlanningComment() {
		super();
	}

	public GuidePlanningComment(int guide_planning_comment_id, int guide_planning_parent_co_id,
			int guide_planning_id, int user_id, String user_comment, Date reg_date) {
		super();
		this.guide_planning_comment_id = guide_planning_comment_id;
		this.guide_planning_parent_co_id = guide_planning_parent_co_id;
		this.guide_planning_id = guide_planning_id;
		this.user_id = user_id;
		this.user_comment = user_comment;
		this.reg_date = reg_date;
	}
	
	

}
