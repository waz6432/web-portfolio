package com.ja.travel.dto;

public class GuideDenyDto {

	private int guide_deny_id;
	private int guide_restrict_id;
	private int admin_id;
	private String guide_deny_title;
	private String guide_deny_content;
	private String guide_deny_attached;
	private String guide_deny_message;
	public GuideDenyDto() {
		super();
	}
	public GuideDenyDto(int guide_deny_id, int guide_restrict_id, int admin_id, String guide_deny_title,
			String guide_deny_content, String guide_deny_attached, String guide_deny_message) {
		super();
		this.guide_deny_id = guide_deny_id;
		this.guide_restrict_id = guide_restrict_id;
		this.admin_id = admin_id;
		this.guide_deny_title = guide_deny_title;
		this.guide_deny_content = guide_deny_content;
		this.guide_deny_attached = guide_deny_attached;
		this.guide_deny_message = guide_deny_message;
	}
	public int getGuide_deny_id() {
		return guide_deny_id;
	}
	public void setGuide_deny_id(int guide_deny_id) {
		this.guide_deny_id = guide_deny_id;
	}
	public int getGuide_restrict_id() {
		return guide_restrict_id;
	}
	public void setGuide_restrict_id(int guide_restrict_id) {
		this.guide_restrict_id = guide_restrict_id;
	}
	public int getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(int admin_id) {
		this.admin_id = admin_id;
	}
	public String getGuide_deny_title() {
		return guide_deny_title;
	}
	public void setGuide_deny_title(String guide_deny_title) {
		this.guide_deny_title = guide_deny_title;
	}
	public String getGuide_deny_content() {
		return guide_deny_content;
	}
	public void setGuide_deny_content(String guide_deny_content) {
		this.guide_deny_content = guide_deny_content;
	}
	public String getGuide_deny_attached() {
		return guide_deny_attached;
	}
	public void setGuide_deny_attached(String guide_deny_attached) {
		this.guide_deny_attached = guide_deny_attached;
	}
	public String getGuide_deny_message() {
		return guide_deny_message;
	}
	public void setGuide_deny_message(String guide_deny_message) {
		this.guide_deny_message = guide_deny_message;
	}
	@Override
	public String toString() {
		return "GuideDenyDto [guide_deny_id=" + guide_deny_id + ", guide_restrict_id=" + guide_restrict_id
				+ ", admin_id=" + admin_id + ", guide_deny_title=" + guide_deny_title + ", guide_deny_content="
				+ guide_deny_content + ", guide_deny_attached=" + guide_deny_attached + ", guide_deny_message="
				+ guide_deny_message + "]";
	}
	
	
}
