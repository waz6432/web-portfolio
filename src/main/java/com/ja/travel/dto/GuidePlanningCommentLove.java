package com.ja.travel.dto;

public class GuidePlanningCommentLove {
	
	private int guide_planning_comment_love_id;
	private int guide_planning_comment_id;
	private int user_id;
	public GuidePlanningCommentLove() {
		super();
	}
	public GuidePlanningCommentLove(int guide_planning_comment_love_id, int guide_planning_comment_id, int user_id) {
		super();
		this.guide_planning_comment_love_id = guide_planning_comment_love_id;
		this.guide_planning_comment_id = guide_planning_comment_id;
		this.user_id = user_id;
	}
	public int getGuide_planning_comment_love_id() {
		return guide_planning_comment_love_id;
	}
	public void setGuide_planning_comment_love_id(int guide_planning_comment_love_id) {
		this.guide_planning_comment_love_id = guide_planning_comment_love_id;
	}
	public int getGuide_planning_comment_id() {
		return guide_planning_comment_id;
	}
	public void setGuide_planning_comment_id(int guide_planning_comment_id) {
		this.guide_planning_comment_id = guide_planning_comment_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	
	
	
	
	
}
