package com.ja.travel.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ja.travel.dto.AdminDto;
import com.ja.travel.dto.CouponDto;
import com.ja.travel.dto.GuideApplyDto;
import com.ja.travel.dto.GuideDto;
import com.ja.travel.dto.GuidePlanningDto;
import com.ja.travel.dto.GuideReportDto;
import com.ja.travel.dto.GuideRestrictDto;
import com.ja.travel.dto.MemberRestrictDto;
import com.ja.travel.dto.PlanCityDto;
import com.ja.travel.dto.UserDto;
import com.ja.travel.dto.UserReportDto;

@Mapper
public interface AdminSqlMapper {
	
	public AdminDto getIdAndPw(AdminDto adminDto);
		
	public int createPk();
	
	public void setCity(PlanCityDto planCityDto);
	
	public List<PlanCityDto> selectAllCity();
	
	
	public int selectBigCityNameByCityId(int id);
	
	public PlanCityDto selectCityById(int id);
	
	public void updateCity(PlanCityDto planCityDto);
	
	public void deleteCityById(int id);
	
	public List<GuideApplyDto> selectAllApply();
	
	public GuideApplyDto selectGuideApplyById(int id);
	
	public void updateGuideApply(GuideApplyDto guideApplyDto);
	
	public void insertGuide(GuideDto guideDto);
	
	public int createGuidePk();
	
	public GuideDto checkUser(GuideDto guideDto);
	
	public GuideDto getGuideByUserId(int guideId);
	
	public UserDto getUserDtoByUserId(int userId);
	
	public void updateGuideReject(GuideApplyDto guideApplyDto);
	
	public List<UserReportDto> getUserReportList();
	
	public List<UserReportDto> getUserReportDtoListByUserReportId(int id);
	
	public UserReportDto getUserReportDtoByUserReportId(int id);
	
	public UserDto getUserDtoByReportedUserId(int reportedUserId);
	
	public int createUserRestrictPk();
	
	public void insertRestrictUser(MemberRestrictDto memberRestrictDto);
	
	public void updateUserReport(UserReportDto userReportDto);
	
	public MemberRestrictDto getMemberRestrictDtoByUserReportId(int id);

	public List<GuideReportDto> getReportedGuideList();

	public GuidePlanningDto getGuidePlanningDtoById(int guidePlanningId);
	
	public GuideDto getGuideDtoByGuideId(int guideId);
	
	public GuideReportDto getGuideReportDtoById(int id);
	
	public int createRestrictGuidePk();
	
	public void insertGuideRestrict(GuideRestrictDto guideRestrictDto);
	
	public void updateGuideReport(GuideReportDto guideReportDto);

	public GuideRestrictDto getGuideRestrictDtoByGuideReportId(int guideReportId);

	public void insertNewCoupon(CouponDto couponDto);

	public int createCouponPk();

	public List<CouponDto> getCouponList();

	public CouponDto getCouponByCouponId(int id);

	public void updateCoupon(CouponDto couponDto);
	
	// 유저 리포트
	public void insertUserReport(UserReportDto userReport);
}
