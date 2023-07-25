package com.ja.travel.dto;

public class PlanningCommentLove {
	private int planning_comment_love_id;
	private int planning_comment_id;
	private int user_id;

	public PlanningCommentLove() {
		super();
	}

	public PlanningCommentLove(int planning_comment_love_id, int planning_comment_id, int user_id) {
		this.planning_comment_love_id = planning_comment_love_id;
		this.planning_comment_id = planning_comment_id;
		this.user_id = user_id;
	}

	public int getPlanning_comment_love_id() {
		return planning_comment_love_id;
	}

	public void setPlanning_comment_love_id(int planning_comment_love_id) {
		this.planning_comment_love_id = planning_comment_love_id;
	}

	public int getPlanning_comment_id() {
		return planning_comment_id;
	}

	public void setPlanning_comment_id(int planning_comment_id) {
		this.planning_comment_id = planning_comment_id;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	@Override
	public String toString() {
		return "PlanningCommentLove{" + "planning_comment_love_id=" + planning_comment_love_id
				+ ", planning_comment_id=" + planning_comment_id + ", user_id=" + user_id + '}';
	}
}