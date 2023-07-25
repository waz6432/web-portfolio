package com.ja.travel.guidePackage.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ja.travel.dto.CouponDto;
import com.ja.travel.dto.GuideDto;
import com.ja.travel.dto.GuidePlanPaymentDto;
import com.ja.travel.dto.GuidePlanningApplicationDto;
import com.ja.travel.dto.GuidePlanningComment;
import com.ja.travel.dto.GuidePlanningCommentLove;
import com.ja.travel.dto.GuidePlanningDto;
import com.ja.travel.dto.PlanCityDto;
import com.ja.travel.dto.PlanDayDto;
import com.ja.travel.dto.PlanDto;
import com.ja.travel.dto.PlanPlaceDto;
import com.ja.travel.dto.UserCouponDto;
import com.ja.travel.dto.UserDto;

public interface PackageSqlMapper {
	
	public GuidePlanningDto getPlanAndGuidePlanningInfoByPlanId(int plan_id);

	public int createGuidePlanningPK();

	public void insertGuidePlanningData(GuidePlanningDto guidePlanningDto);

	public void updateToRecruiting(GuidePlanningDto guidePlanningDto);

	public void updateToPlanning(GuidePlanningDto guidePlanningDto);

	public void updateGuidePlanningData(GuidePlanningDto guidePlanningDto);

	public void insertMyInfoWhenRecruting(GuidePlanningApplicationDto guidePlanningApplicationDto);

	public List<GuidePlanningDto> getGuidePlanningList(@Param("pageNum") int pageNum,
			@Param("searchType") String searchType,
			@Param("searchWord") String searchWord,
			@Param("user_id") int user_id);

	public int getUserIdFromGuidePlanning(GuidePlanningDto guidePlanning);

	public List<GuidePlanningApplicationDto> getGuidePlanningAcceptCountByGuidePlanningId(int guide_planning_id);

	public void acceptGuideApplicationaStatusByUser(GuidePlanningApplicationDto guidePlanningApplicationDto);

	public void refusalGuideApplicationaStatusByUser(GuidePlanningApplicationDto guidePlanningApplicationDto);

	public GuidePlanningApplicationDto getApplicationStatus(GuidePlanningApplicationDto guidePlanningApplicationDto);

	public GuidePlanningDto getGuidePlanningByGuidePlanningId(int guide_planning_id);

	public List<PlanDayDto> getPlanDay(int plan_id);

	public List<PlanPlaceDto> getPlaceByPlanId(PlanDayDto planDay);

	public PlanDto getPlanByGuidePlanningId(int guide_planning_id);

	public UserDto getUserByGuidePlanningId(int guide_planning_id);

	public List<PlanDayDto> getPlanDayByPlanId(int plan_id);

	public PlanCityDto getCityByPlace(int plan_city_id);
	
// 결제 관련

	public int createGuideAppPk();

	public GuidePlanningDto getPackage(int guide_planning_id);

	public int createPackagePayPk();

	public void insertGuidePay(GuidePlanPaymentDto guidePlanPaymentDto);

	public GuideDto getGuideInfoByGuidePlanningId(int guide_id);

	public List<UserCouponDto> getMyCouponList(int user_id);

	public CouponDto getCouponInfo(int couponId);
	
	//////////////////

	public void createInitComment(GuidePlanningComment guidePlanningComment);

	public GuidePlanningCommentLove getLikeByCommentIdAndUserId(GuidePlanningCommentLove guidePlanningCommentLove);

	public void deleteLike(GuidePlanningCommentLove guidePlanningCommentLove);

	public void addLike(GuidePlanningCommentLove guidePlanningCommentLove);

	public List<GuidePlanningComment> getCommentList(int guide_planning_id);

	public UserDto getUserOfCommentByPlanningId(int guide_planning_comment_id);

	public int getTotalLike(int guide_planning_comment_id);

	

	
	
	

	

}
