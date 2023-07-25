package com.ja.travel.dto;

public class GuidePlanEvaluation {
	
	private int plan_evaluation_id, guide_planning_id, guide_plan_review_score;
	private String guide_plan_review_content;
	
	
	
	public GuidePlanEvaluation() {
		super();
	}


	public GuidePlanEvaluation(int plan_evaluation_id, int guide_planning_id, int guide_plan_review_score,
			String guide_plan_review_content) {
		super();
		this.plan_evaluation_id = plan_evaluation_id;
		this.guide_planning_id = guide_planning_id;
		this.guide_plan_review_score = guide_plan_review_score;
		this.guide_plan_review_content = guide_plan_review_content;
	}


	public int getPlan_evaluation_id() {
		return plan_evaluation_id;
	}


	public void setPlan_evaluation_id(int plan_evaluation_id) {
		this.plan_evaluation_id = plan_evaluation_id;
	}


	public int getGuide_planning_id() {
		return guide_planning_id;
	}


	public void setGuide_planning_id(int guide_planning_id) {
		this.guide_planning_id = guide_planning_id;
	}


	public int getGuide_plan_review_score() {
		return guide_plan_review_score;
	}


	public void setGuide_plan_review_score(int guide_plan_review_score) {
		this.guide_plan_review_score = guide_plan_review_score;
	}


	public String getGuide_plan_review_content() {
		return guide_plan_review_content;
	}


	public void setGuide_plan_review_content(String guide_plan_review_content) {
		this.guide_plan_review_content = guide_plan_review_content;
	}


	@Override
	public String toString() {
		return "GuidePlanEvaluation [plan_evaluation_id=" + plan_evaluation_id + ", guide_planning_id="
				+ guide_planning_id + ", guide_plan_review_score=" + guide_plan_review_score
				+ ", guide_plan_review_content=" + guide_plan_review_content + "]";
	}
	
	
	
	

}
