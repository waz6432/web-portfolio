package com.ja.travel.travelApplication.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ja.travel.dto.PlanDayDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.PlanPlaceDto;
import com.ja.travel.dto.PlanningApplicationDto;
import com.ja.travel.dto.PlanningChatDto;
import com.ja.travel.dto.PlanningComment;
import com.ja.travel.dto.PlanningCommentLove;
import com.ja.travel.dto.PlanningDto;
import com.ja.travel.dto.TravelApplicationRequestDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.dto.UserReportDto;

public interface TravelApplicationSqlMapper {

	public PlanningDto getPlanningByPlanningId(int planning_id);

	// 플래닝 인서트 및 업데이트
	public int createPlanningPK();
	public void insertPlanningData(PlanningDto planningDto);
	public void insertMyInfoWhenRecruting(PlanningDto planningDto);
	public void updateToRecruiting(PlanningDto planningDto);
	
	public void insertPlanningApplicationParty(PlanningApplicationDto planningApplicationDto);

	public List<UserDto> getPlanningAcceptCountByPlanningId(int planning_id);

	public PlanningApplicationDto getApplicationStatus(PlanningApplicationDto planningApplicationDto);

	public void acceptApplicationaStatusByUser(PlanningApplicationDto planningApplicationDto);

	public void refusalApplicationaStatusByUser(PlanningApplicationDto planningApplicationDto);

	public PlanningDto getPlanStatusByPlanId(int plan_id);

	public void updatePlanningData(PlanningDto planningDto);

	// 페이징 처리
	public List<PlanningDto> getPlanningList(TravelApplicationRequestDto travelApplicationRequestDto);
	public int getPlanningCount(@Param("searchWord") String searchWord);

	// 플랜별 일차에 대한 명소
	public PlanDto getPlanByPlanningId(int planning_id);
	public List<PlanDayDto> getPlanDayByPlanId(int plan_id);
	public List<PlanPlaceDto> getPlaceByPlanId(PlanDayDto planDay);
	public UserDto getUserByPlanningId(int planning_id);

	// 디테일 페이지 댓글 부분
	public void createInitComment(PlanningComment planningComment);
	public List<PlanningComment> getCommentList(int planning_id);
	public UserDto getUserOfCommentByPlanningId(int planning_comment_id);
	public void addLike(PlanningCommentLove planningCommentLove);
	public void deleteLike(PlanningCommentLove planningCommentLove);
	public PlanningCommentLove getLikeByCommentIdAndUserId(PlanningCommentLove planningCommentLove);
	public int getTotalLike(int planning_comment_id);

	// 플래닝 채팅 처리
	public List<PlanningChatDto> getChatList(PlanningChatDto planningChatDto);
	public void insertMessage(PlanningChatDto planningChatDto);
	
	public List<PlanDto> getRecursiveList(PlanningDto planningDto);
	
	public List<PlanningDto> getLatestPlanningList(int planning_id);

}
