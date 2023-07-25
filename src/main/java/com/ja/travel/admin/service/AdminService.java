package com.ja.travel.admin.service;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ja.travel.admin.mapper.AdminSqlMapper;
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

@Service
public class AdminService {

	@Autowired
	private AdminSqlMapper adminSqlMapper;
	
	public AdminDto getIdAndPw(AdminDto adminDto) {
		AdminDto sessionUser = adminSqlMapper.getIdAndPw(adminDto);
		
		return sessionUser;
	}
	

	
	
	public void setCity(PlanCityDto planCityDto) {
		int id = adminSqlMapper.createPk();
		planCityDto.setPlan_city_id(id);
		adminSqlMapper.setCity(planCityDto);
	}
	
	public List<PlanCityDto> getAllCity() {
		
		List<PlanCityDto> list = adminSqlMapper.selectAllCity();

		return list;
	}
	

	
	public void updateCity(PlanCityDto planCityDto) {
		
		adminSqlMapper.updateCity(planCityDto);
	}

	public void deleteCity(int id) {
		
		adminSqlMapper.deleteCityById(id);
	}
	
	public List<Map<String, Object>> selectAllApply(){
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		List<GuideApplyDto> applylist = adminSqlMapper.selectAllApply();
		for(GuideApplyDto guideApplyDto : applylist) {
			Map<String, Object> map = new HashMap<>();
			int userId = guideApplyDto.getUser_id();
			UserDto userDto = adminSqlMapper.getUserDtoByUserId(userId);
			map.put("guideApplyDto", guideApplyDto);
			map.put("userDto", userDto);
			
			list.add(map);
		}
	
		return list;
	}
	
	public Map<String, Object> selectGuideApply(int id) {
			
		GuideApplyDto guideApplyDto = adminSqlMapper.selectGuideApplyById(id);
		int userId = guideApplyDto.getUser_id();
		UserDto userDto = adminSqlMapper.getUserDtoByUserId(userId);
		GuideDto guideDto = adminSqlMapper.getGuideByUserId(userId);
		Map<String, Object> map = new HashMap<>();
		map.put("guideApplyDto", guideApplyDto);
		map.put("userDto", userDto);
		map.put("guideDto", guideDto);
		
		return map;
	}
	
	public void updateGuideApply(GuideApplyDto guideApplyDto) {
		GuideDto guideDto = new GuideDto();
		 guideDto.setUser_id(guideApplyDto.getUser_id());
		GuideDto guide = adminSqlMapper.checkUser(guideDto);
		if(guide != null) {
			return;
		} else {
		adminSqlMapper.updateGuideApply(guideApplyDto);
		}
	}
	
	public void insertGuide(GuideDto guideDto) {
	
		GuideDto guide = adminSqlMapper.checkUser(guideDto);
		if(guide != null) {
			return;
		} else {
		int guideId = adminSqlMapper.createGuidePk();
		guideDto.setGuide_id(guideId);
		adminSqlMapper.insertGuide(guideDto);
		
		}
		
	}
	

	public void updateGuideReject(GuideApplyDto guideApplyDto) {
		
		adminSqlMapper.updateGuideReject(guideApplyDto);
		
	}
	

	public List<Map<String, Object>> getUserReportList() {
		
		List<Map<String, Object>> list = new ArrayList<>(); 
		
		List<UserReportDto> userReportList = adminSqlMapper.getUserReportList();
		for(UserReportDto userReportDto : userReportList) {
			Map<String, Object> map = new HashMap<>();
			int userId = userReportDto.getUser_id();
			UserDto reportingUserDto = adminSqlMapper.getUserDtoByUserId(userId);
			System.out.println(reportingUserDto.getUser_id());
			int reportedUserId = userReportDto.getReported_user_id();
			UserDto reportedUserDto = adminSqlMapper.getUserDtoByReportedUserId(reportedUserId);
			System.out.println(reportedUserId);
			System.out.println(reportedUserDto.getUser_email());
			map.put("userReportDto", userReportDto);
			map.put("reportingUserDto", reportingUserDto);
			map.put("reportedUserDto", reportedUserDto);
			list.add(map);
		}
		
		return list;
		
	}
	
	public Map<String, Object> getUserReport(int id) {
		Map<String, Object> map = new HashMap<>();
		
		List<UserReportDto> list = adminSqlMapper.getUserReportDtoListByUserReportId(id);
		UserReportDto userReportDto = adminSqlMapper.getUserReportDtoByUserReportId(id);
		int reportedUserId = userReportDto.getReported_user_id();
		UserDto reportedUserDto = adminSqlMapper.getUserDtoByReportedUserId(reportedUserId);
		MemberRestrictDto memberRestrictDto = adminSqlMapper.getMemberRestrictDtoByUserReportId(id);
		map.put("userReportDto", userReportDto);
		map.put("reportedUserDto",reportedUserDto);
		map.put("memberRestrictDto", memberRestrictDto);
		map.put("list", list);
		
		return map;
		
	}
	
	public void restrictUser(MemberRestrictDto memberRestrictDto, String user_report_status) {
		int user_restrict_id = adminSqlMapper.createUserRestrictPk();
		memberRestrictDto.setUser_restrict_id(user_restrict_id);
		adminSqlMapper.insertRestrictUser(memberRestrictDto);
		
		int id = memberRestrictDto.getUser_report_id();
		int admin_id = memberRestrictDto.getAdmin_id();
		
		UserReportDto userReportDto = new UserReportDto();
		userReportDto.setAdmin_id(admin_id);
		userReportDto.setUser_report_id(id);
		userReportDto.setUser_report_status(user_report_status);
		adminSqlMapper.updateUserReport(userReportDto);
	}

	public List<Map<String, Object>> getReportedGuideList() {
		
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		List<GuideReportDto> guideReportList = adminSqlMapper.getReportedGuideList();
		
		for(GuideReportDto guideReportDto : guideReportList) {
			
			Map<String, Object> map = new HashMap<>();
			
			int userId = guideReportDto.getUser_id();
			UserDto reportingUserDto = adminSqlMapper.getUserDtoByUserId(userId);
			int guidePlanningId = guideReportDto.getGuide_planning_id();
			GuidePlanningDto guidePlanningDto = adminSqlMapper.getGuidePlanningDtoById(guidePlanningId);
			int guideId = guidePlanningDto.getGuide_id();
			GuideDto guideDto = adminSqlMapper.getGuideDtoByGuideId(guideId);
			userId = guideDto.getUser_id();
			UserDto guideUserDto = adminSqlMapper.getUserDtoByUserId(userId);
			
			map.put("guideReportDto", guideReportDto);
			map.put("reportingUserDto", reportingUserDto);
			map.put("guideUserDto", guideUserDto);
			
			list.add(map);
		}
	
			return list;
	}
	
	public Map<String, Object> getGuideReportById(int id) {
		
		Map<String, Object> map = new HashMap<>();
		
		GuideReportDto guideReportDto =	adminSqlMapper.getGuideReportDtoById(id);
		int guideReportId = guideReportDto.getGuide_report_id();
		GuideRestrictDto guideRestrictDto = adminSqlMapper.getGuideRestrictDtoByGuideReportId(guideReportId);
		int guidePlanningId = guideReportDto.getGuide_planning_id();
		GuidePlanningDto guidePlanningDto = adminSqlMapper.getGuidePlanningDtoById(guidePlanningId);
		int guideId = guidePlanningDto.getGuide_id();
		GuideDto guideDto = adminSqlMapper.getGuideDtoByGuideId(guideId);
		int userId = guideDto.getUser_id();
		UserDto guideUserDto = adminSqlMapper.getUserDtoByUserId(userId);
		
		map.put("guideUserDto", guideUserDto);
		map.put("guidePlanningDto", guidePlanningDto);
		map.put("guideReportDto", guideReportDto);
		map.put("guideDto", guideDto);
		map.put("guideRestrictDto", guideRestrictDto);
		
		return map;
	}
	
	public void restrictGuide(GuideRestrictDto guideRestrictDto, String guide_report_status, int guide_planning_id) {
		
		int guide_restrict_id = adminSqlMapper.createRestrictGuidePk();
		
		guideRestrictDto.setPlan_id(guide_planning_id);
		
		guideRestrictDto.setGuide_restrict_id(guide_restrict_id);
		
		adminSqlMapper.insertGuideRestrict(guideRestrictDto);
		
		GuideReportDto guideReportDto = new GuideReportDto();
		
		guideReportDto.setAdmin_id(guideRestrictDto.getAdmin_id());
		
		guideReportDto.setGuide_report_id(guideRestrictDto.getGuide_report_id());
		
		guideReportDto.setGuide_report_status(guide_report_status);
		
		
		System.out.println(guideReportDto.getAdmin_id());
		
		adminSqlMapper.updateGuideReport(guideReportDto);
		
	}




	public void registerCoupon(CouponDto couponDto) {
		
		int couponId = adminSqlMapper.createCouponPk();
		couponDto.setCoupon_id(couponId);
		adminSqlMapper.insertNewCoupon(couponDto);
		
	}




	public List<CouponDto> getAllCoupon() {
		
		List<CouponDto> list = adminSqlMapper.getCouponList();
		
		return list;
		
	}




	public CouponDto getCoupon(int id) {
		
		CouponDto couponDto = adminSqlMapper.getCouponByCouponId(id);
		
		return couponDto;
	}




	public void updateCoupon(CouponDto couponDto) {
		
		if(couponDto.getCoupon_image() == null) {
			int id = couponDto.getCoupon_id();
			CouponDto couponDto2 = adminSqlMapper.getCouponByCouponId(id);
			String couponImage = couponDto2.getCoupon_image();
			couponDto.setCoupon_image(couponImage);
		}
		adminSqlMapper.updateCoupon(couponDto);
		
	}
	
	public void userReport(UserReportDto userReport, MultipartFile[] reportImages) {
		if (reportImages != null) {

			for (MultipartFile multipartFile : reportImages) {

				if (multipartFile.isEmpty()) {
					continue;
				}

				String rootFolder = "C:/uploadFiles/reportImages/";

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

				String today = sdf.format(new Date());

				File targetFolder = new File(rootFolder + today);

				if (!targetFolder.exists()) {
					targetFolder.mkdirs();
				}

				String fileName = UUID.randomUUID().toString();

				fileName += "_" + System.currentTimeMillis();

				String originalFileName = multipartFile.getOriginalFilename();

				String ext = originalFileName.substring(originalFileName.lastIndexOf("."));

				String saveFileName = today + "/" + fileName + ext;

				try {
					multipartFile.transferTo(new File(rootFolder + saveFileName));
				} catch (Exception e) {
					e.printStackTrace();
				}

				userReport.setUser_report_attached(saveFileName);
				adminSqlMapper.insertUserReport(userReport);
			}
		}
	}
}
