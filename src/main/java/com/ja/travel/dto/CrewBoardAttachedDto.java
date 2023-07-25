package com.ja.travel.dto;

public class CrewBoardAttachedDto {
	private int crew_board_attached_id;
	private int crew_board_id;
	private String crew_board_attached;
	private String crew_board_original_attached;
	
	public CrewBoardAttachedDto(int crew_board_attached_id, int crew_board_id, String crew_board_attached, String crew_board_original_attached) {
		super();
		this.crew_board_attached_id = crew_board_attached_id;
		this.crew_board_id = crew_board_id;
		this.crew_board_attached = crew_board_attached;
		this.crew_board_original_attached = crew_board_original_attached;
	}

	public CrewBoardAttachedDto() {
		super();
	}
	public int getCrew_board_attached_id() {
		return crew_board_attached_id;
	}
	public void setCrew_board_attached_id(int crew_board_attached_id) {
		this.crew_board_attached_id = crew_board_attached_id;
	}
	public int getCrew_board_id() {
		return crew_board_id;
	}
	public void setCrew_board_id(int crew_board_id) {
		this.crew_board_id = crew_board_id;
	}
	public String getCrew_board_attached() {
		return crew_board_attached;
	}
	public void setCrew_board_attached(String crew_board_attached) {
		this.crew_board_attached = crew_board_attached;
	}

	public String getCrew_board_original_attached() {
		return crew_board_original_attached;
	}

	public void setCrew_board_original_attached(String crew_board_original_attached) {
		this.crew_board_original_attached = crew_board_original_attached;
	}

	@Override
	public String toString() {
		return "CrewBoardAttachedDto [crew_board_attached_id=" + crew_board_attached_id + ", crew_board_id="
				+ crew_board_id + ", crew_board_attached=" + crew_board_attached + ", crew_board_original_attached="
				+ crew_board_original_attached + "]";
	}
	
	
}
