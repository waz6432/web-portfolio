package com.ja.travel.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ja.travel.dto.GuideDto;
import com.ja.travel.dto.GuidePlanningDto;
import com.ja.travel.dto.GuideReportDto;
import com.ja.travel.dto.GuideRestrictDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.PlanningApplicationDto;
import com.ja.travel.dto.PlanningDto;

@Mapper
public interface MainSqlMapper {

	public List<PlanDto> getPlanList(int userId);

	public GuideDto getGuideDtoByUserId(int  userId);
	
	public List<GuideRestrictDto> getGuideRestrictDtoByGuideId(int guideId);

	public GuideReportDto getGuideReportDtoByGuideReportId(int guideReportId);

	public GuidePlanningDto getGuidePlanningDtoByGuidePlanningId(int guidePlanningId);

	public PlanDto getPlanDtoByPlanId(int planId);
	
	public List<PlanningDto> getMyPlanningList(int user_id);
	
	public List<PlanningApplicationDto> getApplicationList(int user_id);
}
